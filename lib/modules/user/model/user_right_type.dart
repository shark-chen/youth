/// FileName user_right_type
///
/// @Author 谌文
/// @Date 2024/7/25 09:28
///
/// @Description 用户权限类型
class UserRightType {
  final String value;

  const UserRightType._(this.value);

  static const UserRightType empty = UserRightType._('');

  /// 待处理 订单权限
  static const UserRightType newOrder = UserRightType._('order:newOrder');

  /// 待打单 订单权限
  static const UserRightType processOrder =
      UserRightType._('order:processOrder');

  /// 待揽收 订单权限
  static const UserRightType orderPickup = UserRightType._('order:pickUp');

  /// 已经取消订单 订单权限
  static const UserRightType cancelApplicationProcessing =
      UserRightType._('orders:cancelApplicationProcessing');

  /// 已交运 订单权限
  static const UserRightType shipOrder = UserRightType._('order:shipOrder');

  /// 已完成 订单权限
  static const UserRightType completed = UserRightType._('order:completeOrder');

  /// 静态映射
  static const Map<String, UserRightType> _rightMap = {
    '': empty,
    'order:newOrder': newOrder,
    'order:processOrder': processOrder,
    'order:pickUp': orderPickup,
    'orders:cancelApplicationProcessing': cancelApplicationProcessing,
  };

  /// 工厂方法：根据字符串获取枚举值
  factory UserRightType.fromString(String value) {
    return _rightMap[value] ?? UserRightType.empty;
  }
}
