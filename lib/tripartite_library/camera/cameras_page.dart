import '../../widget/appbar/appbar_kit.dart';
import 'cameras_controller.dart';
import 'mixin/camera_click_mixin.dart';
import 'mixin/photo_page_mixin.dart';
import 'mixin/scan_page_bar_mixin.dart';
import 'mixin/scan_page_mixin.dart';
import 'view/light_camera_view.dart';
import 'view/photo_preview_view.dart';
import 'view/photo_sure_view.dart';
import 'view/scan_animated_view.dart';
import 'view/scan_count_down_view.dart';
import 'view/switch_camera_view.dart';
import 'view/take_photo_view.dart';
import '../../../../../base/base_router_page.dart';

/// FileName cameras_page
///
/// @Author 谌文
/// @Date 2023/11/9 17:21
///
/// @Description 相机页面
// ignore: must_be_immutable
class CamerasPage<T> extends BaseRouterPage<CamerasController>
    with PhotoPageMixin, ScanPageMixin, CameraClickMixin, ScanPageBarMixin {
  /// 相机扫描自定义view
  Widget? customWidget;

  CamerasPage({Key? key, this.customWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.obtainCameraPattern() == CameraPattern.pickerPhotoPattern) {
      return Container();
    }
    return Obx(
      () => routerObserver(
        closeIosSideslip: controller.closeIosSideslip,
        onWillPop: controller.onWillPop,
        context,
        () => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: customAppBar() ?? appBar(),
          body: Listener(
            onPointerDown: controller.onPointerDown,
            onPointerUp: controller.onPointerUp,
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.transparent,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  child: Obx(
                    () => Stack(
                      fit: StackFit.expand,
                      children: controller.cameraVM.previewIng == true
                          ? photoWidgets()
                          : scanWidgets(),
                    ),
                  ),
                  behavior: HitTestBehavior.deferToChild,
                  onScaleStart: controller.handleScaleStart,
                  onScaleUpdate: controller.handleScaleUpdate,
                  onDoubleTap: controller.handleDoubleTap,
                  onTapDown: (TapDownDetails details) =>
                      controller.onViewFinderTap(details, constraints),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  /// 导航头
  AppBar? appBar() {
    if (controller.cameraVM.cameraType?.value == CameraType.scan) {
      return showScanTopBar()
          ? AppBarKit.appBar(controller.title ?? '',
              elevation: 0.0, backTap: controller.closeScanPage)
          : null;
    } else {
      return showPhotoTopBar()
          ? AppBarKit.appBar(controller.title ?? '',
              elevation: 0.0, backTap: controller.closeScanPage)
          : null;
    }
  }

  /// 相机扫描Widgets
  List<Widget> scanWidgets() {
    return [
      /// build相机预览扫描
      _buildCameraPreview(),

      /// build扫描动画
      Visibility(
        visible: controller.cameraVM.cameraType?.value == CameraType.scan,
        child:
            ScanAnimatedWidget(animation: controller.scanAnimation.animation),
      ),

      /// build相机工具，如闪光灯
      LightCameraWidget(
        open: controller.cameraVM.lightOpen.value,
        onTap: controller.changeLight,
      ),

      /// build相机工具, 前后摄像头切换 / 拍照View
      controller.cameraVM.cameraType?.value == CameraType.scan
          ? SwitchCameraWidget(
              switchTap: () async => await controller.changeCamera(
                  preset: controller.cameraVM.sharpness?.preset))
          : TakePhotoWidget(
              sharpness: controller.cameraVM.sharpness?.sharpness.value,
              showElect:
                  controller.cameraVM.sharpness?.showSharpnessElect.value,
              selectTap: (v) async => await controller.selectSharpness(v),
              selectImageTap: clickSelectImageBtn,
              sharpnessTap: controller.clickSharpness,
              takeTap: controller.takeImage,
              cancelTap: controller.cancelTakeImage,
              switchTap: () async => await controller.changeCamera(
                  preset: controller.cameraVM.sharpness?.preset),
            ),
      controller.cameraVM.cameraType?.value == CameraType.scan
          ? (scanCustomWidget() ?? (customWidget ?? Container()))
          : (photoCustomWidget() ?? Container()),

      /// 扫描倒数view
      _scanCountdownWidget(),
    ];
  }

  /// 图片预览Widgets
  List<Widget> photoWidgets() {
    return [
      PhotoPreviewView(
        path: controller.cameraVM.photoModel?.file?.path ?? '',
        image: controller.cameraVM.photoModel?.image,
        minScale: controller.photoZoom.minAvailableZoom,
        maxScale: controller.photoZoom.maxAvailableZoom,
      ),
      PhotoSureWidget(
        backTap: () {
          if (controller.cameraVM.previewPhoto) {
            controller.cameraVM.previewIng = false;
            controller.cameraVM.cameraType?.refresh();
          }
        },
        sureTap: () =>
            controller.exportPhotoResult(controller.cameraVM.photoModel, true),
      ),
    ];
  }

  /// build相机预览扫描
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Widget _buildCameraPreview() {
    return (controller.cameraVM.cameraInitialized.value &&
            controller.cameraEngine != null)
        ? CameraPreview(controller.cameraEngine!)
        : Container(color: Colors.black);
  }

  /// MARK - ScanPageMixin
  ///
  /// 扫描模式下的导航头样式
  @override
  bool showScanTopBar() => true;

  @override
  Widget? scanCustomWidget() => null;

  /// 扫描倒数view
  Widget _scanCountdownWidget() {
    return controller.cameraVM.scanCooling &&
            controller.cameraVM.cameraType?.value == CameraType.scan
        ? ScanCountdownView(milliseconds: controller.scanTimeInterval)
        : Container();
  }

  /// MARK - PhotoPageMixin
  ///
  /// 拍照模式下的导航头样式
  @override
  bool showPhotoTopBar() => true;

  @override
  Widget? photoCustomWidget() => null;

  /// MARK - ScanPageBarMixin
  ///
  /// 自定义导航头
  @override
  AppBar? customAppBar() => null;
}
