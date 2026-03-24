import 'package:youth/base/base_page.dart';
import 'package:youth/base/base_stateless_widget.dart';

/// FileName: doing_list_header_view
///
/// @Author 谌文
/// @Date 2026/3/9 23:31
///
/// @Description 正在做的清单-头部view
class DoingListHeaderWidget extends BaseStatelessWidget {
  const DoingListHeaderWidget({
    Key? key,
    this.title,
    this.inviteTap,
    this.closeTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 邀请好友点击
  final VoidCallback? inviteTap;

  /// 关闭点击
  final VoidCallback? closeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.blueColor, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset("assets/image/icons/close@3x.png", height: 28, width: 28),
          Text(
            title ?? '',
            style: TextStyles(color: ThemeColor.whiteColor),
          ),

          Expanded(child: Container()),

          /// 邀请好友
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColor.whiteColor, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ButtonIcon(
              title: '邀请好友',
              style: TextStyles(color: ThemeColor.whiteColor),
              path: "assets/image/icons/close@3x.png",
            ),
          )
        ],
      ),
    );
  }
}
