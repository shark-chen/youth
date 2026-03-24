import 'package:youth/base/base_stateless_widget.dart';
import 'package:youth/modules/home/common/model/associate_entity.dart';

/// FileName search_associate_view
///
/// @Author 谌文
/// @Date 2025/7/11 09:59
///
/// @Description 联想搜索view
class SearchAssociateWidget extends BaseStatelessWidget {
  const SearchAssociateWidget({
    Key? key,
    this.searchList,
    this.reverse = false,
    this.onTap,
  }) : super(key: key);

  /// 搜索内容
  final List<AssociateEntity>? searchList;

  /// 点击回调
  final Function(int, AssociateEntity?)? onTap;

  /// 是否旋转
  final bool? reverse;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: ThemeColor.shadowGrayColor,
              blurRadius: 3)
        ],
      ),
      child: MediaQuery.removePadding(
        context: context,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 42 * 4.5),
          child: ListView.separated(
            reverse: reverse ?? false,
            shrinkWrap: true,
            itemCount: searchList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => SearchAssociateCell(
                content: searchList?[index],
                onTap: () => onTap?.call(index, searchList?[index])),
            separatorBuilder: (BuildContext context, int index) => Container(
                height: 1,
                color: ThemeColor.lineColor,
                margin: const EdgeInsets.only(left: 12)),
          ),
        ),
      ),
    );
  }
}

/// 搜索联想cell
class SearchAssociateCell extends StatelessWidget {
  const SearchAssociateCell({
    Key? key,
    this.content,
    this.onTap,
  }) : super(key: key);

  /// 搜索内容
  final AssociateEntity? content;

  /// 点击tap
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Visibility(
                  visible: Strings.isNotEmpty(content?.typeStr),
                  child: Container(
                    height: 24,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: content?.color,
                      border: Border.all(
                          color: content?.broderColor ?? ThemeColor.lineColor,
                          width: 1),
                    ),
                    child: Text(
                      content?.typeStr ?? '',
                      style: TextStyles(color: content?.textColor),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: content?.front ?? '',
                          style: const TextStyle(
                              color: ThemeColor.mainTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: content?.center ?? '',
                          style: const TextStyle(
                              color: ThemeColor.blueBtnColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: content?.back ?? '',
                          style: const TextStyle(
                              color: ThemeColor.mainTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /// 二级子内容
            Visibility(
              visible: Strings.isNotEmpty(content?.subTitle),
              child: Row(
                children: [
                  Flexible(
                    child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: content?.subTitle ?? '',
                            style: const TextStyle(
                                color: ThemeColor.secondTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
