import 'package:youth/base/base_stateless_widget.dart';

/// 重置私密密码确认（居中弹框）
///
/// 文案：重置密码将清空全部私密信息；取消 / 确定重置
class EditResetPrivatePasswordConfirmDialog extends BaseStatelessWidget {
  const EditResetPrivatePasswordConfirmDialog({
    super.key,
    this.onCancel,
    this.onConfirm,
  });

  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  static const Color _dialogBg = Color(0xFF1C1C1E);
  static const Color _cancelBg = Color(0xFF3A3A3C);
  static const Color _confirmBg = Color(0xFFEB345A);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            decoration: BoxDecoration(
              color: _dialogBg,
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '提示',
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  '重置密码将清空你输入的全部私密信息。确定重置吗？',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColor.whiteColor.withOpacity(0.92),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _PillButton(
                        label: '取消',
                        backgroundColor: _cancelBg,
                        textColor: ThemeColor.whiteColor,
                        onTap: onCancel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PillButton(
                        label: '确定重置',
                        backgroundColor: _confirmBg,
                        textColor: ThemeColor.whiteColor,
                        onTap: onConfirm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          height: 46,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
