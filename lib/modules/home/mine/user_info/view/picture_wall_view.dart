import 'package:youth/base/base_stateless_widget.dart';

/// FileName: picture_wall_view
///
/// @Author 谌文
/// @Date 2026/3/16 23:34
///
/// @Description 图片墙- view
class PictureWallWidget extends BaseStatelessWidget {
  const PictureWallWidget({
    Key? key,
    this.title,
    this.pictures,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 图片
  final List<String>? pictures;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: TextStyles(
              color: ThemeColor.whiteColor,
            ),
          ),
          SizedBox(height: 6),
          Wrap(
            runSpacing: 16,
            children: List.generate(
              pictures?.length ?? 0,
              (index) {
                return SizedBox(
                  width: (screenWidth - 24) / 2,
                  child: ImageLookWidget(
                    imgUrl: pictures?[index] ?? '',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
