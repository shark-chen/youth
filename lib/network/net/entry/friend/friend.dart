import 'package:kellychat/network/net/net_mixin.dart';
import 'package:kellychat/config/environment_config/app_config.dart';
import 'package:kellychat/network/net/net_mixin.dart';
import 'package:kellychat/network/net/net_result.dart';

/// FileName: friend
///
/// @Author 谌文
/// @Date 2026/5/14 19:33
///
/// @Description 好友 / 邀约相关接口
class Friend extends NetMixin<Friend> {
  Friend();

  factory Friend.init() => Friend();

  /// 通过邀请码接受邀约 · POST /api/invitation/accept-by-code
  Future<NetResult<T>> requestAcceptInvitationByCode<T>({
    required String inviteCode,
  }) async {
    return await post<T>(
      AppConfig.postInvitationAcceptByCodeUrl,
      data: <String, dynamic>{'inviteCode': inviteCode},
    );
  }
}