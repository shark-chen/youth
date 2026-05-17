import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: doing_list_header_view
///
/// @Author 谌文
/// @Date 2026/3/9 23:31
///
/// @Description 正在做的清单-渐变头（活动 + 邀请好友）

/// 标题最多展示 30 字，超出以 `...` 结尾。
String _formatDoingListHeaderTitle(String? raw) {
  final s = (raw ?? '').trim();
  if (s.isEmpty) return '';
  if (s.length <= 30) return s;
  return '${s.substring(0, 27)}...';
}

/// 字数较多时略缩小字号，便于两行展示。
double _doingListHeaderTitleFontSize(String display) {
  final len = display.length;
  if (len <= 12) return 20;
  if (len <= 20) return 18;
  return 15;
}

class DoingListHeaderWidget extends BaseStatelessWidget {
  const DoingListHeaderWidget({
    Key? key,
    this.title,
    this.closeTap,
    this.inviteTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 关闭点击
  final VoidCallback? closeTap;

  /// 邀请点击
  final VoidCallback? inviteTap;

  static const Color _mint = Color(0xFFB8F5D0);

  @override
  Widget build(BuildContext context) {
    final displayTitle = _formatDoingListHeaderTitle(title);
    final titleStyle = TextStyle(
      fontSize: _doingListHeaderTitleFontSize(displayTitle),
      fontWeight: FontWeight.w600,
      color: ThemeColor.blackColor,
      height: 1.25,
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ThemeColor.themeGreenColor,
            _mint,
          ],
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: closeTap,
            child: Image.asset(
              'assets/image/common/circle_close@3x.png',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              displayTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: inviteTap,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xE6000000),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Text(
                  '邀请好友',
                  style: TextStyle(
                    color: ThemeColor.btnBlueColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
