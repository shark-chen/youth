import 'dart:convert';
import 'package:kellychat/generated/json/succeed/chat_param_model.g.dart';
import 'package:kellychat/utils/extension/maps/maps.dart';

/// FileName: chat_param_model
///
/// @Author 谌文
/// @Date 2026/5/5 00:26
///
/// @Description 聊天页面-model
class ChatParamModel {
  /// 用户ID
  String? userId;

  /// 用户昵称
  String? niceName;

  /// 头像
  String? avatar;

  ChatParamModel();

  factory ChatParamModel.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $ChatParamModelFromJson(json);
    }
    return ChatParamModel();
  }

  Map<String, dynamic> toJson() => $ChatParamModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
