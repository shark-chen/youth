import 'package:camera/camera.dart';
import '../message/view_change_message_model.dart';
import 'base_web_view_controller.dart';

abstract class BaseCameraWebViewController extends BaseWebViewController {
  CameraController? cameraController;

  /// 切换相机
  Future changeCamera();

  ///拍照
  Future takeImage();

  ///修该模式：【takeImage：拍照，scanImage：扫描】
  Future changeMode(String val);

  ///初始化相机
  Future initCamera();

  ///暂停相机
  Future pausePreview();

  ///重启相机
  Future resumePreview();

  ///关闭相机
  Future stopCamera();

  ///显示相机
  Future showCamera();

  ///隐藏相机
  Future hideCamera();

  ///继续扫描
  Future goOnScan();

  ///修改闪光灯
  Future changeLight();

  Future changeView(ViewChangeMessageModel model);
}
