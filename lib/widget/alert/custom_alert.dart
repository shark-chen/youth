import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../tripartite_library/webview/message/dialog_action.dart';
import '../../tripartite_library/webview/message/dialog_message_model.dart';
import '../../tripartite_library/webview/webview_page/base_web_view_controller.dart';
import '../../utils/router_observer/router_observer.dart';
export '../../tripartite_library/webview/message/dialog_action.dart';
export '../../tripartite_library/webview/message/dialog_message_model.dart';

List<Widget> buildActions(List<DialogAction>? actions,
    {BaseWebViewController? controller}) {
  List<Widget> res = [];
  if (actions != null && actions.isNotEmpty) {
    for (DialogAction action in actions) {
      res.add(CupertinoDialogAction(
          child: action.actionType == ActionType.done
              ? KeyboardListener(
                  focusNode: FocusNode(),
                  autofocus: true,
                  onKeyEvent: (rawKeyEvent) {
                    if (rawKeyEvent.runtimeType == KeyDownEvent &&
                        rawKeyEvent.logicalKey == LogicalKeyboardKey.enter) {
                      if (action.actionType == ActionType.done) {
                        Get.back();
                        action.onPressed?.call();
                      }
                    }
                  },
                  child: Text(
                    action.text!,
                    style: TextStyle(
                        color: hexToColor(action.color,
                            defaultColor: Colors.black),
                        fontSize: action.fontSize?.toDouble() ?? 16),
                  ))
              : Text(
                  action.text!,
                  style: TextStyle(
                      color:
                          hexToColor(action.color, defaultColor: Colors.black),
                      fontSize: action.fontSize?.toDouble() ?? 16),
                ),
          onPressed: () {
            Get.back();
            if (action.script != null &&
                action.script!.isNotEmpty &&
                controller != null) {
              controller.runScript(action.script!);
            } else if (action.onPressed != null) {
              action.onPressed?.call();
            }
          }));
    }
  }
  return res;
}

Future showCustomAlert(
  DialogMessageModel dialog, {
  BaseWebViewController? controller,
  VoidCallback? onWillPopCall,
}) async {
  bool showIcon = false;
  switch (dialog.type) {
    case "error":
    case "success":
      showIcon = true;
      break;
    case "loadOpen":
      if (dialog.dismissTime != null && dialog.dismissTime != 0) {
        Timer(Duration(milliseconds: dialog.dismissTime!), () async {
          EasyLoading.dismiss();
        });
      }
      EasyLoading.show();
      return;
    case "loadDismiss":
      EasyLoading.dismiss();
      return;
    case "normal":
      break;
    default:
      return;
  }
  if (dialog.dismissTime != null && dialog.dismissTime != 0) {
    Timer(Duration(milliseconds: dialog.dismissTime!), () async {
      Get.back();
    });
  }
  if (dialog.cupertinoDialog == false) {
    await showDialog(
        context: Get.context!,
        builder: (ctx) {
          return RouterObserver().routerObserver(
            Get.context!,
            () => CupertinoAlertDialog(
                title: buildTitle(showIcon, dialog),
                content: buildContent(dialog),
                actions: buildActions(dialog.actions, controller: controller)),
            onWillPop: () async {
              Get.back();
              onWillPopCall?.call();
              return false;
            },
          );
        });
  } else {
    await showCupertinoDialog(
      context: Get.context!,
      builder: (ctx) {
        return RouterObserver().routerObserver(
          Get.context!,
          () => CupertinoAlertDialog(
              title: buildTitle(showIcon, dialog),
              content: buildContent(dialog),
              actions: buildActions(dialog.actions, controller: controller)),
          onWillPop: () async {
            Get.back();
            onWillPopCall?.call();
            return false;
          },
        );
      },
    );
  }
}

Widget buildTitle(bool showIcon, DialogMessageModel dialog) {
  if (dialog.customWidget != null) {
    return dialog.customWidget!;
  }
  if (showIcon) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/image/icons/${dialog.type}@3x.png",
            width: 42,
            height: 42,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            dialog.title ?? "",
            style: TextStyle(
                fontSize: dialog.titleFontSize?.toDouble() ?? 18,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Text(
        dialog.title ?? "",
        style: TextStyle(
            fontSize: dialog.titleFontSize?.toDouble() ?? 18,
            fontWeight: dialog.titleFontWeight),
      ),
    );
  }
}

Widget buildContent(DialogMessageModel dialog) {
  List<Widget> children = [];
  if (dialog.contentList != null && dialog.contentList!.isNotEmpty) {
    for (var value in dialog.contentList!) {
      if (value != null) {
        children.add(Text(
          value,
          style: TextStyle(
              fontSize: dialog.contentFontSize?.toDouble() ?? 14,
              color: hexToColor(dialog.contentColor)),
        ));
        children.add(SizedBox(height: dialog.contentMargin?.toDouble()));
      }
    }
  }
  return children.isNotEmpty
      ? Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: dialog.contentBackground),
          child: Column(
            crossAxisAlignment: getAlign(align: dialog.contentAlign),
            children: children,
          ),
        )
      : Container();
}

CrossAxisAlignment getAlign({String? align = "left"}) {
  switch (align) {
    case "center":
      return CrossAxisAlignment.center;
    case "right":
      return CrossAxisAlignment.end;
    case "stretch":
      return CrossAxisAlignment.stretch;
    case "baseline":
      return CrossAxisAlignment.baseline;
    default:
      return CrossAxisAlignment.start;
  }
}

Color? hexToColor(String? color, {Color? defaultColor}) {
  try {
    if (color == null) {
      return defaultColor;
    }
    return Color((int.tryParse(color.substring(1, 7), radix: 16) ?? 0XFF000000) + 0XFF000000);
  } catch (e) {
    return defaultColor;
  }
}
