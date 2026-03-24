import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';

/// FileName gesture_long_copy_view
///
/// @Author 谌文
/// @Date 2024/10/17 15:49
///
/// @Description 长按手机复制view
class GestureLongCopyWidget extends StatelessWidget {
  const GestureLongCopyWidget({
    Key? key,
    this.text,
    this.child,
    this.available = true,
  }) : super(key: key);

  /// 复制文本
  final String? text;

  /// 是否可复制  默认是可以的
  final bool? available;

  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          if (available == false) return;
          Clipboard.setData(ClipboardData(text: text ?? ''));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${text ?? ''}：' + LocaleKeys.copied.tr)),
          );
        },
        child: child);
  }
}
