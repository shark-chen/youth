import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/modules/login/view/verify_error_view.dart';

/// FileName: input_location_view
///
/// @Author 谌文
/// @Date 2026/3/26 22:40
///
/// @Description 地区位置选择输入框
class InputLocationWidget extends BaseStatelessWidget {
  const InputLocationWidget({
    Key? key,
    this.hint,
    this.content,
    this.selectTap,
    this.locationTap,
    this.error,
  }) : super(key: key);

  /// 提示语
  final String? hint;

  /// 选择后的真实内容
  final String? content;

  /// 点击选择
  final VoidCallback? selectTap;

  /// 定位选择
  final VoidCallback? locationTap;

  /// 错误
  final String? error;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectTap,
      child: Container(
        alignment: Alignment.center,
        height: 54,
        decoration: BoxDecoration(
          color: ThemeColor.inputBgColor,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.only(left: 18),
        margin: EdgeInsets.only(left: 24, right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.locationDot,
              color: ThemeColor.iconBlackColor,
              size: 20,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                Strings.isNotEmpty(content) ? (content ?? '') : (hint ?? ''),
                style: TextStyles(
                  color: Strings.isNotEmpty(content)
                      ? ThemeColor.whiteColor
                      : ThemeColor.white6Color,
                ),
              ),
            ),
            GestureDetector(
              onTap: locationTap,
              child: FaIcon(
                FontAwesomeIcons.locationCrosshairs,
                color: ThemeColor.themeGreenColor,
                size: 22,
              ),
            ),
            SizedBox(width: 16),
            Visibility(
              visible: Strings.isNotEmpty(error),
              child: VerifyErrorWidget(title: error),
            ),
          ],
        ),
      ),
    );
  }
}
