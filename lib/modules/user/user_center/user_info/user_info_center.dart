import '../user_mixin/user_mixin.dart';
import 'model/user_info_entity.dart';

/// FileName user_info_center
///
/// @Author 谌文
/// @Date 2023/12/12 11:18
///
/// @Description 用户信息数据中心
class UserInfoCenter extends BaseUser {
  static final UserInfoCenter _instance = UserInfoCenter._();

  factory UserInfoCenter() => _instance;

  UserInfoCenter._();

  /// 是否选择同意记住账户信息
  bool agreeSaveAccount = false;

  /// 用户信息模型属性
  LoginUserInfoEntity? userInfoEntity;

  @override
  Future init() async {
    super.init();
    await requestUserInfo();
  }

  @override
  void clear() {
    super.clear();
    userInfoEntity = null;
    agreeSaveAccount = false;
  }

  Future<LoginUserInfoEntity?> get userInfo async {
    userInfoEntity ??= await requestUserInfo();
    return userInfoEntity;
  }

  /// 获取用户信息接口
  Future<LoginUserInfoEntity?> requestUserInfo({bool? update}) async {
    if (userInfoEntity != null && update != true) return userInfoEntity;
    // var response = await NetWork.requestUserInfo();
    // if (response.code == 0) {
    //   succeed = true;
    //   userInfoEntity = UserInfoEntity.fromJson(response.data);
    //   return userInfoEntity;
    // }
    return null;
  }
}
