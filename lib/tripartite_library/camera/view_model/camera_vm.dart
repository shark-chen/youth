import '../cameras.dart';
import '../model/barcode_model.dart';
import '../model/photo_model.dart';
export 'camera_scan_vm.dart';

enum CameraType {
  /// 扫描模式
  scan,

  /// 拍照模式
  photo,
}

/// 相机模型控制类
class CameraVM {
  /// 摄像头是否初始化完毕(为啥要这个呢,为了比如摄像头还未初始化完毕时,page页面显示加载图,完毕了就预览摄像的控制)
  var cameraInitialized = false.obs;

  /// 摄像头索引(手机都有多个摄像头)
  var cameraIndex = 0;

  /// 闪光灯开关
  var lightOpen = false.obs;

  /// 控制扫描开始停止的
  var startScan = true;
  var scanResultList = [];

  /// 上次扫描的结果
  var lastScanResultList = <BarcodeModel>[];
  bool scanCooling = false;

  /// 扫描还是拍照模式
  Rx<CameraType>? cameraType = CameraType.scan.obs;

  /// 拍照是否需要预览
  var previewPhoto = true;

  /// 开始预览图片
  var previewIng = false;

  /// 是否展示水印
  var showTimeWatermark = false;

  /// 图片资源
  PhotoModel? photoModel = PhotoModel();

  /// 用户清晰度配置
  SharpnessConfig? sharpness;

  CameraVM({CameraType? type}) {
    cameraType?.value = type ?? CameraType.scan;
  }

  set setScanResultList(List list) {
    scanResultList = list;
  }
}

extension CameraSharpnessVM on CameraVM {
  /// 配置拍照清晰度
  Future configSharpness(SharpnessConfig sharpness) async {
    this.sharpness = sharpness;
  }

  /// 保存用户设置
  Future saveUserSharpnessConfig(SharpnessModel sharpness) async {
    await this.sharpness?.saveUserSharpnessConfig(sharpness);
  }

  /// 设置清晰度
  Future<bool> selectSharpness(int sharpness) async {
    if (sharpnessMap[sharpness] == null) return false;
    this.sharpness?.showSharpnessElect.value = false;
    if (this.sharpness?.sharpness.value == sharpness) return false;
    this.sharpness?.sharpness.value = sharpness;
    this
        .sharpness
        ?.saveUserSharpnessConfig(sharpnessMap[sharpness] ?? SharpnessModel());
    return true;
  }

  /// 设置照片显示拍照时间
  void setShowWatermark(bool? showTimeWatermarkBlo) {
    showTimeWatermark = showTimeWatermarkBlo ?? false;
  }
}
