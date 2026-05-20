import 'package:flutter/services.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// 超出 [maxLength] 时截断为前 [maxLength] 个字符（含粘贴）。
class _TruncateToMaxLengthFormatter extends TextInputFormatter {
  const _TruncateToMaxLengthFormatter(this.maxLength);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.length <= maxLength) return newValue;
    final truncated = text.substring(0, maxLength);
    return TextEditingValue(
      text: truncated,
      selection: TextSelection.collapsed(offset: truncated.length),
      composing: TextRange.empty,
    );
  }
}

/// 用户详情 — 邀请对方一起做（底部弹层内容）
class InvitePartnerTogetherSheetWidget extends StatefulWidget {
  const InvitePartnerTogetherSheetWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.closeTap,
    this.onConfirm,
    this.maxLength = 30,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? closeTap;
  final ValueChanged<String>? onConfirm;
  final int maxLength;

  @override
  State<InvitePartnerTogetherSheetWidget> createState() =>
      _InvitePartnerTogetherSheetWidgetState();
}

class _InvitePartnerTogetherSheetWidgetState
    extends State<InvitePartnerTogetherSheetWidget> {
  bool _canConfirm = false;

  @override
  void initState() {
    super.initState();
    _canConfirm = widget.controller.text.trim().isNotEmpty;
    widget.controller.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final next = widget.controller.text.trim().isNotEmpty;
    if (next != _canConfirm) {
      setState(() => _canConfirm = next);
    }
  }

  void _handleConfirm() {
    if (!_canConfirm) return;
    widget.onConfirm?.call(widget.controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: GestureDetector(onTap: widget.closeTap)),
        AnimatedPadding(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(bottom: bottomInset > 500 ? 500 : bottomInset),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: ThemeColor.themeColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '邀请对方一起做',
                        style: TextStyle(
                          color: ThemeColor.whiteColor,
                          fontSize: 18,
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
                  '输入你想和TA一起做的事情，其他用户不可见',
                  style: TextStyle(
                    color: ThemeColor.secondaryTextColor,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  maxLength: widget.maxLength,
                  maxLines: 3,
                  minLines: 2,
                  inputFormatters: [
                    _TruncateToMaxLengthFormatter(widget.maxLength),
                  ],
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 15,
                  ),
                  cursorColor: ThemeColor.themeGreenColor,
                  scrollPadding: const EdgeInsets.only(bottom: 120),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColor.doingListCellBgColor,
                    hintText: '请输入…',
                    hintStyle: TextStyle(
                      color: ThemeColor.secondaryTextColor,
                      fontSize: 15,
                    ),
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeColor.themeGreenColor.withOpacity(0.65),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _canConfirm ? _handleConfirm : null,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _canConfirm
                          ? ThemeColor.themeGreenColor
                          : ThemeColor.themeGreenColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(24),
                    ),
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
