import 'package:flutter/material.dart';
import '../../../../utils/utils/theme_color.dart';

/// FileName login_bottom_view
///
/// @Author 谌文
/// @Date 2024/7/10 13:43
///
/// @Description 登录注册地址文案
class LoginBottomWidget extends StatelessWidget {
  const LoginBottomWidget({
    Key? key,
    this.title,
    this.content,
    this.onTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  ///点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(fontSize: 14, color: ThemeColor.mainTextColor),
          children: <TextSpan>[
            TextSpan(
              text: " ${content}",
              style: const TextStyle(fontSize: 14, color: ThemeColor.blueColor),
            ),
          ],
        ),
      ),
    );
  }
}
