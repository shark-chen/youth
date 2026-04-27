import 'package:kellychat/base/base_bindings.dart';
import 'package:flutter/material.dart';

/// FileName bar_button
///
/// @Author 谌文
/// @Date 2024/11/15 14:01
///
/// @Description 导航头顶部的右侧的按钮
class BarButton extends StatelessWidget {
  const BarButton({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: SizedBox(
        width: 120,
        child: Text(
          title ?? '',
          maxLines: 1,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: ThemeColor.darkBlueColor,
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
      ),
    );
  }
}
