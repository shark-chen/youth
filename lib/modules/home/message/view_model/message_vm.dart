import 'package:youth/base/base_vm.dart';

import '../../doing/model/publish_doing_entity.dart';
import '../invite_record/model/together_list_entity.dart';
import '../model/message_person_list_entity.dart';

/// FileName: message_vm
///
/// @Author 谌文
/// @Date 2026/3/10 23:17
///
/// @Description 消息-vm
class MessageVM extends BaseVM {
  /// 我正在做的事
  PublishDoingEntity? myDoing;

  /// 消息人列表
  List<MessagePersonListEntity> conversations = [];

  /// 列表
  List<TogetherListEntity> togetherList = [];

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置数据
  void configTogetherList(List<TogetherListEntity>? values) {
    togetherList.addAll(values ?? []);
  }

  /// 配置我正在做的事
  void configMyDoing(PublishDoingEntity? value) {
    myDoing = value;
  }

  /// 配置对话列表
  void configConversations(List<MessagePersonListEntity>? values) {
    conversations.addAll(values ?? []);
  }
}
