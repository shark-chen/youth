import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../generated/locales.g.dart';
import '../../../utils/extension/lists/lists.dart';
import '../../../utils/extension/strings/strings.dart';
import '../../../utils/marco/marco.dart';
import '../../../utils/utils/theme_color.dart';
import '../../bubble/model/bubble_model.dart';
import '../../button/bottom_button/bottom_button.dart';
import '../../search/search_base_view.dart';
import '../../space_widget/default_space_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'sheets_view_cell.dart';

/// FileName sheets_view
///
/// @Author 谌文
/// @Date 2024/6/19 13:24
///
/// @Description 列表view
class SheetViews extends StatelessWidget {
  SheetViews({
    Key? key,
    this.showTitle = true,
    this.title,
    List<BubbleModel>? list,
    this.originalList,
    this.height,
    this.showBottomBtn = false,
    this.showBottomCancelBtn = false,
    this.customWidget,
    this.defaultTitle,
    this.haveAll,
    this.search = false,
    this.selectOnTap,
    this.closeTap,
    this.cancelTap,
    this.resetCustomCall,
    this.confirmTap,
    this.editingController,
    this.hint,
    this.updateTap,
    this.maxSelectCount,
    this.maxSelectToast,
  }) : super(key: key) {
    if (Lists.isNotEmpty(list)) {
      this.list.value = list!;
    }
  }

  /// 是否展示标题
  final bool? showTitle;

  /// 标题
  final String? title;

  /// 弹框高度
  final double? height;

  /// 列表选项数据框
  final RxList<BubbleModel> list = <BubbleModel>[].obs;

  /// 搜索前的原始数据
  final List<BubbleModel>? originalList;

  /// 选择回调
  final Function(int index, BubbleModel? model)? selectOnTap;

  /// 是否展示底部按钮， 默认不展示
  final bool? showBottomBtn;

  /// 是否展示底部取消按钮， 默认不展示
  final bool? showBottomCancelBtn;

  /// 点击关闭按钮回调
  final VoidCallback? closeTap;

  /// 点击取消按钮
  final VoidCallback? cancelTap;

  /// 重置逻辑自定义
  final ValueChanged<List<BubbleModel>?>? resetCustomCall;

  /// 确定事件
  final VoidCallback? confirmTap;

  /// 自定义view
  final Widget? customWidget;

  /// 缺省文案
  final String? defaultTitle;

  /// 是否有全部选择
  final bool? haveAll;

  /// 是否支持搜索
  final bool? search;

  /// editingController
  final TextEditingController? editingController;

  /// 输入框提示语
  final String? hint;

  /// 点击刷新
  final VoidCallback? updateTap;

  /// 最大可选数量- 不设置 则全部可选
  final int? maxSelectCount;

  /// 最大可选数量- 不设置 则全部可选 - 提示语
  final String? maxSelectToast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: (height ?? 350) + bottomPadding,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      child: Column(
        children: [
          /// 头部标题部分 - 兼容PDA - enter按键
          (showBottomBtn ?? false)
              ? titleWidget()
              : KeyboardListener(
                  focusNode: FocusNode(),
                  autofocus: true,
                  onKeyEvent: (rawKeyEvent) {
                    if (rawKeyEvent.runtimeType == KeyDownEvent &&
                        rawKeyEvent.logicalKey == LogicalKeyboardKey.enter) {}
                  },
                  child: titleWidget(),
                ),

          /// 自定义UI
          Visibility(
              visible: customWidget != null,
              child: customWidget ?? Container()),

          /// 搜索框
          Visibility(
            visible: search == true,
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: SearchBaseWidget(
                hint: hint ?? LocaleKeys.pleaseEnterStoreName.tr,
                controller: editingController,
                onSubmitted: (_) => FocusScope.of(context).unfocus,
              ),
            ),
          ),

          /// 列表部分
          Obx(() => _selectView(list)),

          /// 缺省图
          Visibility(
            visible: Strings.isNotEmpty(defaultTitle) &&
                (Lists.isEmpty(originalList)),
            child: Expanded(
                child: DefaultSpaceWidget(
              prompt: defaultTitle,
              showRefreshBtn: true,
              onTap: updateTap,
            )),
          ),

          /// 底部按钮
          Visibility(
            visible: showBottomBtn ?? false,
            child: BottomButton(
              showLine: false,
              leftTitle: LocaleKeys.reset.tr,
              leftTap: () {
                if (resetCustomCall != null) {
                  resetCustomCall?.call(list);
                } else {
                  list.forEach((element) => element.selected = false);

                  /// 存在搜素的时候
                  if (Strings.isNotEmpty(editingController?.text) &&
                      list.where((p0) => p0.selected == true).toList().length ==
                          0) {
                    EasyLoading.showToast(LocaleKeys.NoSearch.tr);
                    return;
                  }
                  list.first.selected = true;
                }
                list.refresh();
              },
              rightTitle: LocaleKeys.Confirm.tr,
              rightTap: () {
                list.forEach(
                    (element) => element.originalSelected = element.selected);
                var rows = list.where((p0) => p0.selected == true).toList();
                if (Strings.isNotEmpty(editingController?.text) &&
                    rows.length == 0) {
                  EasyLoading.showToast(LocaleKeys.NoSearch.tr);
                  return;
                }
                if (rows.length == 0) {
                  list.first.selected = true;
                }
                confirmTap?.call();
              },
            ),
          ),

          /// 底部按钮
          Visibility(
            visible: showBottomCancelBtn ?? false,
            child: BottomButton(
              showLine: false,
              leftTitle: LocaleKeys.Cancel.tr,
              leftTap: () {
                closeFiltrate();
                cancelTap?.call();
              },
              rightTitle: LocaleKeys.Confirm.tr,
              rightTap: () {
                var rows = list.where((p0) => p0.selected == true).toList();
                if (Strings.isNotEmpty(editingController?.text) &&
                    rows.length == 0) {
                  EasyLoading.showToast(LocaleKeys.NoSearch.tr);
                  return;
                }
                confirmTap?.call();
              },
            ),
          )
        ],
      ),
    );
  }

  /// 标题
  Widget titleWidget() {
    return Visibility(
      visible: showTitle != false,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 40),
            Expanded(child: Container()),
            Text(title ?? '',
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: ThemeColor.mainTextColor)),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Get.back();
                closeFiltrate();
                closeTap?.call();
              },
              child: const Icon(
                Icons.close,
                color: ThemeColor.mainTextColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  /// 选择列表
  Widget _selectView(List rows) {
    return Expanded(
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(bottom: 10),
        itemCount: rows.length,
        itemBuilder: (BuildContext context, int index) => SheetsViewCell(
            color: rows[index].color ?? null,
            title: rows[index].title ?? '',
            selected: rows[index].selected,
            enabled: rows[index].enabled,
            onTap: () => handleSelect(rows[index])),
        separatorBuilder: (BuildContext context, int index) => Container(
          height: 1,
          color: ThemeColor.lineColor,
        ),
      ),
    );
  }

  /// 处理点击事件逻辑
  void handleSelect(BubbleModel item) {
    if (item.enabled == false) {
      if (Strings.isNotEmpty(item.disabledToast)) {
        EasyLoading.showToast(item.disabledToast ?? '');
      }
      return;
    }

    /// 最多可选多少个
    if ((maxSelectCount ?? 0) > 0) {
      var rows = list.where((p0) => p0.selected == true).toList();
      if (rows.length >= (maxSelectCount ?? 0) && item.selected == false) {
        if (Strings.isNotEmpty(maxSelectToast)) {
          EasyLoading.showToast(maxSelectToast ?? '');
        }
        return;
      }
    }
    try {
      /// 选择了全部
      if (item.labelId == 'all') {
        item.selected = !(item.selected ?? false);
        list.forEach((element) {
          if (element.enabled == true) {
            element.selected = item.selected;
          }
        });
      } else {
        item.selected = !(item.selected ?? false);

        /// 找出除全部之外其他是否有选择项
        var rows = originalList
            ?.where((p0) => p0.selected == true && p0.labelId != 'all')
            .toList();
        if (Lists.isEmpty(rows)) {
          /// 全部子选项都没选上了，则全部选上
          originalList?.forEach((element) {
            if (element.enabled == true) {
              (element.labelId == 'all') ? element.selected = true : null;
            }
          });
        } else if (haveAll == true && rows?.length == ((originalList?.length ?? 0) - 1)) {
          /// 全部子选项都选上了，则全部也选上
          originalList?.forEach((element) {
            if (element.enabled == true) {
              element.selected = true;
            }
          });
        } else {
          originalList?.forEach((element) {
            if (element.enabled == true) {
              (element.labelId == 'all') ? element.selected = false : null;
            }
          });
        }
      }
    } finally {
      list.refresh();
    }
  }

  /// 点击右上角关闭筛选页面
  void closeFiltrate() {
    list.forEach((element) => element.selected = element.originalSelected);
  }
}
