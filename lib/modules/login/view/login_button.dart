import 'package:flutter/material.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName login_button
///
/// @Author 谌文
/// @Date 2024/4/26 10:03
///
/// @Description 登录注册按钮
class LoginButton extends StatelessWidget {
  const LoginButton({
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
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => ThemeColor.blueColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title ?? '',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ),
    );
  }
}
