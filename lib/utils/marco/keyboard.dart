/// FileName keyboard
///
/// @Author 谌文
/// @Date 2025/3/24 16:35
///
/// @Description 键盘模型
class Keyboard {
  Keyboard({this.autofocus = true, this.hiddenKeyboard = true});

  /// 是否聚焦
  bool autofocus;

  /// 是否隐藏键盘
  bool hiddenKeyboard;
}
