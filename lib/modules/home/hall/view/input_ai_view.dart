import 'package:flutter/services.dart';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/modules/modules.dart';

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

/// FileName: input_ai_view
///
/// @Author 谌文
/// @Date 2026/3/26 23:32
///
/// @Description AI-输入框
class InputAiWidget extends BaseStatelessWidget {
  const InputAiWidget({
    Key? key,
    this.error,
    this.hint,
    this.inputTap,
    this.onSubmittedTap,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength = 30,
  }) : super(key: key);

  /// 最多可输入字符数（默认 30，用于「正在做的事」等）
  static const int defaultMaxLength = 30;

  /// 错误
  final String? error;

  /// 输入框点击
  final VoidCallback? inputTap;

  /// 输入框点击
  final ValueChanged? onSubmittedTap;

  /// 输入框监控
  final TextEditingController? controller;

  /// FocusNode
  final FocusNode? focusNode;

  /// 输入框提示语
  final String? hint;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  /// 输入上限；满后不可继续输入，粘贴内容仅保留前 [maxLength] 字
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final formatters = <TextInputFormatter>[
      _TruncateToMaxLengthFormatter(maxLength),
      ...?inputFormatters,
    ];
    return Container(
      alignment: Alignment.center,
      height: 48,
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.only(left: 18),
      margin: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: onSubmittedTap,
              autocorrect: false,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: ThemeColor.whiteColor,
                  fontSize: 14),
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType ?? TextInputType.text,
              maxLength: maxLength,
              inputFormatters: formatters,
              onTap: inputTap,
              decoration: InputDecoration(
                isDense: true,
                counterText: '',
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ThemeColor.whiteColor.withOpacity(0.4),
                    fontSize: 14),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onSubmittedTap?.call(controller?.text),
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: ThemeColor.themeGreenColor,
              ),
              child: Image.asset(
                "assets/image/common/send@3x.png",
                width: 36,
                height: 36,
              ),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
