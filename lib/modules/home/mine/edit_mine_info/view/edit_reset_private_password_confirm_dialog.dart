import 'package:kellychat/base/base_stateless_widget.dart';

/// 重置私密密码确认（居中弹框）
///
/// 文案：重置密码将清空全部私密信息；取消 / 确定重置
class DialogAlertWidget extends BaseStatelessWidget {
  const DialogAlertWidget({
    super.key,
    this.content,
    this.leftTitle,
    this.leftTitleColor,
    this.leftTitleBgColor,
    this.rightTitle,
    this.rightTitleColor,
    this.rightTitleBgColor,
    this.customContentWidget,
    this.leftTap,
    this.rightTap,
  });

  /// 内容
  final String? content;

  /// 左侧按钮标题
  final String? leftTitle;

  /// 左边侧按钮标题颜色
  final Color? leftTitleColor;

  /// 左边侧按钮背景颜色
  final Color? leftTitleBgColor;

  /// 右侧按钮标题
  final String? rightTitle;

  /// 右侧侧按钮标题颜色
  final Color? rightTitleColor;

  /// 右侧按钮背景颜色
  final Color? rightTitleBgColor;

  /// 自定义内容widget
  final Widget? customContentWidget;

  /// 左边点击事件
  final VoidCallback? leftTap;

  /// 右边点击事件
  final VoidCallback? rightTap;

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
              color: ThemeColor.dialogGraynessBgColor,
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
                customContentWidget ??
                    Text(
                      content ?? '重置密码将清空你输入的全部私密信息。确定重置吗？',
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
                        label: leftTitle ?? '取消',
                        backgroundColor: leftTitleBgColor ??
                            ThemeColor.doingListTogetherBgColor,
                        textColor: leftTitleColor ?? ThemeColor.whiteColor,
                        onTap: leftTap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PillButton(
                        label: rightTitle ?? '确定重置',
                        backgroundColor: rightTitleBgColor ??
                            ThemeColor.dialogRedConfirmBgColor,
                        textColor: rightTitleColor ?? ThemeColor.whiteColor,
                        onTap: rightTap,
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
