import 'package:kellychat/generated/json/succeed/current_doing_state_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/current_doing_state_entity.g.dart';

class CurrentDoingStateEntity {
  /// 需要弹输入框创建新事项。
  bool? hasCurrentDoing;
  int? statusId;
  int? tagId;
  String? tagName;
  /// 提示先取消当前待接受邀约。
  bool? hasPendingInvitation;
  /// 提示先断开当前连接。
  bool? hasActiveTogether;
  /// 可直接用当前事项发起邀约，无需输入。
  bool? canQuickInvite;

  CurrentDoingStateEntity();

  factory CurrentDoingStateEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $CurrentDoiingStateEntityFromJson(json);
    }
    return CurrentDoingStateEntity();
  }

  Map<String, dynamic> toJson() => $CurrentDoiingStateEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
