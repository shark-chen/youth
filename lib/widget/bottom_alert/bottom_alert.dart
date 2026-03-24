export 'package:flutter/material.dart';
import '../../base/base_controller.dart';
import '../../utils/router_observer/router_observer.dart';
export '../bubble/model/bubble_model.dart';
import 'view/alert_double_title_view.dart';
import 'view/alert_view.dart';
import 'view/sheet_view.dart';
import 'view/sheets_view.dart';
export 'view/result_view.dart';

/// todo 啊啊

/// FileName bottom_alert
///
/// @Author 谌文
/// @Date 2023/12/21 10:33
///
/// @Description 底部弹框-列表选择框
class BottomAlert {
  /// 底部列表弹框
  /// context: 上下文
  /// list: 弹框数据源
  /// customWidget: 自定义UI
  /// showBottomBtn： 是否展示底部按钮
  static Future show<T extends BubbleModel>(
    BuildContext context, {
    String? title,
    double? height = 350,
    bool? isDismissible = true,
    List<T>? list,
    CustomItemCellCallback? customItemCellCall,
    Function(int index, T t)? selectOnTap,
    Widget? customWidget,
    String? defaultTitle,
    bool? showBottomBtn,
    String? leftTitle,
    String? rightTitle,
    bool? showCloseBtn = true,
    VoidCallback? closeTap,
    VoidCallback? leftTap,
    VoidCallback? rightTap,
  }) {
    return showModalBottomSheet(
        isDismissible: isDismissible ?? true,
        builder: (BuildContext context) {
          return RouterObserver().routerObserver(
            Get.context!,
            () => SheetView(
              title: title,
              list: list,
              customItemCellCall: customItemCellCall,
              height: height,
              customWidget: customWidget,
              defaultTitle: defaultTitle,
              showBottomBtn: showBottomBtn,
              leftTitle: leftTitle,
              rightTitle: rightTitle,
              showCloseBtn: showCloseBtn,
              closeTap: closeTap,
              cancelTap: leftTap ?? Get.back,
              confirmTap: rightTap,
              selectOnTap: (int index, BubbleModel? model) {
                selectOnTap?.call(index, model as T);
                Get.back();
              },
            ),
            onWillPop: () async {
              Get.back();
              closeTap?.call();
              return false;
            },
          );
        },
        backgroundColor: Colors.transparent,
        context: context);
  }

  /// 底部列表弹框- 可多选
  /// context: 上下文
  /// list: 弹框数据源
  /// customWidget: 自定义UI
  /// showBottomBtn： 是否展示底部按钮
  /// haveAll: 是否有全部选择
  /// maxSelectCount: 最多可选多少个， 不设置，默认可选全部
  /// maxSelectToast: 设置了最后可选多少个后，选择超过个数后的提示语
  /// resetCustomCall: 重置逻辑自定义
  static Future shows<T extends BubbleModel>(
    BuildContext context, {
    String? title,
    double? height = 350,
    bool? isDismissible = false,
    List<T>? list,
    Function(int index, T t)? selectOnTap,
    Widget? customWidget,
    String? defaultTitle,
    bool? showBottomBtn = true,
    bool? showBottomCancelBtn = false,
    bool? haveAll = true,
    bool? search = false,
    int? maxSelectCount,
    String? maxSelectToast,
    VoidCallback? closeTap,
    VoidCallback? cancelTap,
    ValueChanged<List<BubbleModel>?>? resetCustomCall,
    VoidCallback? confirmTap,
    VoidCallback? updateTap,
  }) {
    /// 键盘监控
    RxList<T>? rows = <T>[].obs;
    TextEditingController? editingController;
    if (search == true) {
      rows.addAll(list as Iterable<T>);
      editingController = TextEditingController()
        ..addListener(() {
          var items = list?.where((element) =>
              element.title.contains(editingController?.text ?? ''));
          rows.clear();
          if (items != null) rows.addAll(items);
          rows.refresh();
        });
    }

    /// 记录选择状态的初始值，用于用户选择了但未选择确认，而是关闭了，还原原先的选则状态
    list?.forEach((e) => e.originalSelected = e.selected);

    /// 列表view
    SheetViews buildSheetViews(List<T>? lists) {
      return SheetViews(
        title: title,
        list: lists,
        originalList: list,
        height: height,
        customWidget: customWidget,
        defaultTitle: defaultTitle,
        showBottomBtn: showBottomBtn,
        showBottomCancelBtn: showBottomCancelBtn,
        haveAll: haveAll,
        search: search,
        editingController: editingController,
        closeTap: closeTap,
        cancelTap: cancelTap ?? Get.back,
        resetCustomCall: resetCustomCall,
        confirmTap: confirmTap,
        updateTap: updateTap,
        maxSelectCount: maxSelectCount,
        maxSelectToast: maxSelectToast,
        selectOnTap: (int index, BubbleModel? model) {
          selectOnTap?.call(index, model as T);
          Get.back();
        },
      );
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: isDismissible ?? true,
        builder: (BuildContext context) {
          return RouterObserver().routerObserver(
            Get.context!,
            () => search == true
                ? Obx(() => buildSheetViews(rows))
                : buildSheetViews(list),
            onWillPop: () async {
              Get.back();
              closeTap?.call();
              return false;
            },
          );
        },
        context: context);
  }

  /// 失败 弹框
  /// title： 标题
  /// content： 失败成功原因
  /// failReasons：失败原因列表
  static Future failAlert<T extends BubbleModel>(
    BuildContext context, {
    String? title,
    String? content,
    List<String>? failReasons,
    VoidCallback? confirmTap,
  }) async {
    await showDialog(
      useSafeArea: false,
      builder: (BuildContext context) {
        return ResultWidget(
          title: title,
          content: content,
          failReasons: failReasons,
          confirmTap: confirmTap,
        );
      },
      context: Get.context!,
    );
  }

  /// 底部弹框
  /// title： 标题
  /// titleBottomLine: 是否展示标题底部的下划线
  /// content： 内容
  /// showCloseBtn：是否展示关闭按钮
  /// closeTap：关闭按钮点击
  /// leftTitle：左边按钮名称 默认名字 取消
  /// leftTap： 左边按钮点击
  /// rightTitle： 右边按钮名称 默认名字 确定
  /// rightTap：右边按钮点击
  /// minHeight:
  /// isDismissible: 点击背景是否关闭弹框, true: 点击背景关闭
  /// wholeCustomWidget: 整个页面都自定义
  static Future alerts<T extends BubbleModel>(
    BuildContext context, {
    String? title,
    bool? titleBottomLine = false,
    String? content,
    bool? showCloseBtn = true,
    VoidCallback? closeTap,
    String? leftTitle,
    VoidCallback? leftTap,
    String? rightTitle,
    VoidCallback? rightTap,
    bool? isDismissible = false,
    Widget? customWidget,
    Widget? wholeCustomWidget,
    double? minHeight = 100,
    double? maxHeight,
    EdgeInsetsGeometry? topPadding,
  }) async {
    await showDialog(
      useSafeArea: false,
      barrierDismissible: isDismissible ?? false,
      builder: (BuildContext context) {
        return wholeCustomWidget ??
            AlertWidget(
              title: title,
              titleBottomLine: titleBottomLine,
              content: content,
              showCloseBtn: showCloseBtn,
              closeTap: closeTap,
              leftTitle: leftTitle,
              leftTap: leftTap,
              rightTitle: rightTitle,
              rightTap: rightTap,
              customWidget: customWidget,
              isDismissible: isDismissible,
              minHeight: minHeight,
              maxHeight: maxHeight,
              topPadding: topPadding,
            );
      },
      context: Get.context!,
    );
  }

  /// 底部列表弹框- 可多选
  /// context: 上下文
  /// list: 弹框数据源
  /// customWidget: 自定义UI
  /// showBottomBtn： 是否展示底部按钮
  /// haveAll: 是否有全部选择
  /// maxSelectCount: 最多可选多少个， 不设置，默认可选全部
  /// maxSelectToast: 设置了最后可选多少个后，选择超过个数后的提示语
  /// resetCustomCall: 重置逻辑自定义
  static Future doubleShows<T extends BubbleModel>(
    BuildContext context, {
    String? title,
    String? secondTitle,
    String? hint,
    String? secondHint,
    int? showTab = 0,
    double? height = 350,
    bool? isDismissible = false,
    List<T>? list,
    List<T>? secondList,
    Function(int index, T t)? selectOnTap,
    Widget? customWidget,
    String? defaultTitle,
    bool? showBottomBtn = true,
    bool? showBottomCancelBtn = false,
    bool? haveAll = true,
    bool? search = false,
    int? maxSelectCount,
    String? maxSelectToast,
    VoidCallback? closeTap,
    VoidCallback? cancelTap,
    ValueChanged<List<BubbleModel>?>? resetCustomCall,
    ValueChanged<int>? confirmTap,
    VoidCallback? updateTap,
  }) {
    /// 键盘监控
    RxList<T>? rows = <T>[].obs;
    TextEditingController? editingController;
    int index = 0;
    void buildList(List<T>? array) {
      rows.clear();
      if (search == true) {
        rows.addAll(array as Iterable<T>);
        editingController = TextEditingController()
          ..addListener(() {
            var items = array?.where((element) =>
                element.title.contains(editingController?.text ?? ''));
            rows.clear();
            if (items != null) rows.addAll(items);
            rows.refresh();
          });
      }
    }

    /// 记录选择状态的初始值，用于用户选择了但未选择确认，而是关闭了，还原原先的选则状态
    list?.forEach((e) => e.originalSelected = e.selected);

    /// 记录选择状态的初始值，用于用户选择了但未选择确认，而是关闭了，还原原先的选则状态
    secondList?.forEach((e) => e.originalSelected = e.selected);

    List<T> array = <T>[];
    var hintTitle = '';
    if (showTab == 0) {
      buildList(list);
      array = list ?? [];
      hintTitle = hint ?? '';
    } else {
      buildList(secondList);
      array = secondList ?? [];
      hintTitle = secondHint ?? '';
    }
    index = showTab ?? 0;

    /// 标题
    Widget buildTitleWidget() {
      return AlertDoubleTitleWidget(
        title: title,
        secondTitle: secondTitle,
        index: index,
        tabTap: (tabIndex) {
          index = tabIndex;
          if (tabIndex == 0) {
            buildList(list);
            array = list ?? [];
            secondList?.forEach((element) => element.selected = false);
            secondList?.first.selected = true;
            hintTitle = hint ?? '';
          } else {
            buildList(secondList);
            array = secondList ?? [];
            list?.forEach((element) => element.selected = false);
            list?.first.selected = true;
            hintTitle = secondHint ?? '';
          }
          rows.refresh();
        },
        closeTap: () {
          Get.back();
          list?.forEach(
              (element) => element.selected = element.originalSelected);
          secondList?.forEach(
              (element) => element.selected = element.originalSelected);
          closeTap?.call();
        },
      );
    }

    /// 列表view
    SheetViews buildSheetViews(List<T>? lists, List<T>? originalList) {
      return SheetViews(
        showTitle: false,
        title: title,
        list: lists,
        originalList: originalList,
        height: height,
        customWidget: customWidget ?? buildTitleWidget(),
        defaultTitle: defaultTitle,
        showBottomBtn: showBottomBtn,
        showBottomCancelBtn: showBottomCancelBtn,
        haveAll: haveAll,
        search: search,
        editingController: editingController,
        hint: hintTitle,
        closeTap: closeTap,
        cancelTap: cancelTap ?? Get.back,
        resetCustomCall: resetCustomCall,
        confirmTap: () => confirmTap?.call(index),
        updateTap: updateTap,
        maxSelectCount: maxSelectCount,
        maxSelectToast: maxSelectToast,
        selectOnTap: (int index, BubbleModel? model) {
          selectOnTap?.call(index, model as T);
          Get.back();
        },
      );
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: isDismissible ?? true,
        builder: (BuildContext context) {
          return RouterObserver().routerObserver(
            Get.context!,
            () => Obx(() => search == true
                ? buildSheetViews(rows, array)
                : buildSheetViews(array, array)),
            onWillPop: () async {
              Get.back();
              closeTap?.call();
              return false;
            },
          );
        },
        context: context);
  }
}
