import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Getx;

/// FileName marco
///
/// @Author 谌文
/// @Date 2023/5/15 15:05
///
/// @Description 宏程序
late final data = MediaQueryData.fromView(WidgetsBinding.instance.window);

/// 物理尺寸
Size get getPhysicalSize => WidgetsBinding.instance.window.physicalSize;

/// 获取下边黑线高度(下边距)
late final double bottomPadding = data.padding.bottom;

/// 获取状态栏高度
late final double topPadding = data.padding.top;

/// 屏幕宽
double get screenWidth => Get.mediaQuery.size.width;

/// 屏幕高
double get screenHeight => Get.mediaQuery.size.height;

/// 是否是isPhoneX
late final bool isPhoneX = (GetPlatform.isIOS && topPadding > 30.0);

/// 是否为挖孔屏
late final bool isDigHolePhone = (GetPlatform.isAndroid && topPadding > 30.0);

/// 底部tab高度
late final double bottomNavigationBarHeight =
    (kBottomNavigationBarHeight + bottomPadding);

/// 键盘的高度
double keyboardHeight() => MediaQuery.of(Get.context!).viewInsets.bottom;

/// 是否是苹果
late final bool isIOS = Getx.GetPlatform.isIOS;

/// 是否是大于等于10英寸大小的iPad
bool isLandscapePad = false;

/// 邮箱登录验证
RegExp passwordReg = RegExp(
    r'^(?![0-9]+$)(?![a-zA-Z]+$)(?![\u0021-\u002F\u003A-\u0040\u005B-\u0060\u007B-\u007E]+$)[0-9A-Za-z\u0021-\u002F\u003A-\u0040\u005B-\u0060\u007B-\u007E]{8,20}$');

/// 库存最大可输入数量
int maxNum = 99999999;

/// 安全路由 - 及页面出现了跳转下一个页面
void safeNavigate(VoidCallback action) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    action.call();
  });
}


