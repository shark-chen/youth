import 'package:youth/generated/json/succeed/associate_entity.g.dart';
import 'dart:convert';
import '../../../../utils/extension/maps/maps.dart';
import '../../../../utils/extension/strings/strings.dart';
import 'package:flutter/material.dart';
import '../../../../utils/utils/theme_color.dart';

class AssociateEntity {
  ///  type
  /// 0  SKU编号
  /// 1  GTIN码
  /// 2  商品编码
  /// 3  商品名称
  /// 4  货架位
  /// 5  SPU编码
  int? type;
  int? id;
  String? name;

  /// 自定义字段
  String? front;
  String? center;
  String? back;
  String? original;
  String? subTitle;

  /// 类型
  String? typeStr;
  Color? textColor;

  /// 颜色
  Color? color;
  Color? broderColor;

  /// 其他接口字段
  int? skuId;
  String? sku;
  String? title;

  AssociateEntity();

  factory AssociateEntity.fromJson(Map<String, dynamic> json) {
    if (Maps.isNotEmpty(json)) {
      final result = $AssociateEntityFromJson(json);
      switch (result.type) {
        case 0:
          {
            result.typeStr = 'SKU';
            result.textColor = ThemeColor.deepBlueColor;
            result.color = ThemeColor.turquoiseColor;
            result.broderColor = ThemeColor.labelBlueColor;
          }
          break;
        case 1:
          {
            result.typeStr = 'GTIN';
            result.color = ThemeColor.labelVioletColor;
            result.broderColor = ThemeColor.bluerColor;
          }
          break;
        case 2:
          {
            result.typeStr = 'Code';
            result.color = ThemeColor.labelOrangeColor;
            result.broderColor = ThemeColor.labelOrangeBroderColor;
          }
          break;
        case 3:
          {
            result.typeStr = 'Name';
            result.color = ThemeColor.labelGreenColor;
            result.broderColor = ThemeColor.labelGreenBroderColor;
          }
          break;
        case 4:
          {
            result.typeStr = 'Shelf';
            result.color = ThemeColor.labelGreenColor;
            result.broderColor = ThemeColor.labelGreenBroderColor;
          }
          break;
        case 5:
          {
            result.typeStr = 'Spu';
            result.color = ThemeColor.labelGreenColor;
            result.broderColor = ThemeColor.labelGreenBroderColor;
          }
          break;
      }
      return result;
    }
    return AssociateEntity();
  }

  /// 格式处理数据，用户高亮搜索内容
  void regExp(String? content, String searchContent) {
    if (Strings.isNotEmpty(content)) {
      original = content;
      if (content?.toLowerCase().contains(searchContent.toLowerCase()) ??
          false) {
        /// 将搜索结果中的字符串中包含(不分大小写) 替换成searchContent
        RegExp regex = RegExp(searchContent, caseSensitive: false);
        center = searchContent;
        String newString = content!.replaceFirstMapped(regex, (match) {
          center = content.substring(match.start, match.end);
          return searchContent;
        });

        /// 然后在以searchContent来截取出需要蓝色,灰色展示的字体
        int index = newString.indexOf(searchContent);
        if (index != -1) {
          front = newString.substring(0, index);
          back = newString.substring(
              index + searchContent.length, newString.length);
        }
      } else {
        /// 兼容后端返回查询有问题的情况
        front = content;
      }
    }
  }

  Map<String, dynamic> toJson() => $AssociateEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
