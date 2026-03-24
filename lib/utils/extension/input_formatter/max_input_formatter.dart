import 'package:youth/utils/extension/strings/strings.dart';
import 'package:flutter/services.dart';

/// FileName max_input_formatter
///
/// @Author 谌文
/// @Date 2024/12/31 15:45
///
/// @Description 输入框限制 可输入10位整数和两位小数
class MaxInputFormatter extends TextInputFormatter {
  MaxInputFormatter({this.regExp, this.maxValue}) {
    if (this.regExp == null) {
      this.regExp = RegExp(r'^\d{0,10}(\.\d{0,2})?$');
    }
    if (this.maxValue == null) {
      this.maxValue = 9999999999.99;
    }
  }

  /// 正则表达式
  RegExp? regExp;

  /// 可输入的最大值
  num? maxValue;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (regExp?.hasMatch(newValue.text) ?? true) {
      return newValue;
    } else {
      if (newValue.text.isNumeric &&
          (int.tryParse(newValue.text) ?? 0) > (maxValue ?? 9999999999.99)) {
        return TextEditingValue(text: maxValue.toString());
      }
      return oldValue;
    }
  }
}
