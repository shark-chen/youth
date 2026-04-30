import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: doing_together_confirm_widget
///
/// @Description 一起做确认卡片（纯 UI，无弹框逻辑）
class DoingTogetherConfirmWidget extends BaseStatelessWidget {
  const DoingTogetherConfirmWidget({
    super.key,
    required this.content,
    this.onCancel,
    this.onContinue,
    this.cancelText = '取消',
    this.continueText = '继续',
    this.iconPath = 'assets/image/common/look_someone@3x.png',
  });

  /// 中间文案（由外部拼好）
  final String content;

  /// 取消点击
  final VoidCallback? onCancel;

  /// 继续点击
  final VoidCallback? onContinue;

  final String cancelText;
  final String continueText;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 32),
      decoration: BoxDecoration(
        color: ThemeColor.doingListCellBgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 14),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColor.whiteColor.withOpacity(0.75),
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  title: cancelText,
                  backgroundColor: ThemeColor.whiteColor.withOpacity(0.2),
                  textColor: ThemeColor.whiteColor,
                  onTap: () {
                    onCancel?.call();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  title: continueText,
                  backgroundColor: ThemeColor.themeGreenColor,
                  textColor: ThemeColor.themeColor,
                  onTap: () {
                    onContinue?.call();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
