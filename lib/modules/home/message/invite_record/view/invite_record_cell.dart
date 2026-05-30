import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: invite_record_cell
///
/// @Author 谌文
/// @Date 2026/3/12 23:26
///
/// @Description 邀约记录-cell
class InviteRecordCell extends BaseStatelessWidget {
  const InviteRecordCell({
    Key? key,
    this.headPortraitUrl,
    this.heroTag,
    this.name,
    this.inviteMatter,
    this.tagName,
    this.inviteStatusStr,
    this.time,
    this.userInfoTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// heroTag
  final String? heroTag;

  /// 用户名
  final String? name;

  /// 邀约事件
  final String? inviteMatter;

  /// 事项
  final String? tagName;

  /// 邀约状态
  final String? inviteStatusStr;

  /// 时间
  final String? time;

  /// 点击用户信息
  final VoidCallback? userInfoTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userInfoTap,
      child: Container(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        color: ThemeColor.inputBgColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 头像
            ImageLookWidget(
              imgUrl: headPortraitUrl ?? '',
              width: 42,
              height: 42,
              imgBorderRadius: BorderRadius.circular(24),
              heroTag: heroTag,
            ),
            const SizedBox(width: 6),

            /// 昵称 + 时间 + 状态等信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 昵称 + 时间
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles(
                            color: ThemeColor.whiteColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        ' ${time ?? ''}',
                        maxLines: 1,
                        style: TextStyles(
                          fontSize: 12,
                          color: ThemeColor.whiteColor.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  /// 邀请一起做的事情
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: _buildInviteMatterTextSpan(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),

            /// 邀约状态
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                inviteStatusStr ?? '',
                style: TextStyles(
                  color: ThemeColor.white4Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 邀约文案：`[tagName]` 整段（含方括号）使用主题绿色
  TextSpan _buildInviteMatterTextSpan() {
    final text = inviteMatter ?? '';
    final baseStyle = TextStyles(
      fontSize: 12,
      color: ThemeColor.white6Color,
      fontWeight: FontWeight.normal,
    );
    final tagStyle = TextStyles(
      fontSize: 12,
      color: ThemeColor.themeGreenColor,
      fontWeight: FontWeight.normal,
    );

    if (text.isEmpty) {
      return TextSpan(text: '', style: baseStyle);
    }
    final tag = tagName?.trim();
    if (tag != null && tag.isNotEmpty) {
      final bracketed = '「$tag」';
      final index = text.indexOf(bracketed);
      if (index >= 0) {
        return TextSpan(
          children: [
            if (index > 0)
              TextSpan(text: text.substring(0, index), style: baseStyle),
            TextSpan(text: bracketed, style: tagStyle),
            if (index + bracketed.length < text.length)
              TextSpan(
                text: text.substring(index + bracketed.length),
                style: baseStyle,
              ),
          ],
        );
      }
    }

    final pattern = RegExp(r'\[[^\]]*\]');
    final spans = <TextSpan>[];
    var start = 0;
    for (final match in pattern.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(text: match.group(0), style: tagStyle));
      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: baseStyle));
    }
    return TextSpan(
      children:
          spans.isEmpty ? [TextSpan(text: text, style: baseStyle)] : spans,
    );
  }
}
