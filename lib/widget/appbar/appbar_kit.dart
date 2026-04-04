import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils/theme_color.dart';

class AppBarKit {
  static AppBar appBar(
    String title, {
    Color backgroundColor = ThemeColor.themeColor,
    Color? surfaceTintColor = Colors.white,
    Color textColor = Colors.white,
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
              child: Container(color: Colors.transparent, height: 1.0),
              preferredSize: Size.fromHeight(1.0)),
      leading: leading ??
          IconButton(
            onPressed: backTap == null ? Get.back : backTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: ThemeColor.whiteColor,
              size: 24,
            ),
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
