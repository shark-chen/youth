import 'package:get/get_utils/src/platform/platform.dart';
import '../../../../config/environment_config/app_config.dart';
import '../../net_mixin.dart';
import '../../net_result.dart';
export 'logistics.dart';
export 'shops.dart';
export 'login.dart';
export 'config.dart';

/// FileName user
///
/// @Author 谌文
/// @Date 2024/4/19 15:05
///
/// @Description 用户请求类
class User extends NetMixin<User> {
  User();

  factory User.init() => User();


  /// 后端健康
  Future<NetResult<T>> requestActuatorHealth<T>() async {
    return await get<T>(AppConfig.getaActuatorHealthUrl);
  }

  /// 获取消息数量
  Future<NetResult<T>> requestSystemNotice<T>() async {
    return await get<T>(AppConfig.getSystemNoticeCount);
  }

  /// 获取消息数量
  Future<NetResult<T>> requestAlertNotice<T>() async {
    return await get<T>(AppConfig.requestAlertNotice);
  }

  /// 获取用户信息接口
  Future<NetResult<T>> requestUserInfo<T>() async {
    return await get<T>(AppConfig.getUserInfoUrl);
  }

  /// 获取是否取消订单申请推送
  Future<NetResult<T>> requestCancelOrderPush<T>() async {
    return await post<T>(AppConfig.getCancelOrderPushUrl);
  }

  /// 获取是否存在 新订单订阅通知数据 || 取消订单通知订阅数据 没有则存一条，并设置成默认开启
  Future<NetResult<T>> requestNotificationConfig<T>() async {
    return await post<T>(AppConfig.getNotificationUrl);
  }

  /// 获取快速订单通知开关
  Future<NetResult<T>> requestFastOrderPush<T>() async {
    return await post<T>(AppConfig.getFastOrderPushUrl);
  }

  /// 设置快速订单通知开关
  Future<NetResult<T>> requestFastOrderPushSet<T>(bool open) async {
    return await post<T>(AppConfig.getFastOrderPushSetUrl,
        params: {'enable': open});
  }

  /// 联系我们列表
  Future<NetResult<T>> requestContactUsList<T>(String lang) async {
    return await get<T>(AppConfig.getContactUsListUrl, params: {'lang': lang});
  }

  /// 获取用户订单相关配置
  Future<NetResult<T>> requestOrderConfig<T>() async {
    return await get<T>(AppConfig.getOrderConfigUrl);
  }

  /// 获取-用户权限接口
  Future<NetResult<T>> requestUserRight<T>() async {
    return await get<T>(AppConfig.getUserRightsUrl);
  }

  /// 店铺超限+订单量超限拦截
  Future<NetResult<T>> requestQuotaDetection<T>() async {
    return await get<T>(AppConfig.queryQuotaDetectionUrl);
  }

  /// 我的账户信息
  Future<NetResult<T>> requestMyAccount<T>() async {
    return await get<T>(AppConfig.myAccountUrl);
  }
}
