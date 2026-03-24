import '../../../../config/environment_config/app_config.dart';
import '../../net_result.dart';
import 'user.dart';

/// FileName shops
///
/// @Author 谌文
/// @Date 2024/6/6 10:16
///
/// @Description 我的- 店铺+平台
extension Shops on User {
  /// 请求用户已授权平台及店铺接口
  Future<NetResult<T>> requestShopsAndPlatforms<T>() async {
    return await get<T>(AppConfig.getShopsAndPlatformsUrl);
  }

  /// 获取用户的店铺组
  Future<NetResult<T>> requestShopGroup<T>() async {
    return await get<T>(AppConfig.getShopGroupUrl);
  }

  /// 获取 某个平台授权的店铺
  Future<NetResult<T>> requestAuthShop<T>({
    String? platform,
  }) async {
    var params = {'platform': platform};
    return await get<T>(AppConfig.authShopUrl, params: params);
  }

  /// 同步店铺数据
  /// syncType: 同步类型  1：店铺， 2：广告活动
  Future<NetResult<T>> requestSyncShopAdInfo<T>({
    List<int>? shopIds,
    int? syncType,
  }) async {
    var params = {'shopIds': shopIds?.join(','), 'syncType': syncType};
    return await post<T>(AppConfig.syncShopAdInfoUrl, data: params);
  }

  /// 同步店铺数据 进度查询
  /// type: shopeeAds：Shopee店铺数据， shopeeCampaignAds: shopee广告
  Future<NetResult<T>> requestSyncShopeeDataProcess<T>({
    String? type,
    String? key,
  }) async {
    var params = {'type': type, 'key': key};
    return await post<T>(AppConfig.syncShopeeDataProcessUrl, params: params);
  }

  /// 同步店铺数据信息 时间
  Future<NetResult<T>> requestSyncShopAdITime<T>(String campaignId) async {
    var params = {'campaignId': campaignId};
    return await get<T>(AppConfig.syncShopAdITimeUrl, params: params);
  }
}
