import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:youth/utils/utils/theme_color.dart';

/// 非公开内容：AI 说明区 + 密码行
class EditPrivateSection extends StatelessWidget {
  const EditPrivateSection({
    super.key,
    required this.onAiTap,
    required this.onChangePasswordTap,
    this.passwordHint = '已设置过密码',
    this.passwordBtnTitle = '修改密码',
  });

  final VoidCallback onAiTap;
  final VoidCallback onChangePasswordTap;
  final String passwordHint;
  final String passwordBtnTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: CustomPaint(
                  painter: _DashedLinePainter(
                    color: ThemeColor.whiteColor.withOpacity(0.2),
                  ),
                  child: const SizedBox(height: 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '非公开内容',
                  style: TextStyle(
                    color: ThemeColor.secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: _DashedLinePainter(
                    color: ThemeColor.whiteColor.withOpacity(0.2),
                  ),
                  child: const SizedBox(height: 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '告诉 AI 更多信息',
          style: TextStyle(
            color: ThemeColor.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '以下内容仅用于 AI 更好地理解你，不会在资料卡向他人展示。',
          style: TextStyle(
            color: ThemeColor.secondaryTextColor,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    color: ThemeColor.doingListCellBgColor,
                    child: Container(
                      color: ThemeColor.themeColor.withOpacity(0.55),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onAiTap,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: ThemeColor.themeColor.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: ThemeColor.whiteColor.withOpacity(0.12),
                        ),
                      ),
                      child: Text(
                        '+ 说两句',
                        style: TextStyle(
                          color: ThemeColor.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: ThemeColor.doingListCellBgColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onChangePasswordTap,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      passwordHint,
                      style: TextStyle(
                        color: ThemeColor.whiteColor.withOpacity(0.85),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    passwordBtnTitle,
                    style: TextStyle(
                      color: ThemeColor.themeGreenColor,
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: ThemeColor.themeGreenColor.withOpacity(0.8),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dash = 4.0;
    const gap = 3.0;
    double x = 0;
    final y = size.height / 2;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + dash, y), paint);
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
