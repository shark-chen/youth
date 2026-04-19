import 'package:youth/base/base_stateless_widget.dart';

/// 「更多」底部弹层：举报 / 拉黑（布局与 [EditChangePasswordSheetWidget] 外层风格一致）
class MoreActionsSheetWidget extends BaseStatelessWidget {
  const MoreActionsSheetWidget({
    super.key,
    this.title,
    this.blocked,
    this.closeTap,
    this.onReportTap,
    this.onBlockTap,
  });

  /// 标题，默认「更多」
  final String? title;

  /// 标题，默认「更多」
  final bool? blocked;

  final VoidCallback? closeTap;
  final VoidCallback? onReportTap;
  final VoidCallback? onBlockTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox.shrink()),
        AnimatedPadding(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          padding:
              EdgeInsets.only(bottom: bottomInset > 500 ? 500 : bottomInset),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: Get.width,
            decoration: const BoxDecoration(
              color: ThemeColor.textBlackColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '更多',
                        style: TextStyle(
                          color: ThemeColor.whiteColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: closeTap,
                      icon: Icon(
                        Icons.close,
                        color: ThemeColor.whiteColor.withOpacity(0.9),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RoundAction(
                        icon: Icons.warning_amber_rounded,
                        label: '举报',
                        onTap: onReportTap,
                      ),
                      const SizedBox(width: 28),
                      _RoundAction(
                        icon: Icons.person_off_rounded,
                        label: true == blocked ? '已拉黑' : '拉黑',
                        onTap: onBlockTap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ThemeColor.doingListCellBgColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: ThemeColor.whiteColor,
                  size: 26,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: ThemeColor.secondaryTextColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
