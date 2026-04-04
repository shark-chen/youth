import 'package:youth/base/base_stateless_widget.dart';

/// FileName: user_header_info_view
///
/// @Author 谌文
/// @Date 2026/3/16 23:05
///
/// @Description 用户信息头像信息- view
class UserHeaderInfoWidget extends BaseStatelessWidget {
  const UserHeaderInfoWidget({
    Key? key,
    this.headPortraitUrl,
    this.userName,
    this.age,
    this.address,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 用户名称
  final String? userName;

  /// 年纪
  final String? age;

  /// 地址
  final String? address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          /// 头像
          ImageLookWidget(
            height: 64,
            width: 64,
            imgUrl: headPortraitUrl ?? '',
            imgBorderRadius: BorderRadius.circular(32),
          ),
          SizedBox(width: 12),

          /// 用户名称，性别，年龄 地址
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName ?? '',
                    style: TextStyles(
                      color: ThemeColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.generating_tokens),
                ],
              ),
              Text(
                (age ?? '') + (address ?? ''),
                style: TextStyles(
                  color: ThemeColor.whiteColor.withOpacity(0.6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
