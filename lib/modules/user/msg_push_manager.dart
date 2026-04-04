import 'dart:async';
import '../../tripartite_library/notification/event_bus_manager.dart';
import '../../utils/utils/model_utils.dart';
import '../routes/app_pages.dart';
import 'global.dart';
import 'package:get/get.dart';

/// FileName msg_push_utils
///
/// @Author 谌文
/// @Date 2023/6/16 17:43
///
/// @Description 消息推送处理类
class PushMsgModel {
  dynamic msg;

  PushMsgModel(this.msg);
}

class MsgPushManager {
  static final MsgPushManager _instance = MsgPushManager._();

  factory MsgPushManager() => _instance;

  MsgPushManager._();

  /// 推送的消息体数据
  dynamic msg;

  /// 在大厅页添加监听
  Future addListen() async {
    /// 只监听推送消息
    EventBusManager().listen<PushMsgModel>(_instance, (event) async {
      /// 处理推送消息
      msg = event.msg;
      await handlePushMsg();
    });

    /// 处理推送消息
    await handlePushMsg();
  }

  /// 处理推送消息
  Future handlePushMsg() async {
    try {
      /// 消息统计接口
      Map map = ModelUtils.convert<Map>(msg) ?? {};

      /// 没有消息或者没有登录不跳转页面
      if (map.isEmpty || Global.actualLogin.isFalse) {
        return;
      }

      /// 退回到首页
      Get.until(
          (route) => route.isFirst || route.settings.name == Routes.homePage);
    } catch (_) {
    } finally {
      msg = null;
    }
  }
}
