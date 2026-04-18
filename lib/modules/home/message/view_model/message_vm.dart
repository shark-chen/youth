import 'package:youth/base/base_vm.dart';

import '../../doing/model/publish_doing_entity.dart';

/// FileName: message_vm
///
/// @Author 谌文
/// @Date 2026/3/10 23:17
///
/// @Description 消息-vm
class MessageVM extends BaseVM {

  /// 我正在做的事
  PublishDoingEntity? myDoing;
  @override
  void onInit() {
    super.onInit();
  }

  /// 配置我正在做的事
  void configMyDoing(PublishDoingEntity? value) {
    myDoing = value;
  }
}
