import 'dart:async';
import 'package:flutter/cupertino.dart';

/// FileName click_utils
///
/// @Author 谌文
/// @Date 2023/5/4 20:14
///
/// @Description 点击工具类
class ClickUtils {
  static Timer? time;

  /// 防止重复点击
  static VoidCallback debounce(Function? fn, [int t = 300]) {
    return () {
      /// 还在时间之内，抛弃上一次
      if (time?.isActive ?? false) {
        time?.cancel();
        time = null;
      } else {
        fn?.call();
      }
      time = Timer(Duration(milliseconds: t), () {
        time?.cancel();
        time = null;
      });
    };
  }
}
