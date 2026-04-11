/// FileName: user_info_param
///
/// @Author 谌文
/// @Date 2026/4/11 11:03
///
/// @Description 注册登录用户信息参数
class UserInfoParam {
  /// 性别：0-未知，1-男，2-女", example = "1"
  int? gender;

  /// "生日", example = "1995-06-15"
  String? birthday;

  /// "省份", example = "广东省"
  String? province;

  /// "城市", example = "深圳市"
  String? city;

  /// "区县", example = "宝安区"
  String? district;
}
