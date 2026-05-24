import 'package:kellychat/generated/json/succeed/current_doing_state_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/current_doing_state_entity.g.dart';

class CurrentDoingStateEntity {
  /// -hasCurrentDoing=false:需要弹输入框创建新事项。
  bool? hasCurrentDoing;
  int? statusId;
  int? tagId;
  String? tagName;

  /// hasPendingInvitation=true:提示先取消当前待接受邀约。
  bool? hasPendingInvitation;

  /// 提示先断开当前连接。
  bool? hasActiveTogether;

  /// canQuickInvite=true:可直接用当前事项发起邀约，无需输入。
  bool? canQuickInvite;

  /// 是否可以接受邀约
  bool? canInviteTarget;

  /// 不可接受快速邀约的原因
  String? cannotInviteReason;

  /// 已经发出邀约了
  /// 邀约ID
  int? pendingInvitationId;

  /// 最近被邀约人的用户ID
  int? pendingInvitationToUserId;

  /// 最近被邀约人的 用户明
  String? pendingInvitationToUserNickname;

  CurrentDoingStateEntity();

  factory CurrentDoingStateEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $CurrentDoingStateEntityFromJson(json);
    }
    return CurrentDoingStateEntity();
  }

  Map<String, dynamic> toJson() => $CurrentDoiingStateEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
