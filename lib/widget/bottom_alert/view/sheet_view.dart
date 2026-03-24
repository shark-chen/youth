import 'package:youth/generated/locales.g.dart';
import 'package:youth/utils/marco/marco.dart';
import 'package:youth/widget/button/bottom_button/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/extension/lists/lists.dart';
import '../../../utils/extension/strings/strings.dart';
import '../../../utils/utils/theme_color.dart';
import '../../base_list_item/base_list_item.dart';
import '../../bubble/model/bubble_model.dart';

/// FileName sheet_view
///
/// @Author 谌文
/// @Date 2023/12/21 10:39
///
/// @Description 列表view
typedef CustomItemCellCallback = Widget Function(
    int index, BubbleModel? model)?;

class SheetView extends StatelessWidget {
  const SheetView({
    Key? key,
    this.title,
    this.list,
    this.customItemCellCall,
    this.height,
    this.width,
    this.showBottomBtn = false,
    this.customWidget,
    this.defaultTitle,
    this.selectOnTap,
    this.showCloseBtn = true,
    this.closeTap,
    this.cancelTap,
    this.confirmTap,
    this.leftTitle,
    this.rightTitle,
    this.centrePop = false,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 宽度
  final double? width;

  /// 弹框高度
  final double? height;

  /// 列表选项数据框
  final List<BubbleModel>? list;

  /// 自定义cell回调
  final CustomItemCellCallback? customItemCellCall;

  /// 选择回调
  final Function(int index, BubbleModel? model)? selectOnTap;

  /// 是否展示底部按钮， 默认不展示
  final bool? showBottomBtn;

  /// 是否显示关闭按钮 默认显示
  final bool? showCloseBtn;

  /// 点击关闭按钮回调
  final VoidCallback? closeTap;

  /// 点击取消按钮
  final VoidCallback? cancelTap;

  /// 确定事件
  final VoidCallback? confirmTap;

  /// 自定义view
  final Widget? customWidget;

  /// 缺省文案
  final String? defaultTitle;

  /// 左右边标题
  final String? leftTitle;
  final String? rightTitle;

  /// 是否中间弹出
  final bool? centrePop;

  @override
  Widget build(BuildContext context) {
    final view = Container(
      width: width ?? Get.width,
      height: (height ?? 350) + ((centrePop ?? false) ? 0 : bottomPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: centrePop == true
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
      ),
      child: Column(
        children: [
          KeyboardListener(
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
            child: customWidget ?? Container(),
          ),

          /// 列表部分
          Visibility(
            visible: Lists.isNotEmpty(list),
            child: Expanded(
              child: ListView.separated(
                itemCount: list?.length ?? 0,
                itemBuilder: (BuildContext context, int index) =>
                    customItemCellCall?.call(index, list?[index]) ??
                    BaseListItem(
                      title: list?[index].title ?? '',
                      line: false,
                      selected: list?[index].selected,
                      onTap: () => selectOnTap?.call(index, list?[index]),
                    ),
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  height: 1,
                  color: ThemeColor.lineColor,
                ),
              ),
            ),
          ),

          /// 缺省图
          Visibility(
            visible: Strings.isNotEmpty(defaultTitle) && Lists.isEmpty(list),
            child: Text(
              defaultTitle ?? '',
              style: const TextStyle(
                  fontSize: 16,
                  color: ThemeColor.mainTextColor,
                  fontWeight: FontWeight.w500),
            ),
          ),

          /// 底部按钮
          Visibility(
            visible: showBottomBtn ?? false,
            child: BottomButton(
              showLine: false,
              leftTitle: leftTitle ?? LocaleKeys.Cancel.tr,
              leftTap: cancelTap,
              rightTitle: rightTitle ?? LocaleKeys.Confirm.tr,
              rightTap: confirmTap,
            ),
          )
        ],
      ),
    );

    if (centrePop == true) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: view,
          ),
        ),
      );
    }
    return view;
  }

  Widget titleWidget() {
    return Visibility(
      visible: Strings.isNotEmpty(title) || (showCloseBtn ?? true),
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
            Visibility(
              visible: showCloseBtn ?? true,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  closeTap?.call();
                },
                child: const Icon(
                  Icons.close,
                  color: ThemeColor.mainTextColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
