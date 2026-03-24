import 'dart:typed_data';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

/// FileName: esc_pos_convert
///
/// @Author 谌文
/// @Date 2025/9/19 16:08
///
/// @Description flutter_esc_pos_utils库的 类转换工具
/// 表单映射
PosColumn EscPosColumn({
  String text = '',
  Uint8List? textEncoded,
  bool containsChinese = false,
  int width = 2,
  PosStyles styles = const PosStyles(),
}) {
  return PosColumn(
    text: text,
    textEncoded: textEncoded,
    containsChinese: containsChinese,
    width: width,
    styles: styles,
  );
}

/// 字体大小映射
PosStyles EscPosStyles({
  bool bold = false,
  bool reverse = false,
  bool underline = false,
  bool turn90 = false,
  EscPosAlign align = EscPosAlign.left,
  String? codeTable,
}) {
  var posStylesAlign;
  switch (align) {
    case EscPosAlign.left:
      posStylesAlign = PosAlign.left;
      break;
    case EscPosAlign.center:
      posStylesAlign = PosAlign.center;
      break;
    case EscPosAlign.right:
      posStylesAlign = PosAlign.right;
      break;
  }
  return PosStyles(
    bold: bold,
    reverse: reverse,
    underline: underline,
    turn90: turn90,
    align: posStylesAlign,
    height: PosTextSize.size1,
    width: PosTextSize.size1,
    codeTable: codeTable,
  );
}

/// Code128映射Barcode
Barcode EscCode128(String code) {
  return Barcode.code128(code.split(''));
}

/// 对齐映射
PosAlign escPosAlign(EscPosAlign posAlign) {
  var align;
  switch (posAlign) {
    case EscPosAlign.left:
      align = PosAlign.left;
      break;
    case EscPosAlign.center:
      align = PosAlign.center;
      break;
    case EscPosAlign.right:
      align = PosAlign.right;
      break;
  }
  return align;
}

/// 小票尺寸
enum EscPaperSize { mm58, mm72, mm80 }

/// 对齐枚举
enum EscPosAlign { left, center, right }
