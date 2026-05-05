import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/material.dart';
import 'package:kellychat/widget/image_look/image_look.dart';

/// FileName: chat_image_view
///
/// @Author 谌文
/// @Date 2026/5/4 23:30
///
/// @Description
class ChatImageWidget extends BubbleNormalImage {
  ChatImageWidget({
    Key? key,
    required super.id,
    required super.image,
    this.showPortrait,
    this.avatar,
    super.bubbleRadius = BUBBLE_RADIUS_IMAGE,
    super.isSender = true,
    super.color = Colors.white70,
    super.tail = true,
    super.sent = false,
    super.delivered = false,
    super.seen = false,
    super.onTap,
  }) : super(key: key);

  /// 是否展示头像
  final bool? showPortrait;

  /// 头像地址
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    final bubble = super.build(context);
    final headerImage = true == showPortrait
        ? ImageLookWidget(
            imgUrl: avatar ?? '',
            height: 40,
            width: 40,
            imgBorderRadius: BorderRadius.circular(20),
          )
        : SizedBox(width: 40, height: 40);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isSender == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: isSender == true
          ? [
              Expanded(child: bubble),
              headerImage,
            ]
          : [headerImage, Expanded(child: bubble)],
    );
  }
}
