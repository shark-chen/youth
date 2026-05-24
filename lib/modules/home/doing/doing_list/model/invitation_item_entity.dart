import 'package:kellychat/generated/json/succeed/invitation_item_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/invitation_item_entity.g.dart';

/// 邀约收件箱单条记录（对应后端 InvitationItemVO）
class InvitationItemEntity {
  /// 邀约ID
  int? invitationId;

  /// 方向：sent=我发出的，received=我收到的
  String? direction;

  /// 对方用户ID
  int? targetUserId;

  /// 对方昵称
  String? targetNickname;

  /// 对方头像URL
  String? targetAvatar;

  /// 互动描述（单行，超出由前端截断）\n 例：我邀约她一起做：「看电影」 / 他邀约我一起做：「看电影」
  String? interactionDesc;

  /// 标签名（活动名称）
  String? tagName;

  /// 邀约留言
  String? message;

  /// 状态：0-待处理，1-已接受，2-已拒绝，3-已过期，4-已取消
  int? status;

  /// 状态展示文字（与发起方向相关）：\n 我已取消 / 对方已取消 / 我已拒绝 / 对方已拒绝 / 进行中 / 已结束 / 待处理 / 已过期
  String? statusText;

  /// 互动时间\n 今天：HH:mm（如 23:19）\n 昨天：昨天 HH:mm（如 昨天 13:15）
  String? displayTime;

  InvitationItemEntity();

  factory InvitationItemEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $InvitationItemEntityFromJson(json);
    }
    return InvitationItemEntity();
  }

  Map<String, dynamic> toJson() => $InvitationItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
