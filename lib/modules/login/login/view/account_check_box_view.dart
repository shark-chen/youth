import 'package:youth/base/base_stateless_widget.dart';

/// FileName: account_check_box_view
///
/// @Author 谌文
/// @Date 2026/2/25 13:37
///
/// @Description 是否记录账号登录信息？记录后未来30天内可直接切换账号，无需输入账号密码！
class AccountCheckBoxWidget extends BaseStatelessWidget {
  const AccountCheckBoxWidget({
    Key? key,
    this.selected = false,
    this.selectTap,
  }) : super(key: key);

  /// 是否同意
  final bool? selected;

  /// 选择打钩
  final ValueChanged<bool?>? selectTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Container(
            child: Checkbox(
              side: const BorderSide(color: ThemeColor.checkBoxBorderColor),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              onChanged: selectTap,
              value: selected,
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: GestureDetector(
              onTap: () {
                selectTap?.call(!(selected ?? false));
              },
              child: RichText(
                text: TextSpan(
                  text: LocaleKeys.rememberMyLoginStatus.tr,
                  style: const TextStyle(
                      fontSize: 13, color: ThemeColor.otherTextColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
