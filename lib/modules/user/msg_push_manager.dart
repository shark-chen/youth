import 'dart:async';
import '../../config/environment_config/app_config.dart';
import '../../generated/locales.g.dart';
import '../../tripartite_library/notification/event_bus_manager.dart';
import '../../utils/extension/strings/strings.dart';
import '../../utils/utils/model_utils.dart';
import '../home/doing/model/blog_url_model.dart';
import '../home/home/view/tabs.dart';
import '../home/home/utils/tab_switch_utils.dart';
import '../routes/app_pages.dart';
import 'model/push_entity.dart';
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
      Get.until((route) => route.isFirst || route.settings.name == Routes.homePage);
      var data = ModelUtils.convert<String>(map['data']) ?? '';
      if (Strings.isNotEmpty(data)) {
        await handlePush(map);
      } else {
        var openType = ModelUtils.convert<String>(map['openType']) ?? '';
        await oldHandlePush(openType, map);
      }
    } catch (_) {
    } finally {
      msg = null;
    }
  }

  /// 处理推送数据
  Future handlePush(Map pushMap) async {
    var push =
        PushEntity.fromJson(ModelUtils.convert<String>(pushMap['data']) ?? '');

    /// 切换到home页面的某个tab页面
    TabSwitchUtils.switchTab(stringToHomeTab(push.home ?? ''));

    /// 如果home页面有tab页，如订单页，可切换对应tab
    if (push.params?.containsKey('tab') == true) {

    }
    if (Strings.isNotEmpty(push.route)) {
      await Get.toNamed(
        push.route ?? '',
        arguments: push.params,
        parameters: push.parameters,
      );
    }
    Future.delayed(
        Duration(milliseconds: 1000), () => EventBusManager().fire(push));
  }

  /// 老的 处理推送数据
  Future oldHandlePush(String openType, Map pushMap) async {
    switch (openType) {
      case 'ORDER_PAGE':
        {
          TabSwitchUtils.switchTab(HomeTabs.order);
        }
        break;
      case 'ORDER_CANCEL_PAGE':
        {

        }
        break;
      case 'URL_PAGE':
        {

        }
        break;
      case 'SYSTEM_PAGE':
        {
          TabSwitchUtils.switchTab(HomeTabs.hall);
          await Get.toNamed(Routes.webView, parameters: {
            "url":
                "${AppConfig.systemMessageUrl}?templateId=${ModelUtils.convert<int>(pushMap['templateId']) ?? 0}&tab=${ModelUtils.convert<String>(pushMap['systemTab']) ?? '0'}",
            "showTitle": "true",
            "title": LocaleKeys.SysInfo.tr,
            "closeScript": "window.goClose?goClose():window.history.back()"
          });


        }
        break;

      /// 打开到blog页面
      case 'BLOG_PAGE':
        {
          TabSwitchUtils.switchTab(HomeTabs.blog);
        }
        break;

      /// 打开到blog详情页
      case 'BLOG_DETAIL_PAGE':
        {
          TabSwitchUtils.switchTab(HomeTabs.blog);
          var openUrl = ModelUtils.convert<String>(pushMap['openUrl']) ?? '';
          EventBusManager().fire(BlogUrlModel(url: openUrl));
        }
        break;
      default:
        {
          TabSwitchUtils.switchTab(HomeTabs.hall);
          await Get.offAllNamed(Routes.homePage);
        }
        break;
    }
  }
}
