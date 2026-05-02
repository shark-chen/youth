import 'dart:ui';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/widget/button/icon_button/icon_button.dart';

/// 非公开内容：AI 说明区 + 密码行
class EditPrivateSection extends BaseStatelessWidget {
  const EditPrivateSection({
    super.key,
    this.hasPassword,
    required this.onAiTap,
    required this.onChangePasswordTap,
  });

  /// 有密码
  final bool? hasPassword;

  /// 点击添加私密
  final VoidCallback onAiTap;

  /// 修改密码点击
  final VoidCallback onChangePasswordTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CustomPaint(
            painter: _DashedLinePainter(
              color: ThemeColor.whiteColor.withOpacity(0.2),
            ),
            child: const SizedBox(height: 1),
          ),
        ),
        const SizedBox(height: 22),
        Center(
          child: Text(
            '非公开内容',
            style: TextStyle(
              color: ThemeColor.whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '告诉 AI 更多信息',
          style: TextStyle(
            color: ThemeColor.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '在这里告诉 AI 的事情，AI 会为你绝对保密，打死都不会告诉任何人。你可以把你的小癖好、小众爱好、找人的需求写到这里，AI 将根据实际情况应用这些信息，但不会直接向他人展示。',
          style: TextStyle(
            color: ThemeColor.white6Color,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 22),
        Visibility(
          visible: true == hasPassword,
          child: ButtonIcon(
            onTap: onChangePasswordTap,
            alignment: LayoutPattern.rightLeft,
            title: '修改密码',
            style: TextStyles(
              color: ThemeColor.whiteColor,
              fontWeight: FontWeight.w500,
            ),
            icon: Icon(
              Icons.arrow_forward_ios,
              color: ThemeColor.whiteColor,
              size: 16,
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
