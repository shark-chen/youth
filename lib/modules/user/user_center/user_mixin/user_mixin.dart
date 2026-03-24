
/// FileName
///
/// @Author 谌文
/// @Date 2023/12/13 13:37
///
/// @Description 用户协议
abstract class UserMinx {
  /// 初始化
  init();

  /// 更新
  update();

  /// 清空
  clear();

  /// 是否初始化成功
  abstract bool? succeed;
}

class BaseUser extends UserMinx {
  @override
  bool? succeed;

  @override
  clear() {
    succeed = false;
  }

  @override
  init() {}

  @override
  update() {}
}
