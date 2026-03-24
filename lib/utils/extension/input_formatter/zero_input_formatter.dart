import 'package:flutter/services.dart';

/// FileName zero_input_formatter
///
/// @Author 谌文
/// @Date 2024/11/21 20:14
///
/// @Description 输入框的值不能为0  也就说首位不能输入0
class ZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    /// 如果输入的首位是0，且长度1，则拒绝输入
    if (newValue.text.startsWith('0') && newValue.text.length == 1) {
      return oldValue;
    }

    /// 如果是直接输入0并长度为1，允许输入
    return newValue;
  }
}
