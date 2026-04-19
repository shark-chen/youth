import 'package:youth/tripartite_library/tripartite_library.dart';
import 'package:youth/utils/extension/strings/strings.dart';
import 'package:youth/utils/marco/marco.dart';
import '../../../utils/extension/text_styles.dart';

/// FileName icon_button
///
/// @Author 谌文
/// @Date 2023/12/25 10:57
///
/// @Description 图片按钮
/// 图片与文字的排布
enum LayoutPattern {
  leftRight,
  rightLeft,
  topBottom,
  bottomTop,
}

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    this.title,
    this.style,
    this.alignment = LayoutPattern.leftRight,
    this.textAlignment,
    this.path,
    this.iconSize,
    this.iconColor,
    this.space = 2,
    this.onTap,
    this.onTapDown,
    this.textWidth,
    this.mainAxisAlignment,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 字体样式
  final TextStyle? style;

  /// 排版对齐
  final LayoutPattern? alignment;

  /// 文字排版
  final AlignmentGeometry? textAlignment;

  /// 图片资源
  final String? path;

  /// 点击事件
  final VoidCallback? onTap;

  ///  * [kPrimaryButton], the button this callback responds to.
  final GestureTapDownCallback? onTapDown;

  /// 图片大小
  final Size? iconSize;

  /// 间距
  final double? space;

  /// 图片颜色
  final Color? iconColor;

  /// 文字最大宽度
  final double? textWidth;

  /// main axis.
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
      child: alignment == LayoutPattern.leftRight ||
              alignment == LayoutPattern.rightLeft
          ? Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
              children: alignment == LayoutPattern.leftRight
                  ? _buildItem()
                  : _buildItem().reversed.toList(),
            )
          : Column(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
              children: alignment == LayoutPattern.topBottom
                  ? _buildItem()
                  : _buildItem().reversed.toList(),
            ),
    );
  }

  List<Widget> _buildItem() {
    var text = Text(
      maxLines: 1,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      title ?? '',
      style: style ?? TextStyles(fontWeight: FontWeight.w500),
    );
    return [
      Visibility(
        visible: Strings.isNotEmpty(path),
        child: Image.asset(path ?? '',
            width: iconSize?.width ?? 12,
            height: iconSize?.height ?? 12,
            color: iconColor),
      ),
      (alignment == LayoutPattern.leftRight ||
              alignment == LayoutPattern.rightLeft)
          ? SizedBox(width: space ?? 2)
          : SizedBox(height: space ?? 2),
      (textWidth ?? 0) > 0
          ? Container(
              alignment: textAlignment,
              constraints:
                  BoxConstraints(maxWidth: textWidth ?? screenWidth * 0.7),
              child: text)
          : text,
    ];
  }
}
