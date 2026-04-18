import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youth/utils/utils/theme_color.dart';

/// 更改密码底部弹层：6 位数字密码 +「修改密码」入口 + 确定（风格对齐 [EditGenderSheetWidget] / [EditNickNameSheetWidget]）
class EditChangePasswordSheetWidget extends StatefulWidget {
  const EditChangePasswordSheetWidget({
    super.key,
    this.title,
    this.closeTap,
    this.onConfirm,
    this.onModifyPasswordTap,
  });

  /// 标题
  final String? title;

  final VoidCallback? closeTap;

  /// 输入满 6 位数字后点击确定
  final ValueChanged<String>? onConfirm;

  /// 右侧「修改密码」
  final VoidCallback? onModifyPasswordTap;

  @override
  State<EditChangePasswordSheetWidget> createState() =>
      _EditChangePasswordSheetWidgetState();
}

class _EditChangePasswordSheetWidgetState
    extends State<EditChangePasswordSheetWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final s = _controller.text;
    if (s.length != 6) return;
    widget.onConfirm?.call(s);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox.shrink()),
        AnimatedPadding(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(bottom: bottomInset > 500 ? 500 : bottomInset),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: Get.width,
            decoration: const BoxDecoration(
              color: ThemeColor.textBlackColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title ?? '更改密码',
                        style: TextStyle(
                          color: ThemeColor.whiteColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: widget.closeTap,
                      icon: Icon(
                        Icons.close,
                        color: ThemeColor.whiteColor.withOpacity(0.9),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '请输入当前的6位 数字密码',
                  style: TextStyle(
                    color: ThemeColor.white6Color,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: List.generate(6, (i) {
                          final text = _controller.text;
                          final has = text.length > i;
                          final ch = has ? text[i] : '';
                          final active = _focusNode.hasFocus &&
                              (text.length == i || (text.length == 6 && i == 5));
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: i < 5 ? 8 : 0),
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ThemeColor.doingListCellBgColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: active
                                        ? ThemeColor.themeGreenColor
                                            .withOpacity(0.65)
                                        : Colors.white.withOpacity(0.08),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  ch,
                                  style: TextStyle(
                                    color: ThemeColor.whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          color: Colors.transparent,
                          fontSize: 1,
                          height: 0.01,
                        ),
                        cursorColor: Colors.transparent,
                        showCursor: false,
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => _submit(),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: widget.onModifyPasswordTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '修改密码',
                            style: TextStyle(
                              color: ThemeColor.whiteColor,
                              fontSize: 14,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: ThemeColor.whiteColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _controller.text.length == 6 ? _submit : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _controller.text.length == 6
                          ? ThemeColor.themeGreenColor
                          : ThemeColor.themeGreenColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: ThemeColor.themeColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
