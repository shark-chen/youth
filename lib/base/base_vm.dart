import 'dart:async';
import 'package:youth/modules/user/user_center/user_center.dart';
import 'package:flutter/material.dart';
import '../generated/locales.g.dart';
import 'package:get/get.dart';
export 'package:get/get.dart';
export '../../../../utils/utils.dart';
export '../../../../../../generated/locales.g.dart';
export 'package:youth/widget/bubble/model/bubble_model.dart';
export 'package:youth/modules/user/user_center/user_center.dart';
export 'package:youth/tripartite_library/tripartite_library.dart';

/// FileName base_vm
///
/// @Author 谌文
/// @Date 2024/6/25 20:29
///
/// @Description 基础view_model
abstract class BaseVM {
  BaseVM() {
    onInit();
  }

  /// 页面标题
  String? title = '';

  /// 刷新
  VoidCallback? refresh;

  /// 计时器
  Timer? timer;

  /// 空白提示语
  String spaceHint = LocaleKeys.InReqData.tr;

  /// 翻页使用
  var pageNo = 1;
  var pageSize = 20;
  bool haveMore = true;

  /// 是否正在请求中
  var requesting = true;

  /// scroller没有设置ListView时候，滚动会崩溃
  ScrollController? scroller;

  /// 键盘监控
  TextEditingController? editingController;
  FocusNode focusNode = FocusNode();

  /// 是否自动聚焦
  bool autofocus = !UserCenter().isCamera;
  bool hiddenKeyboard = true; // PDA会自动聚焦键盘,但不弹出键盘，如果点击输入框时需要弹起键盘，使用此字段

  void onInit() {}

  void onReady() {}

  void onClear() {}

  /// 开始计时
  void startTimer(
    VoidCallback complete, {
    int? milliseconds,
  }) {
    cancelTimer();
    timer = Timer(Duration(milliseconds: milliseconds ?? 1500), () {
      complete.call();

      /// 计时器销毁
      cancelTimer();
    });
  }

  /// 计时器销毁
  void cancelTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  /// 键盘扫描管理
  void buildEditingManage() {
    editingController = TextEditingController();
    autofocus = true;
    setHiddenKeyboard(true);
  }

  /// 编辑框选中内容
  void editSelection({bool? select = false}) {
    focusNode.addListener(() {
      if (focusNode.hasFocus || select == true) {
        editingController?.selection = TextSelection(
            baseOffset: 0, extentOffset: editingController?.text.length ?? 0);
      }
    });
  }

  /// PDA-使用， 是否隐藏键盘
  void setHiddenKeyboard(bool hidden) {
    hiddenKeyboard = hidden;
  }
}
