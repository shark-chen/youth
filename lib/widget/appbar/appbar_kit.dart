import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils/theme_color.dart';

class AppBarKit {
  static AppBar appBar(
    String title, {
    Color backgroundColor = Colors.white,
    Color? surfaceTintColor = Colors.white,
    Color textColor = Colors.black,
    double elevation = 1.0,
    double toolbarHeight = 44,
    double? leadingWidth,
    double? titleSpacing,
    List<Widget>? actions,
    Widget? customTitle,
    PreferredSizeWidget? bottom,
    Widget? leading,
    Color? leadingColor,
    VoidCallback? backTap,
  }) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      actions: actions,
      bottom: bottom ??
          PreferredSize(
              child: Container(color: ThemeColor.lineColor, height: 1.0),
              preferredSize: Size.fromHeight(1.0)),
      leading: leading ??
          IconButton(
            onPressed: backTap == null ? Get.back : backTap,
            icon: Image.asset("assets/image/common/common_back_arrow@3x.png",
                width: 24, height: 24, color: leadingColor),
          ),
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      titleTextStyle: TextStyle(
          color: textColor, fontSize: 18, fontWeight: FontWeight.w700),
      title: (customTitle != null)
          ? customTitle
          : Text(title, textAlign: TextAlign.center),
    );
  }
}
