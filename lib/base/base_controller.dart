import 'dart:async';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_reset_private_password_confirm_dialog.dart';
import 'base_controller.dart';
export 'base_model_entity.dart';
export 'package:get/get.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:flutter/material.dart';
export '../widget/alert/custom_alert.dart';
export '../utils/utils/model_utils.dart';
export '../../../generated/locales.g.dart';
export '../../../base/base_controller.dart';
export 'package:kellychat/modules/routes/app_pages.dart';
export '../utils/marco/marco.dart';
export 'package:kellychat/tripartite_library/tripartite_library.dart';
export '../../../modules/user/user_center/user_center.dart';
export '../../../../utils/utils.dart';
export 'package:kellychat/tripartite_library/notification/event_bus_manager.dart';
export 'package:kellychat/widget/bubble/bubble_dialog.dart';
export 'package:kellychat/widget/bottom_alert/bottom_alert.dart';
export 'package:kellychat/utils/stores/stores.dart';
export '../../../../../network/net/net.dart';

enum CompletedLoadType {
  all,
  refresh,
  loadMore,
}

abstract class BaseController extends GetxController
    with WidgetsBindingObserver {
  /// 页面标题
  String? title = '';
  var isNetworkError = false.obs;

  /// 翻页使用
  var pageNo = 1;
  var pageSize = 20;
  var totalSize = 0.obs;

  /// 是否正在请求中
  var requesting = false.obs;

  /// 空白提示语
  var spaceHint = ''.obs;
  var showRefresh = false.obs;

  /// 是否需要监听APP生命周期变化
  var listenAppLifecycleState = false;

  /// 刷新
  VoidCallback? keyboardRefresh;

  /// scroller没有设置ListView时候，滚动会崩溃
  ScrollController scroller = ScrollController();

  /// 键盘监控
  TextEditingController? editingController;
  FocusNode focusNode = FocusNode();

  /// 是否自动聚焦
  bool autofocus = !UserCenter().isCamera;

  /// 是相机还是PDA
  bool isCamera = UserCenter().isCamera;
  bool hiddenKeyboard = true; // PDA会自动聚焦键盘,但不弹出键盘，如果点击输入框时需要弹起键盘，使用此字段

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// 新的下拉刷新库
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  /// 刷新
  VoidCallback? refreshUI;

  /// 计时器
  Timer? timer;

  /// 计时器
  Timer? voiceTimer;

  @override
  void onInit() {
    super.onInit();
    spaceHint.value = LocaleKeys.InReqData.tr;
    refreshController.footerMode = RefreshNotifier(LoadStatus.noMore);

    /// 添加监听器
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    super.onReady();
    if (listenAppLifecycleState) {
      EventBusManager().listen<AppLifecycleState>(this, appLifecycleState);
    }
  }

  @override
  void onClose() {
    try {
      /// 移除监听器
      WidgetsBinding.instance.removeObserver(this);
      refreshController.dispose();
      super.onClose();
      cancelTimer();
      keyboardSubscription?.cancel();
      EasyLoading.dismiss();
      EventBusManager().cancel(this);
    } catch (_) {}
  }

  void onClear() {}

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    /// 更新 UI
    changeMetricsUpdateUI();
  }

  void changeMetricsUpdateUI() {}

  /// 键盘扫描管理
  void buildEditingManage() {
    editingController = TextEditingController();
    autofocus = true;
    setHiddenKeyboard(true);
  }

  /// 开始计时
  void startTimer(
    VoidCallback complete, {
    int? milliseconds,
  }) {
    try {
      cancelTimer();
      timer = Timer(Duration(milliseconds: milliseconds ?? 1500), () {
        complete.call();

        /// 计时器销毁
        cancelTimer();
      });
    } catch (_) {
      complete.call();
    }
  }

  /// 语音播报开始计时
  void startVoiceTimer(
    VoidCallback complete, {
    int? milliseconds,
  }) {
    cancelVoiceTimer();
    voiceTimer = Timer(Duration(milliseconds: milliseconds ?? 1500), () {
      complete.call();

      /// 计时器销毁
      cancelVoiceTimer();
    });
  }

  /// 计时器销毁
  void cancelTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  /// 计时器销毁
  void cancelVoiceTimer() {
    try {
      if (voiceTimer != null) {
        voiceTimer?.cancel();
        voiceTimer = null;
      }
    } catch (_) {}
  }

  /// PDA-使用， 是否隐藏键盘
  void setHiddenKeyboard(bool hidden) {
    hiddenKeyboard = hidden;
  }

  /// 添加键盘显示隐藏监控
  var _keyVisible = false;
  StreamSubscription? keyboardSubscription;

  void addKeyboardVisibilityListen({ValueChanged<bool>? resultCall}) {
    keyboardSubscription = KeyboardVisibilityController().onChange.listen(
      (bool visible) {
        if (_keyVisible == visible) return;
        _keyVisible = visible;
        resultCall?.call(visible);

        /// 点击自动键盘的收起键盘需要设置此值
        if (!visible) {
          setHiddenKeyboard(true);
          keyboardRefresh?.call();
        }
      },
    );
  }

  /// 只会隐藏键盘，但还是会聚焦
  void hideKeyboard() {
    try {
      if (isIOS) {
        FocusManager.instance.primaryFocus?.unfocus();
      } else {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    } catch (_) {}
  }

  /// 取消聚焦
  void unfocus({BuildContext? context}) {
    FocusScope.of(context ?? Get.context!).unfocus(); // 取消聚焦
    focusNode.unfocus();
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

  /// 下拉刷新
  void onRefresh() {
    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      refreshController.refreshCompleted();
    });
  }

  /// 上了刷新拉刷新
  void onLoading() {
    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      refreshController.loadComplete();
    });
  }

  /// 完成加载
  void completedLoad({
    CompletedLoadType completedType = CompletedLoadType.all,
  }) {
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  /// MARK- APP生命状态
  void appLifecycleState(AppLifecycleState state) {}

  /// 是否还有更多数据
  void haveLoadMore(bool haveMore) {
    if (haveMore) {
      refreshController.resetNoData();
      completedLoad();
    } else {
      refreshController.loadNoData();
    }
  }

  /// 关闭页面
  void closePage() {
    Get.back();
  }

  /// push - 左右按钮是弹框提示
  /// content: 内容
  /// leftTitle: 左侧按钮标题
  /// leftTitleColor: 左边侧按钮标题颜色
  /// leftTitleBgColor: 左边侧按钮背景颜色
  /// rightTitle: 右侧按钮标题
  /// rightTitleColor: 右边侧按钮标题颜色
  /// rightTitleBgColor: 右边侧按钮背景颜色
  /// customContentWidget: 自定义内容widget
  Future<T?> pushDialogAlert<T>({
    String? content,
    String? leftTitle,
    Color? leftTitleColor,
    Color? leftTitleBgColor,
    String? rightTitle,
    Color? rightTitleColor,
    Color? rightTitleBgColor,
    Widget? customContentWidget,
    VoidCallback? leftTap,
    VoidCallback? rightTap,
  }) async {
    final ctx = Get.context;
    if (ctx == null) return null;
    return await showDialog<T>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        content: content,
        leftTitle: leftTitle,
        leftTitleColor: leftTitleColor,
        leftTitleBgColor: leftTitleBgColor,
        rightTitle: rightTitle,
        rightTitleColor: rightTitleColor,
        rightTitleBgColor: rightTitleBgColor,
        customContentWidget: customContentWidget,
        leftTap: leftTap ?? Get.back,
        rightTap: rightTap ?? Get.back,
      ),
    );
  }
}
