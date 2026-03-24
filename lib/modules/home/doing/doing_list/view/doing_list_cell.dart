import 'package:youth/base/base_stateless_widget.dart';

/// FileName: doing_list_cell
///
/// @Author 谌文
/// @Date 2026/3/9 23:41
///
/// @Description 正在做的清单-cell
class DoingListCell extends BaseStatelessWidget {
  const DoingListCell({
    Key? key,
    this.headerIcon,
    this.name,
    this.sex,
    this.address,
    this.age,
    this.signature,
  }) : super(key: key);

  /// 头像
  final String? headerIcon;

  /// 名称
  final String? name;

  /// 性别
  final bool? sex;

  /// 年龄
  final String? age;

  /// 地址
  final String? address;

  /// 个人签名
  final String? signature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      margin: EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.blueColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          /// 头像
          ImageLookWidget(
            imgUrl: headerIcon ?? '',
            width: 60,
            height: 60,
          ),

          
        ],
      ),
    );
  }
}
