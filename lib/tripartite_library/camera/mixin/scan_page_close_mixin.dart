/// FileName scan_page_close_mixin
///
/// @Author 谌文
/// @Date 2025/6/13 16:52
///
/// @Description 相机页面，关闭点击，协议，如 侧滑关闭，点击物理按键关闭
abstract class ScanPageCloseMixin {
  /// 点击物理返回键 默认可以关闭
  Future<bool> onWillPop();

  /// 默认可以侧滑返回
  bool get closeIosSideslip;
}
