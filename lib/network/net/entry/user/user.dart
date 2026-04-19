import 'package:dio/dio.dart';

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

  /// 获取当前登录用户的信息
  Future<NetResult<T>> requestUserInfo<T>() async {
    return await get<T>(AppConfig.getUserInfoUrl);
  }

  /// 获取当前登录用户的私密信息
  /// GET /api/user/private
  Future<NetResult<T>> requestUserPrivate<T>() async {
    return await get<T>(AppConfig.getUserPrivateUrl);
  }

  /// 更新当前登录用户的私密信息
  /// PUT /api/user/private
  Future<NetResult<T>> requestUpdateUserPrivate<T>({
    required String wishDescription,
    String? password,
    String? oldPassword,
  }) async {
    return await put<T>(
      AppConfig.getUserPrivateUrl,
      data: <String, dynamic>{
        'wishDescription': wishDescription,
        'password': password,
        'oldPassword': oldPassword,
      },
    );
  }

  /// 修改私密信息中的密码
  /// PUT /api/user/private/password
  Future<NetResult<T>> requestUpdateUserPrivatePassword<T>({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await put<T>(
      AppConfig.putUserPrivatePasswordUrl,
      data: <String, dynamic>{
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );
  }

  /// 验证私密信息密码
  /// POST /api/user/private/verify body: `{ "password": "..." }`
  Future<NetResult<T>> requestUserPrivateVerify<T>({
    required String password,
  }) async {
    return await post<T>(
      AppConfig.postUserPrivateVerifyUrl,
      data: <String, dynamic>{'password': password},
    );
  }

  /// 重置私密信息密码
  /// POST /api/user/private/reset-password（无参数）
  Future<NetResult<T>> requestUserPrivateResetPassword<T>() async {
    return await post<T>(
      AppConfig.postUserPrivateResetPasswordUrl,
      data: <String, dynamic>{},
    );
  }

  /// 他人信息
  Future<NetResult<T>> requestUserByUserId<T>({
    required String userId,
  }) async {
    return await get<T>(AppConfig.getUserByUserIdUrl(userId));
  }

  /// 拉黑用户
  /// POST /api/block/{blockedUserId} body: `{ "blockedUserId": "..." }`
  Future<NetResult<T>> requestBlockUser<T>({
    required String blockedUserId,
  }) async {
    return await post<T>(
      AppConfig.postBlockUserUrl(blockedUserId),
      data: <String, dynamic>{'blockedUserId': blockedUserId},
    );
  }

  /// 取消拉黑 · DELETE /api/block/{blockedUserId}
  Future<NetResult<T>> requestUnblockUser<T>({
    required String blockedUserId,
  }) async {
    return await delete<T>(AppConfig.deleteBlockUserUrl(blockedUserId));
  }

  /// 查询是否已拉黑对方 · GET /api/block/check/{blockedUserId}
  Future<NetResult<T>> requestBlockCheck<T>({
    required String blockedUserId,
  }) async {
    return await get<T>(AppConfig.getBlockCheckUrl(blockedUserId));
  }

  /// 举报提交 · POST /api/report/submit
  Future<NetResult<T>> requestReportSubmit<T>({
    required int reportedUserId,
    required int reportType,
    required String reason,
    required String description,
    String images = '',
  }) async {
    return await post<T>(
      AppConfig.postReportSubmitUrl,
      data: <String, dynamic>{
        'reportedUserId': reportedUserId,
        'reportType': reportType,
        'reason': reason,
        'description': description,
        'images': images,
      },
    );
  }

  /// 上传头像（multipart 字段 `file`）
  Future<NetResult<T>> requestUploadUserAvatar<T>(MultipartFile file) async {
    final formData = FormData.fromMap(<String, dynamic>{'file': file});
    return await post<T>(
      AppConfig.getUserAvatarUrl,
      data: formData,
    );
  }

  /// 使用本地文件路径上传头像
  Future<NetResult<T>> requestUploadUserAvatarFromPath<T>(
    String filePath, {
    String? filename,
  }) async {
    final file = await MultipartFile.fromFile(
      filePath,
      filename: filename,
      contentType: DioMediaType(
        'image',
        filename?.split('.').last ?? 'png',
      ),
    );
    return requestUploadUserAvatar<T>(file);
  }

  /// 更新当前登录用户的信息
  /// gender: 性别：0-未知，1-男，2-女
  /// birthday: 生日: 1995-06-15
  /// province: 省份: 广东省
  /// city: 城市
  /// district: 区，县
  /// nickname / signature / tags / photos：按后端约定可选提交（空则不入参）
  Future<NetResult<T>> requestUpdateUserInfo<T>({
    int? gender,
    String? birthday,
    String? province,
    String? city,
    String? district,
    String? nickname,
    String? signature,
    List<String>? tags,
    List<String>? photos,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (gender != null) params['gender'] = gender;
    if (birthday != null) params['birthday'] = birthday;
    if (province != null) params['province'] = province;
    if (city != null) params['city'] = city;
    if (district != null) params['district'] = district;
    if (nickname != null) params['nickname'] = nickname;
    if (signature != null) params['signature'] = signature;
    if (tags != null) params['tags'] = tags;
    if (photos != null) params['photos'] = photos;
    return await put<T>(AppConfig.getUserInfoUrl, data: params);
  }

  /// 更新用户标签（最多10个）
  /// PUT /api/user/tags
  /// body: `{ "tags": ["标签1", "标签2"] }`（字符串数组）
  Future<NetResult<T>> requestUpdateUserTags<T>({
    required List<String> tags,
  }) async {
    return await put<T>(
      AppConfig.getUserTagsUrl,
      data: <String, dynamic>{'tags': tags},
    );
  }

  /// 更新照片墙（独立接口，非 [requestUpdateUserInfo] 中的 photos）
  /// PUT /api/user/photos body: `{ "photos": ["https://..."] }`
  Future<NetResult<T>> requestUpdateUserPhotos<T>({
    required List<String> photos,
  }) async {
    return await put<T>(
      AppConfig.putUserPhotosUrl,
      data: <String, dynamic>{'photos': photos},
    );
  }

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

  /// 上传图片 · POST /api/user/photo（multipart 字段 `file`）
  Future<NetResult<T>> requestUploadPhoto<T>({
    required String filePath,
    String? filename,
  }) async {
    final file = await MultipartFile.fromFile(
      filePath,
      filename: filename,
    );
    return await post<T>(
      AppConfig.getUploadPhotoUrl,
      data: {'file': file},
      isFormData: true,
    );
  }
}
