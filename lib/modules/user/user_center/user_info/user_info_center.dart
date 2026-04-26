import 'package:youth/modules/home/mine/user_info/model/user_info_entity.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/network/net/net.dart';
import '../user_mixin/user_mixin.dart';

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

  /// 用户信息模型属性
  UserInfoEntity? userInfoEntity;

  @override
  Future init() async {
    super.init();
    await requestUserInfo();
  }

  @override
  void clear() {
    super.clear();
    userInfoEntity = null;
  }

  Future<UserInfoEntity?> get userInfo async {
    userInfoEntity ??= await requestUserInfo();
    return userInfoEntity;
  }

  /// 获取用户信息接口
  Future<UserInfoEntity?> requestUserInfo({bool? update}) async {
    if (userInfoEntity != null && update != true) return userInfoEntity;
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      if(value != null) {
        userInfoEntity = value;
      }
    }).requestUserInfo<UserInfoEntity>();
    if (response.succeed) {
      userInfoEntity = response.value;
      return userInfoEntity;
    }
    return null;
  }
}
