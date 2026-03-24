import '../model/hall_entity.dart';
import '../model/hall_item_entity.dart';
import 'package:youth/base/base_stateless_widget.dart';

/// FileName hall_cell
///
/// @Author 谌文
/// @Date 2023/9/13 10:30
///
/// @Description 首页cell
class HallCell extends BaseStatelessWidget {
  const HallCell({
    Key? key,
    this.index,
    this.hallEntity,
    this.onTap,
  }) : super(key: key);

  /// 索引
  final int? index;

  /// 数据模型数组
  final HallEntity? hallEntity;

  /// 点击item事件回调
  final ValueChanged<HallItemEntity?>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 标题
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    hallEntity?.title ?? '',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: ThemeColor.mainTextColor),
                  ),
                ),
                const SizedBox(height: 10),

                Wrap(
                  runSpacing: 16,
                  children: List.generate(
                    hallEntity?.items?.length ?? 0,
                    (subIndex) {
                      if (subIndex > (hallEntity?.items?.length ?? 0)) {
                        return Container();
                      }
                      return SizedBox(
                        width: (screenWidth - 24) / 4,
                        child: HallItemCell(
                          index: index,
                          subIndex: subIndex,
                          model: hallEntity?.items?[subIndex],
                          onTap: () =>
                              onTap?.call(hallEntity?.items?[subIndex]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// 首页item
class HallItemCell extends BaseStatelessWidget {
  const HallItemCell({
    Key? key,
    this.model,
    this.onTap,
    this.index,
    this.subIndex,
  }) : super(key: key);

  /// 索引
  final int? index;

  /// 子级索引
  final int? subIndex;

  /// 数据模型
  final HallItemEntity? model;

  /// 点击item时间
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 10),

          /// logo
          Padding(
            padding: Strings.isNotEmpty(model?.markNum)
                ? EdgeInsets.only(left: 15)
                : EdgeInsets.only(top: model?.edgeHeight ?? 0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Padding(
                  padding: Strings.isNotEmpty(model?.markNum)
                      ? EdgeInsets.only(top: 12, right: 15)
                      : EdgeInsets.zero,
                  child: ImageLookWidget(
                    imgUrl: model?.logo ?? '',
                    heroTag: (model?.logo ?? '') +
                        (model?.name ?? '') +
                        '${index}${subIndex}',
                    enlargeLook: false,
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(),
                  ),
                ),

                /// 红色图标
                Visibility(
                  visible: Strings.isNotEmpty(model?.markNum),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColor.brightRedColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.white, // 1像素白色边框
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 20,
                    width: (model?.markNum?.length ?? 0) > 2 ? 34 : 25,
                    child: Text(
                      textAlign: TextAlign.center,
                      model?.markNum ?? '',
                      style: TextStyles(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          /// 标题
          Text(
            model?.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ThemeColor.mainTextColor),
          ),
        ],
      ),
    );
  }
}
