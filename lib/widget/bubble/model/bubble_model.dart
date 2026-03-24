import 'package:youth/generated/json/convert/json_convert_content.dart';
import '../../../utils/extension/maps/maps.dart';
import 'package:flutter/material.dart';

/// FileName bubble_model
///
/// @Author 谌文
/// @Date 2023/10/18 09:35
///
/// @Description 气泡模型
class BubbleModel<T> {
  BubbleModel({
    required this.title,
    this.key,
    this.subTitle,
    this.selected = false,
    this.originalSelected = false,
    this.enabled = true,
    this.showArrow,
    this.labelId,
    this.other,
    this.onTap,
    this.switchTap,
  });

  /// id
  String? key;

  /// 标题
  String title;

  /// 副标题
  String? subTitle;

  /// 是否选中
  bool? selected;

  /// 选择前的初始状态
  bool? originalSelected;

  /// 标识，比如ID
  String? labelId;

  /// 表示是否可选，不可选置灰， 默认可选
  bool? enabled = true;

  /// 不可选，点击提示语
  String? disabledToast;

  /// 颜色
  String? color;

  /// 扩展数据
  T? other;

  /// 点击事件回调
  VoidCallback? onTap;

  /// 字体文字样式
  TextStyle? titleStyle;

  /// is set to null.
  double? fontSize;

  /// The typeface thickness to use when painting the text (e.g., bold).
  FontWeight? fontWeight;

  /// 标题文字样式
  TextStyle? textStyle;

  /// 内容文字样式
  TextStyle? contentStyle;

  /// 开关按钮点击
  final ValueChanged<bool>? switchTap;

  /// 是否展示箭头
  bool? showArrow;

  /// 是否显示复制按钮
  bool? showCopy;

  factory BubbleModel.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      BubbleModel<T> baseModelEntity = BubbleModel(title: '');
      final String? title = jsonConvert.convert<String>(json['title']);
      if (title != null) {
        baseModelEntity.title = title;
      }
      final String? key = jsonConvert.convert<String>(json['key']);
      if (key != null) {
        baseModelEntity.key = key;
      }
      final String? subTitle = jsonConvert.convert<String>(json['subTitle']);
      if (subTitle != null) {
        baseModelEntity.subTitle = subTitle;
      }
      final bool? selected = jsonConvert.convert<bool>(json['selected']);
      if (selected != null) {
        baseModelEntity.selected = selected;
      }
      final String? labelId = jsonConvert.convert<String>(json['labelId']);
      if (labelId != null) {
        baseModelEntity.labelId = labelId;
      }
      final bool? enabled = jsonConvert.convert<bool>(json['enabled']);
      if (enabled != null) {
        baseModelEntity.enabled = enabled;
      }
      final String? color = jsonConvert.convert<String>(json['color']);
      if (color != null) {
        baseModelEntity.color = color;
      }
      final T? other = jsonConvert.convert<T>(json['other']);
      if (other != null) {
        baseModelEntity.other = other;
      }
      return baseModelEntity;
    }
    return BubbleModel(title: '');
  }

  factory BubbleModel.copy(BubbleModel model) {
    return BubbleModel(title: model.title)
      ..subTitle = model.subTitle
      ..selected = model.selected
      ..labelId = model.labelId
      ..color = model.color
      ..other = model.other
      ..enabled = model.enabled
      ..key = model.key;
  }

  /// 将对象转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'subTitle': subTitle,
      'selected': selected,
      'labelId': labelId,
      'enabled': enabled,
      'color': color,
      'other': other,
    };
  }
}
