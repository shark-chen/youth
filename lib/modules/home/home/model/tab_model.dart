import 'package:flutter/cupertino.dart';

/// FileName tab_model
///
/// @Author 谌文
/// @Date 2023/8/24 11:09
///
/// @Description 选择tab模型
class HomePageModel {
  HomePageModel({
    required this.page,
    required this.activeLogo,
    required this.logo,
    required this.name,
    this.introduceTitle,
    this.introduceContent,
  });

  /// 页面
  Widget page;

  /// 激活选择时候图标
  String activeLogo;

  /// 图标
  String logo;

  /// 名字
  String name;

  /// 页面功能介绍标题
  final String? introduceTitle;

  /// 页面功能介绍内容
  final String? introduceContent;
}
