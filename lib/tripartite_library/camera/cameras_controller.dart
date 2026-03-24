import 'dart:async';
import 'dart:io';
export 'package:camera/camera.dart';
export 'controllers/cameras_gesture_controller.dart';
export 'controllers/cameras_sharpness_controller.dart';
export 'controllers/picker_photo_controller.dart';
export 'controllers/cameras_photo_controller.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
export '../../../../base/base_controller.dart';
import '../../base/base_controller.dart';
import '../../utils/authority/camera_authority.dart';
export 'mixin/camera_pattern_mixin.dart';
import '../image_picker/images_picker.dart';
import 'camera_engine/camera_engine.dart';
import 'mixin/camera_photo_mixin.dart';
import 'mixin/camera_tap_mixin.dart';
import 'mixin/scan_page_close_mixin.dart';
import 'model/camera_zoom.dart';
import 'model/photo_model.dart';
import 'model/photo_zoom.dart';
import 'view/scan_animation.dart';
export 'config/sharpness_config.dart';
export 'view_model/camera_vm.dart';

/// FileName cameras_controller
///
/// @Author 谌文
/// @Date 2023/11/9 17:21
///
/// @Description 相机封装控制器类
class CamerasController extends BaseController
    with
        GetSingleTickerProviderStateMixin,
        CameraScanMixin,
        CameraPhotoMixin,
        CameraPatternMixin,
        ScanPageCloseMixin,
        CameraTapMixin {
  CameraEngine? cameraEngine;
  late CameraDescription camera;
  BarcodeScanner? scanner;

  static List<CameraDescription> cameras = [];

  /// 安卓暂停扫描又重新开启扫描会返回上次的结果，这个值用于最近10次内的结果不会调
  var _num = 0;

  /// 用于扫描出图片后，识别二维码，这个识别过程比较好内存，正在识别时，先暂停其他识别
  var scannerIng = false;

  /// 相机模型
  var cameraVM = CameraVM();

  /// 相机放大缩小模型
  CameraZoom zoom = CameraZoom();

  /// 图片放大缩小模型
  PhotoZoom photoZoom = PhotoZoom();

  /// 扫描动画配置
  late ScanAnimation scanAnimation;

  /// 扫描回调
  CameraScanCallBack? scanCall;

  /// 系统拍照相机
  ImagesPicker picker = ImagesPicker();

  @override
  void onInit() async {
    super.onInit();
    scanAnimation = ScanAnimation(vsync: this);

    if (obtainCameraPattern() == CameraPattern.pickerPhotoPattern) {
      await switchTakePictureMode();
    } else {
      await cameraVM.sharpness?.getUserSharpnessConfig();

      /// 如果是用手机原相机拍照，则扫描统一使用ResolutionPreset.high清晰度
      cameraVM.sharpness?.sharpnessByCameraPattern(obtainCameraPattern());

      /// 初始化回调参数
      _initCallbackArguments();

      /// 初始化相机
      await initCameraEngine(preset: cameraVM.sharpness?.preset);

      /// 是否是拍照模式
      if (obtainCameraPattern() == CameraPattern.photoPattern) {
        await switchTakePictureMode();
      }
    }
  }

  @override
  void onClose() async {
    /// 为啥不直接放在一个try里面呢，因为你自己想吧，不告诉你
    try {
      scanner?.close();
      scanAnimation.dealloc();
      scanCall = null;
    } catch (_) {}
    try {
      cameraEngine?.stopImageStream();
    } catch (_) {}
    cameraEngine?.dispose();
    cameraEngine = null;
    super.onClose();
  }

  /// 初始化回调参数
  void _initCallbackArguments() {
    if (Get.arguments != null && Get.arguments is CameraScanCallBack) {
      scanCall = Get.arguments as CameraScanCallBack;
      title = scanCall?.title ?? '';

      /// 启动扫描
      scanCall?.startScanCall = startScan;

      /// 关闭扫描 流也停止了
      scanCall?.closeScanCall = closeScan;

      /// 停止扫描
      scanCall?.stopScanCall = stopScan;

      /// 恢复扫描
      scanCall?.resumeScanCall = resumeScan;

      /// 关闭扫描页面
      scanCall?.closeScanPageCall = closeScanPage;

      /// 修改相机
      scanCall?.changeCameraCall =
          () => changeCamera(preset: cameraVM.sharpness?.preset);
    }
  }

  /// 初始化相机
  Future initCameraEngine({ResolutionPreset? preset}) async {
    cameraVM.cameraInitialized.value = false;
    bool permission = await CameraAuthority.requestCameraAuthority();
    if (!permission) return;
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    if (cameras.isEmpty) return;
    cameraVM.cameraIndex = CameraDrive.getCameraBackIndex(cameras);
    camera = cameras[cameraVM.cameraIndex];
    try {
      cameraEngine = CameraEngine(
        camera,
        preset ?? ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      await cameraEngine?.initialize().then((_) async {
        cameraVM.cameraInitialized.value = true;
        cameraVM.cameraType?.refresh();
        await startScan();
      });
    } catch (e, s) {

    }
    return cameraEngine;
  }

  /// 修改相机
  bool changeCameraIng = false;

  Future changeCamera({ResolutionPreset? preset}) async {
    if (changeCameraIng) return;
    try {
      changeCameraIng = true;
      cameraVM.cameraInitialized.value = false;
      cameraVM.cameraIndex = (cameraVM.cameraIndex + 1) % cameras.length;
      camera = cameras[cameraVM.cameraIndex];
      cameraEngine = CameraEngine(
        camera,
        preset ?? ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      await cameraEngine?.initialize().then((_) async {
        cameraVM.cameraInitialized.value = true;
        await _openCamera();
        changeCameraIng = false;
      });
      return cameraEngine;
    } catch (e, s) {

    }
  }

  /// 启动扫描
  Future startScan() async {
    cameraVM.startScan = true;
    scanAnimation.animationController?.reset();
    await _openCamera();
  }

  /// 关闭扫描
  Future closeScan() async {
    cameraVM.startScan = false;
    scanAnimation.animationController?.stop();
    await cameraEngine?.stopImageStream();
  }

  /// 恢复扫描
  Future resumeScan() async {
    cameraVM.startScan = true;
    scanAnimation.animationController?.reset();
  }

  /// 停止扫描
  Future stopScan() async {
    cameraVM.startScan = false;
    scanAnimation.animationController?.stop();
  }

  /// 关闭扫描页面
  Future closeScanPage() async {
    try {
      await cameraEngine?.stopImageStream();
      cameraEngine?.dispose();
      cameraEngine = null;
    } catch (_) {}
    Get.back();
  }

  /// 切换闪光灯
  Future changeLight() async {
    cameraVM.lightOpen.value = !cameraVM.lightOpen.value;
    await cameraEngine?.changeLight(cameraVM.lightOpen.isTrue);
    cameraVM.lightOpen.refresh();
  }

  /// 打开相机
  Future _openCamera() async {
    final CameraEngine? controller = cameraEngine;
    if (controller == null) return null;
    try {
      scanner ??= BarcodeScanner();
      await controller
          .startImageStream(_processCameraImage)
          .then((value) => {_num = 0, scannerIng = false});
    } catch (e, s) {

    }
  }

  /// 扫描图像处理
  Future _processCameraImage(CameraImage image) async {
    cameraVM.photoModel?.cameraImage = image;
    if (_num++ < 10 || scannerIng || !cameraVM.startScan) {
      return;
    }
    try {
      final CameraEngine? controller = cameraEngine;
      if (controller == null) return null;
      final inputImage = CameraImageTool.cameraImageConvertInputImage(
          image, camera, controller);
      if (inputImage != null) {
        await _scanResult(inputImage);
      }
    } catch (e, _) {}
  }

  /// 扫描结果
  Future _scanResult(InputImage inputImage) async {
    scannerIng = true;
    var barcodes = await scanner?.processImage(inputImage);
    try {
      /// 处理扫描冷却逻辑
      if (cameraVM.handleScanCool(barcodes, scanAnimation)) return;
      if (Lists.isNotEmpty(barcodes)) {
        var barcodeList = <String>[];
        if (cameraVM.startScan) {
          for (Barcode? barcode in (barcodes ?? [])) {
            if (Strings.isNotEmpty(barcode?.rawValue)) {
              barcodeList.add(barcode?.rawValue ?? '');
            }
          }
          barcodes?.clear();
          scanCall?.scanResultCallback.call(barcodeList, []);

          /// 扫描结果
          exportScanResult(barcodeList, []);
        }
      }
    } catch (e, s) {

    } finally {
      scannerIng = false;
    }
  }

  /// 获取倒数间隔时间
  int get scanTimeInterval => cameraVM.scanTimeInterval;

  /// MARK - 扫描模式
  ///
  /// 切换成扫描模式
  Future switchScanMode() async {
    if (obtainCameraPattern() == CameraPattern.scanAndPickerPattern) {
      /// 切换成扫描模式
      await pickerScanMode();
    } else {
      await camerasScanMode();
    }
  }

  /// MARK - 拍照模式
  /// 切换到拍照样式
  Future switchTakePictureMode() async {
    if (obtainCameraPattern() == CameraPattern.photoPattern ||
        obtainCameraPattern() == CameraPattern.scanAndPhotoPattern) {
      /// cameras相机拍照模式
      await camerasPhotoMode();
    } else if (obtainCameraPattern() == CameraPattern.pickerPhotoPattern ||
        obtainCameraPattern() == CameraPattern.scanAndPickerPattern) {
      /// 原生相机拍照模式
      await pickerPhotoMode();
    }
  }

  /// MARK - CameraScanMixin
  /// 扫描结果
  @override
  void exportScanResult(List<String> list, List<String> changeList) {}

  /// MARK - CameraPhotoMixin
  /// 拍照结果
  @override
  void exportPhotoResult(PhotoModel? photoModel, bool sure) {}

  /// MARK - CameraPatternMixin
  ///
  /// 扫描模式还是相机模式
  @override
  CameraPattern obtainCameraPattern() => CameraPattern.scanPattern;

  /// MARK - ScanPageCloseMixin
  ///
  /// 点击物理返回键 默认可以关闭
  @override
  Future<bool> onWillPop() => Future(() => true);

  /// 默认可以侧滑返回
  @override
  bool get closeIosSideslip => false;

  /// 取消拍照点击
  @override
  void cancelTakeImageTap() {}

  /// 拍照点击
  @override
  void takeImageTap() {}
}
