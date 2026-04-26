import 'package:youth/base/base_page.dart';
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
    this.province,
    this.gender,
    this.showEdit,
    this.editTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 用户名称
  final String? userName;

  /// 年纪（如 `32岁`）
  final String? age;

  /// 地区等副文案
  final String? address;

  /// 地区等副文案
  final String? province;

  /// 1 男 · 2 女（与资料接口一致）
  final int? gender;

  /// 展示编辑
  final bool? showEdit;

  /// 编辑点击
  final VoidCallback? editTap;

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

                  /// 性别图标
                  Icon(
                    1 == gender ? Icons.male : Icons.female,
                    color: Colors.blue,
                  ),
                ],
              ),
              Text(
                (age ?? '') +'·'+ (address ?? '') + '   IP:${province ?? ''}',
                style: TextStyles(
                  color: ThemeColor.whiteColor.withOpacity(0.6),
                ),
              ),
            ],
          ),

          Expanded(child: Container()),

          /// 编辑按钮
          Visibility(
            visible: true == showEdit,
            child: GestureDetector(
              onTap: editTap,
              child: Container(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                decoration: BoxDecoration(
                  color: ThemeColor.themeGreenColor.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: ThemeColor.themeGreenColor,
                      size: 12,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '编辑',
                      style: TextStyles(
                        color: ThemeColor.themeGreenColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
