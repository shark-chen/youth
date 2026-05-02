import 'package:kellychat/base/base_vm.dart';
import 'package:flutter/rendering.dart';
import '../view/tabs.dart';
import 'dart:ui' as ui;

/// FileName: home_vm
///
/// @Author 谌文
/// @Date 2026/1/8 19:46
///
/// @Description home的-vm
class HomeVm extends BaseVM {
  /// 当前选择的Tab
  var currentTab = HomeTabs.hall;

  /// 截图key
  final GlobalKey screenshotKey = GlobalKey();

  /// 为了就是 APP内切换语言，语言的值需要刷新
  List<String> get pageTabNames {
    final result = <String>[];
    for (var value in buildHomePages()) {
      result.add(value.name);
    }
    return result;
  }

  List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];

  /// 创建底部tab
  List<BottomNavigationBarItem> get buildBarItems {
    if (barItems.isNotEmpty) return barItems;
    for (var value in buildHomePages()) {
      barItems.add(
        BottomNavigationBarItem(
            activeIcon: Image.asset(
              value.activeLogo,
              width: 32,
              height: 32,
              color: ThemeColor.themeGreenColor,
            ),
            icon: Image.asset(
              value.logo,
              width: 32,
              height: 32,
              color: ThemeColor.theme5FColor,
            ),
            label: value.name),
      );
    }
    return barItems;
  }
}
