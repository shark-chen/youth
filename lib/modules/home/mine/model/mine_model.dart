import 'package:flutter/material.dart';

/// FileName mine_model
///
/// @Author 谌文
/// @Date 2025/2/19 10:08
///
/// @Description 我的页面模型
class MineModel {
  MineModel({
    this.title,
    this.content,
    this.middleContent,
    this.middleContentStyle,
    this.routeName,
    this.routeParameter,
    this.showArrow = true,
    this.isSection = false,
    this.showRed = false,
    this.notVisible = false,
  });

  /// 标题
  String? title;

  /// 内容
  String? content;

  /// 中间内容
  String? middleContent;

  /// 中间内容样式
  TextStyle? middleContentStyle;

  /// 是否显示箭头
  bool? showArrow;

  /// 路由名称
  String? routeName;

  /// 路由名称
  Map<String, String>? routeParameter;

  /// 链接
  String? pushUrl;

  /// 是否是分区
  bool? isSection;

  /// 展示小红点
  bool? showRed;

  /// 整个cell是是否展示
  bool? notVisible;
}
