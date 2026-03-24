import 'package:flutter/material.dart';

import '../../utils/extension/strings/strings.dart';

/// FileName trend_sheet_cell
///
/// @Author 谌文
/// @Date 2024/5/30 16:54
///
/// @Description/// 分割线
class TrendSheetCell extends StatelessWidget {
  const TrendSheetCell({
    Key? key,
    this.title,
    this.rightTitle,
    this.titleWidth = 30,
    this.height,
  }) : super(key: key);

  /// 高度
  final double? height;

  /// Y轴标题
  final String? title;

  /// Y轴右侧标题
  final String? rightTitle;

  /// 标题宽度
  final double? titleWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Row(
        children: [
          /// Y轴标题
          Container(
            alignment: Alignment.centerLeft,
            width: (titleWidth ?? 30) - 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.right,
                    title ?? '',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF919099)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 3),
          Expanded(child: Container(color: const Color(0xFFf2f2f2), height: 1)),

          /// Y轴右侧标题
          Visibility(
            visible: Strings.isNotEmpty(rightTitle),
            child: Container(
              alignment: Alignment.centerRight,
              width: (titleWidth ?? 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.right,
                      rightTitle ?? '',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF919099)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
