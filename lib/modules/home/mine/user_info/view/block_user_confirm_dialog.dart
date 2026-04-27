import 'package:kellychat/base/base_stateless_widget.dart';

/// 拉黑确认（居中弹框，`showDialog` 使用）
///
/// 顶部圆形图标 + 标题「拉黑」+ 说明文案 + 取消 / 拉黑
class BlockUserConfirmDialog extends BaseStatelessWidget {
  const BlockUserConfirmDialog({
    super.key,
    required this.targetName,
    this.onCancel,
    this.onConfirm,
    this.blocked,
  });

  /// 被拉黑对象展示名（昵称等）
  final String targetName;

  /// 是否已拉黑
  final bool? blocked;

  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    final name = targetName.trim().isEmpty ? '对方' : targetName.trim();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            decoration: BoxDecoration(
              color: ThemeColor.dialogGraynessBgColor,
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: ThemeColor.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person_off_rounded,
                    color: ThemeColor.textBlackColor,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  true == blocked ? '取消拉黑' : '拉黑',
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  true == blocked
                      ? '取消拉黑'
                      : '确定将「$name」拉黑吗？拉黑后，对方无法查看你的主页，也无法与你互动。对方不会收到被拉黑的通知。',
                  textAlign: TextAlign.left,
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
                      child: _BlockPillButton(
                        label: '取消',
                        backgroundColor: ThemeColor.doingListTogetherBgColor,
                        textColor: ThemeColor.whiteColor,
                        onTap: onCancel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _BlockPillButton(
                        label: true == blocked ? '取消拉黑' : '拉黑',
                        backgroundColor: ThemeColor.dialogRedBgColor,
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

class _BlockPillButton extends StatelessWidget {
  const _BlockPillButton({
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
