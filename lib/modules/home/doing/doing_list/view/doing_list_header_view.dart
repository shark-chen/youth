import 'package:kellychat/base/base_stateless_widget.dart';

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
          Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ThemeColor.blackColor,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: closeTap,
            child: Image.asset(
              'assets/image/common/circle_close@3x.png',
              width: 24,
              height: 24,
            ),
          ),
          Expanded(child: Container()),
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
