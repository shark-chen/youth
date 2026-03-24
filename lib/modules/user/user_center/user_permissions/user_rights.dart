import 'package:youth/base/base_controller.dart';
import '../../../../network/net/entry/user/user.dart';
import '../../../../network/reporter/report_util.dart';
import '../user_mixin/user_mixin.dart';
import 'model/user_right_entity.dart';

/// FileName user_permissions
///
/// @Author 谌文
/// @Date 2023/9/20 17:20
///
/// @Description 用户权限类
class UserRights extends BaseUser {
  static final UserRights _instance = UserRights._();

  factory UserRights() => _instance;

  UserRights._();

  @override
  Future init() async {
    super.init();

    /// 请求用户权限
    await requestUserRights();
  }

  @override
  void clear() {
    super.clear();
    _userRights = [];
  }

  /// 用户拥有的权限
  List<String>? _userRights = [];

  /// 用户拥有的权限列表
  Future<List<String>> get userRights async {
    if (Lists.isNotEmpty(_userRights)) {
      return _userRights ?? <String>[];
    }
    return await requestUserRights();
  }

  /// 请求用户权限
  Future<List<String>> requestUserRights({
    ValueChanged<List<String>>? complete,
  }) async {
    var response = await Net.value<User>().cache<UserRightEntity>((value) {
      /// 处理用户权限
      if(Maps.isNotEmpty(value?.userScopeMap)) {
        _handleUserRights(value);
      }
      complete?.call(_userRights ?? []);
    }).requestUserRight<UserRightEntity>();
    if (response.success) {
      succeed = true;

      /// 处理用户权限
      final changed = _handleUserRights(response.value);
      complete?.call(_userRights ?? []);

      /// 权限是否有变化
      EventBusManager()
          .fire(UserRightsChange(userRights: _userRights, changed: changed));
    }
    if (Lists.isEmpty(_userRights)) {
      ReportUtil().record("权限列表获取失败，数据为空", ping: true);
    }
    return _userRights ?? [];
  }

  /// 处理用户权限
  bool _handleUserRights(UserRightEntity? value) {
    int? version = value?.version;
    var rights = [];
    value?.userScopeMap?.forEach((key, value) {
      /// 已经全量的权限
      if (Strings.isNotEmpty(value.value) &&
          (version ?? 0) >= (value.version ?? 0)) {
        rights.add(value.value);
      }
    });
    final changed = !Lists.arraysEqual(_userRights, rights);
    _userRights = [...rights];
    return changed;
  }

  /// 是否存在某个权限
  /// refresh: 是否需要刷新接口，获取最新数据，默认不需要
  Future<bool> hasUserRight(
    UserRightsEnum? userRight, {
    bool? refresh = false,
    ValueChanged<bool>? complete,
  }) async {
    /// 是否是主账号，主账号有全部权限
    if (UserCenter().masterAccount == true) {
      return true;
    }
    if (Lists.isEmpty(_userRights) || refresh == true) {
      return (await requestUserRights(complete: (List<String> list) {
        complete?.call(list.contains(userRightsMap[userRight]));
      }))
          .contains(userRightsMap[userRight]);
    }
    bool result = _userRights?.contains(userRightsMap[userRight]) ?? false;
    complete?.call(result);
    return result;
  }
}
