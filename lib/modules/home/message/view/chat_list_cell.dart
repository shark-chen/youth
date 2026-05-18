import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: chat_list_cell
///
/// @Author 谌文
/// @Date 2026/3/10 23:19
///
/// @Description 消息列表- cell
class ChatListCell extends BaseStatelessWidget {
  const ChatListCell({
    Key? key,
    this.dismissKey,
    this.onTap,
    this.onConfirmDelete,
    this.headPortraitUrl,
    this.name,
    this.msg,
    this.time,
    this.showTopRadius = false,
    this.showBottomRadius = false,
  }) : super(key: key);

  /// 侧滑删除唯一 key（建议 `ValueKey(conversationId)`）
  final Key? dismissKey;

  /// 点击
  final VoidCallback? onTap;

  /// 侧滑确认删除，返回 `true` 时执行删除动画并移除 cell
  final Future<bool> Function()? onConfirmDelete;

  /// 头像
  final String? headPortraitUrl;

  /// 名称
  final String? name;

  /// 消息
  final String? msg;

  /// 时间
  final String? time;

  /// 是否展示上圆角（12）
  final bool showTopRadius;

  /// 是否展示下圆角（12）
  final bool showBottomRadius;

  BorderRadius _cellBorderRadius() {
    const r = Radius.circular(12);
    return BorderRadius.only(
      topLeft: showTopRadius ? r : Radius.zero,
      topRight: showTopRadius ? r : Radius.zero,
      bottomLeft: showBottomRadius ? r : Radius.zero,
      bottomRight: showBottomRadius ? r : Radius.zero,
    );
  }

  double get _actionBackgroundRadius {
    if (showTopRadius && showBottomRadius) return 12;
    if (showTopRadius) return 12;
    if (showBottomRadius) return 12;
    return 0;
  }

  Widget _buildCellContent() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66,
        margin: const EdgeInsets.only(left: 12, right: 12),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ThemeColor.inputBgColor,
          borderRadius: _cellBorderRadius(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageLookWidget(
              height: 42,
              width: 42,
              imgUrl: headPortraitUrl ?? '',
              imgBorderRadius: BorderRadius.circular(21),
              heroTag: '${headPortraitUrl ?? ''}_chat_list_${name}',
              enlargeLook: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles(
                            color: ThemeColor.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time ?? '',
                        style: TextStyles(
                          color: ThemeColor.iconBlackColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    msg ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles(
                      color: ThemeColor.iconBlackColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildCellContent();
    if (onConfirmDelete == null) {
      return content;
    }
    return SwipeActionCell(
      key: dismissKey ?? ValueKey('chat_list_${name}_$time'),
      backgroundColor: ThemeColor.themeColor,
      trailingActions: [
        SwipeAction(
          title: '删除',
          color: ThemeColor.brightRedColor,
          backgroundRadius: _actionBackgroundRadius,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          onTap: (handler) async {
            final ok = await onConfirmDelete!.call();
            await handler(ok);
          },
        ),
      ],
      child: content,
    );
  }
}
