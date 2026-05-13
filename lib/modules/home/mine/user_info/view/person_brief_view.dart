import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: person_brief_view
///
/// @Author 谌文
/// @Date 2026/5/11 23:10
///
/// @Description 个人简介- view
class PersonBriefWidget extends BaseStatelessWidget {
  const PersonBriefWidget({
    Key? key,
    this.signature,
  }) : super(key: key);

  /// 个人简介
  final String? signature;

  @override
  Widget build(BuildContext context) {
    if (Strings.isEmpty(signature)) {
      return Text(
        '暂无简介',
        style: TextStyles(
          fontSize: 12,
          color: ThemeColor.whiteColor.withOpacity(0.6),
        ),
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '个人简介',
            style: TextStyles(
              fontWeight: FontWeight.w600,
              color: ThemeColor.whiteColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            signature ?? '',
            style: TextStyles(
              fontSize: 12,
              color: ThemeColor.white6Color,
            ),
          ),
        ],
      ),
    );
  }
}
