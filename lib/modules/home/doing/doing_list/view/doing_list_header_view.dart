import 'package:youth/base/base_stateless_widget.dart';

/// FileName: doing_list_header_view
///
/// @Author 谌文
/// @Date 2026/3/9 23:31
///
/// @Description 正在做的清单-渐变头（活动 + 邀请好友）
class DoingListHeaderWidget extends BaseStatelessWidget {
  const DoingListHeaderWidget({
    Key? key,
    this.title,
    this.leadingEmoji = '🎬',
    this.inviteTap,
  }) : super(key: key);

  final String? title;

  /// 左侧图标（设计稿为场记板，可用 emoji）
  final String leadingEmoji;

  final VoidCallback? inviteTap;

  static const Color _mint = Color(0xFFB8F5D0);

  @override
  Widget build(BuildContext context) {
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
          Text(leadingEmoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
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
                    color: Colors.white,
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
