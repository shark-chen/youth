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
      child: Row(
        children: [
          /// 头像
          ImageLookWidget(
            imgUrl: headPortraitUrl ?? '',
          ),

          /// 用户名称，性别，年龄 地址
          Column(
            children: [
              Row(
                children: [
                  Text(
                    userName ?? '',
                    style: TextStyles(color: ThemeColor.whiteColor),
                  ),
                  Icon(Icons.generating_tokens),
                ],
              ),
              Text(
                (age ?? '') + (address ?? ''),
                style: TextStyles(color: ThemeColor.whiteColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
