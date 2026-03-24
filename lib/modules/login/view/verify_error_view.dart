import 'package:flutter/material.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName verify_error_view
///
/// @Author 谌文
/// @Date 2024/4/26 10:32
///
/// @Description 验证报错提示语
class VerifyErrorWidget extends StatelessWidget {
  const VerifyErrorWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  /// 标题
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          title ?? '',
          style:
              const TextStyle(color: ThemeColor.brightRedColor, fontSize: 12),
        ),
      ),
    );
  }
}
