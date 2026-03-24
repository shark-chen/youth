import '../../generated/json/convert/json_convert_content.dart';
export '../../generated/json/convert/json_convert_content.dart';

/// FileName model_utils
///
/// @Author 谌文
/// @Date 2023/5/8 16:56
///
/// @Description 模型工具
///
class ModelUtils {
  /// 解析数据model工具
  static T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    return jsonConvert.convert<T>(value, enumConvert: enumConvert);
  }

  /// 数组
  static List<T?>? convertList<T>(
    List<dynamic>? value, {
    EnumConvertFunction? enumConvert,
  }) {
    return jsonConvert.convertList<T>(value, enumConvert: enumConvert);
  }

  /// 数组
  static List<T>? convertListNotNull<T>(
    dynamic value, {
    EnumConvertFunction? enumConvert,
  }) {
    return jsonConvert.convertListNotNull<T>(value, enumConvert: enumConvert);
  }
}
