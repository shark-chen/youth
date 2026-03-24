import 'package:youth/base/base_stateless_widget.dart';

/// FileName mine_cell
///
/// @Author 谌文
/// @Date 2025/2/19 10:52
///
/// @Description 我的页面cell
class MineCell extends BaseStatelessWidget {
  const MineCell({
    Key? key,
    this.title,
    this.content,
    this.middleContent,
    this.middleContentStyle,
    this.showArrow,
    this.showRed,
    this.onTap,
    this.notVisible = false,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  /// 中间内容
  final String? middleContent;

  /// 中间内容样式
  final TextStyle? middleContentStyle;

  /// 展示箭头
  final bool? showArrow;

  /// 展示小红点
  final bool? showRed;

  /// 点击事件
  final VoidCallback? onTap;

  /// 整个cell是是否展示
  final bool? notVisible;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Visibility(
        visible: notVisible == false || notVisible == null,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 16, right: 16),
          color: Colors.white,
          height: 48,
          child: Strings.isNotEmpty(middleContent)
              ? buildLoginOutItem()
              : buildGeneralItem(),
        ),
      ),
    );
  }

  /// 构建通用item
  Widget buildGeneralItem() {
    return Row(
      children: [
        /// 标题
        Text(
          title ?? '',
          style: TextStyles(),
        ),
        Expanded(child: Container()),

        /// 内容
        Visibility(
          visible: Strings.isNotEmpty(content),
          child: Text(
            content ?? '',
            style: TextStyles(),
          ),
        ),

        /// 红点
        Visibility(
          visible: showRed == true,
          child: Column(
            children: [
              const SizedBox(height: 14),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),

        Visibility(
          visible: showArrow == true,
          child: Image.asset('assets/image/common/arrows72@3x.png',
              width: 20, height: 20, color: ThemeColor.secondaryTextColor),
        ),
      ],
    );
  }

  /// 退登
  Widget buildLoginOutItem() {
    return Text(
      textAlign: TextAlign.center,
      middleContent ?? '',
      style: middleContentStyle ?? TextStyles(color: ThemeColor.appleRedColor),
    );
  }
}
