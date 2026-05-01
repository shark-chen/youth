import 'dart:math';
import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: msg_clout_view
///
/// @Author 谌文
/// @Date 2026/3/12 00:00
///
/// @Description 消息-敲一下-view
class MsgCloutWidget extends BaseStatelessWidget {
  const MsgCloutWidget({
    Key? key,
    this.headPortraitUrl,
    this.name,
    this.interactionDesc,
    this.time,
    this.cloutNum,
    this.onTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 名称
  final String? name;

  /// 互动描述，如：我敲了她、他敲了我
  final String? interactionDesc;

  /// 时间
  final String? time;

  /// 敲一下数量
  final String? cloutNum;

  /// 点击
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 12, top: 12),
        padding: EdgeInsets.only(bottom: 12),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 4, left: 8),
              padding:
                  EdgeInsets.only(top: 40, bottom: 12, right: 12, left: 12),
              decoration: BoxDecoration(
                color: ThemeColor.inputBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 头像
                      Row(
                        children: [
                          ImageLookWidget(
                            imgUrl: headPortraitUrl ?? '',
                            height: 42,
                            width: 42,
                            imgBorderRadius: BorderRadius.circular(26),
                          ),

                          SizedBox(width: 12),

                          /// 小雨+ 时间
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: name ?? '',
                                      style: TextStyle(
                                        color: ThemeColor.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' (${interactionDesc ?? ''})',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ThemeColor.whiteColor
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                time ?? '',
                                style: TextStyles(
                                  color: ThemeColor.whiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          /// 数量
                          Container(
                            padding: EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 2,
                              bottom: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  ThemeColor.themeGreenColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              cloutNum ?? '',
                              style: TextStyles(
                                  color: ThemeColor.themeGreenColor,
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 4),
                          Transform.rotate(
                            angle: 3.14159,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                              color: ThemeColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// 一起做邀约
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 2,
                    bottom: 2,
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFBA63FF),
                        Color(0xFFD7A7FF),
                      ],
                    ),
                  ),
                  child: Text(
                    '敲一下',
                    style: TextStyles(
                      fontWeight: FontWeight.w600,
                      color: ThemeColor.themeColor,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: -20 * pi / 180, // ⭐ 向左旋转30度（负数）
                  child: Image.asset(
                    'assets/image/common/look_someone@3x.png',
                    width: 34,
                    height: 32,
                    color: ThemeColor.themeGreenColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
