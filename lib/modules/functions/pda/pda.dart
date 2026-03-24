import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';

/// FileName pda
///
/// @Author 谌文
/// @Date 2024/4/19 17:04
///
/// @Description PDA
class Pda {
  /// 启动PDA扫描
  static void init() {
    if (GetPlatform.isIOS) return;
    Future.delayed(const Duration(), () {
      KeyboardListener(
          focusNode: FocusNode(), autofocus: true, child: Text(''));
      try {
        SystemChannels.textInput.invokeMethod('TextInput.show');
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      } catch (_) {}
    });
  }
}
