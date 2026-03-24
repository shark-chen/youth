import 'light_store/store_preferences.dart';

/// FileName store_preferences
///
/// @Author 谌文
/// @Date 2023/9/20 16:49
///
/// @Description 轻量数据存储
enum UserConfigEnum {
  /// 相机or-Pda扫描开关key + 存储的是bool值, 默认为false， true为pda扫描, false为pda扫描
  cameraOrPdaScanOpenKey,

  /// 待处理订单引导
  newOrderGuide,

  /// 待处理订单提示语
  newOrderTips,

  /// 待打单波次订单提示语
  processWaveOrderTips,

  /// 待打单订单引导
  processOrderGuide,

  /// 扫描发货需要签单的订单ID数据
  allowSignOrderIds,

  /// 扫描发货需要签单选择的物流ID
  allowSignGrepId,

  /// 首页销售数据没有权限时候关闭View
  hallSalesFiguresClose,

  /// 权限
  userPermissions,

  /// 上报日志/机器人失败的数据
  reportFailedInformation,

  /// 摇一摇查看网络数据
  shakeLookNetWork,

  /// 日志开始缓存时间
  logSaveStartTime,

  /// 日志开始上报时间
  logUploadStartTime,

  /// 波次拣货开始分布页
  wavePickDistributed,

  /// 大厅首页数据
  hallList,

  /// 我的页面数据
  mineList,

  /// 用户信息数据
  userInfo,

  /// 是否展示拣货车编码
  isShowPickingCar,

  /// 订单相关配置
  orderOptions,

  /// 用户选择的店铺
  selectShop,

  /// 通知配置项
  notificationConfigurationItem,

  /// 相机扫描时间间隔
  scanTimeInterval,

  /// 波次拣货小屏模式
  isWavePickSmallScreen
}

/// 轻量存储类
class Preferences {
  static Preferences? _instance;

  factory Preferences() {
    _instance ??= Preferences._();
    return _instance!;
  }

  Preferences._();

  /// 清除缓存
  Future<bool> clear() async {
    return await StorePreferences().clear();
  }

  /// bool + 获取存储的值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool?> getBool(UserConfigEnum key, {bool? userLat}) async {
    return await StorePreferences().getBool(key.toString(), userLat: userLat);
  }

  /// bool + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setBool(UserConfigEnum key, bool value, {bool? userLat}) async {
    return await StorePreferences()
        .setBool(key.toString(), value, userLat: userLat);
  }

  /// bool + 获取存储的值
  /// userLatitude: 是否存储以用户纬度 + 默认true
  Future<int?> getInt(UserConfigEnum key, {bool? userLat}) async {
    return await StorePreferences().getInt(key.toString(), userLat: userLat);
  }

  /// int + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setInt(UserConfigEnum key, int value, {bool? userLat}) async {
    return await StorePreferences()
        .setInt(key.toString(), value, userLat: userLat);
  }

  /// double + 获取存储的值
  /// userLatitude: 是否存储以用户纬度 + 默认true
  Future<double?> getDouble(UserConfigEnum key, {bool? userLat}) async {
    return await StorePreferences().getDouble(key.toString(), userLat: userLat);
  }

  /// double + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setDouble(UserConfigEnum key, double value,
      {bool? userLat}) async {
    return await StorePreferences()
        .setDouble(key.toString(), value, userLat: userLat);
  }

  /// String + 获取存储的值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<String?> getString(UserConfigEnum key, {bool? userLat}) async {
    return await StorePreferences().getString(key.toString(), userLat: userLat);
  }

  /// String + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setString(
    UserConfigEnum key,
    String value, {
    bool? userLat,
  }) async {
    return await StorePreferences()
        .setString(key.toString(), value, userLat: userLat);
  }

  /// List<String> + 获取存储的值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<List<String>?>? getStringList(
    UserConfigEnum key, {
    bool? userLat,
  }) async {
    return await StorePreferences()
        .getStringList(key.toString(), userLat: userLat);
  }

  /// List<String> + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setStringList(
    UserConfigEnum key,
    List<String> list, {
    bool? userLat,
  }) async {
    return await StorePreferences()
        .setStringList(key.toString(), list, userLat: userLat);
  }
}
