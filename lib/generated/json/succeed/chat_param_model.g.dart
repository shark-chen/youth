import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/chat/model/chat_param_model.dart';

ChatParamModel $ChatParamModelFromJson(Map<String, dynamic> json) {
  final ChatParamModel chatParamModel = ChatParamModel();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    chatParamModel.userId = userId;
  }
  final String? niceName = jsonConvert.convert<String>(json['niceName']);
  if (niceName != null) {
    chatParamModel.niceName = niceName;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    chatParamModel.avatar = avatar;
  }
  return chatParamModel;
}

Map<String, dynamic> $ChatParamModelToJson(ChatParamModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['niceName'] = entity.niceName;
  data['avatar'] = entity.avatar;
  return data;
}

extension ChatParamModelExtension on ChatParamModel {
  ChatParamModel copyWith({
    String? niceName,
    String? userId,
    String? avatar,
  }) {
    return ChatParamModel()
      ..niceName = niceName ?? this.niceName
      ..avatar = avatar ?? this.avatar
      ..userId = userId ?? this.userId;
  }
}
