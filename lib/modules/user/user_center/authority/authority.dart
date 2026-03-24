import 'package:youth/modules/user/user_center/user_mixin/user_mixin.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/tripartite_library/tripartite_library.dart';
import 'model/authority_entity.dart';

/// FileName: authority
///
/// @Author 谌文
/// @Date 2026/1/4 14:32
///
/// @Description 店铺数量，数量等权限
class Authority extends BaseUser {
  static final Authority _instance = Authority._();

  factory Authority() => _instance;

  Authority._();

  /// 是否有权限
  var haveAuthority = true;

  /// 是否有订单权限
  var haveOrderAuthority = true;

  /// 是给APP的
  String appTips = '';

  AuthorityEntity? _authorityEntity;

  /// 返回数据是否发生变化
  bool authorityChange = true;

  @override
  Future init() async {
    super.init();

    /// 店铺超限+订单量超限拦截
    await requestQuotaDetection();
    succeed = true;
    return;
  }

  @override
  Future clear() async {
    super.clear();
  }

  /// 店铺超限+订单量超限拦截
  Future requestQuotaDetection({
    VoidCallback? complete,
  }) async {
    if (_authorityEntity != null) {
      complete?.call();
      EventBusManager().fire(_authorityEntity);
    }
    var response =
        await Net.value<User>().requestQuotaDetection<AuthorityEntity>();
    if (response.succeed) {
      haveAuthority = (response.value?.overDueType != 1 &&
          response.value?.overDueType != 2);
      haveOrderAuthority = haveAuthority && (response.value?.overDueType != 4);
      authorityChange = handleAuthorityChange(response.value);
      _authorityEntity = response.value;
      appTips = response.value?.appTips ?? '';
    } else {
      authorityChange = handleAuthorityChange(null);
      _authorityEntity = null;
      haveAuthority = true;
      haveOrderAuthority = true;
      appTips = '';
    }
    complete?.call();
    EventBusManager().fire(_authorityEntity);
    return response;
  }

  /// 是否发生裱花
  bool handleAuthorityChange(AuthorityEntity? value) {
    return !(_authorityEntity?.overDueType == value?.overDueType && _authorityEntity?.appTips == value?.appTips);
  }

  /// 是否有权限- pageName: 用于剔除不要权限控制的入口
  bool isHaveAuthority({String? pageName}) {
    if (Strings.isNotEmpty(pageName) &&
        [Routes.contactWayPage, Routes.webView].contains(pageName ?? '')) {
      return true;
    } else if (Strings.isNotEmpty(pageName) &&
        _authorityEntity?.overDueType == 2 &&
        [Routes.shopAuth].contains(pageName ?? '')) {
      /// 店铺超限： 0 正常，1订单超限，2店铺超限
      /// 1.引导购买套餐或解绑店铺，可进入首页、订阅服务及店铺授权页；
      return true;
    }
    return haveAuthority;
  }
}
