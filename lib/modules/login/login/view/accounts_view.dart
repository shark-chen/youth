import 'package:flutter/material.dart';
import '../../../../utils/extension/lists/lists.dart';
import '../../../../utils/marco/marco.dart';
import '../../../../utils/utils/theme_color.dart';
import '../../../../widget/base_list_item/base_list_item.dart';
import '../../../../widget/bubble/model/bubble_model.dart';

/// FileName accounts_view
///
/// @Author 谌文
/// @Date 2024/7/10 18:52
///
/// @Description 多账户登录
class AccountsWidget extends StatelessWidget {
  const AccountsWidget({
    Key? key,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.accounts,
    this.maxLine = 3,
    this.onTap,
  }) : super(key: key);

  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? left;

  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? top;

  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? right;

  /// 数据源
  final List<BubbleModel>? accounts;

  /// 点击回调
  final ValueChanged<int>? onTap;

  /// 最大显示行数
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Lists.isNotEmpty(accounts),
      child: Positioned(
        top: top,
        left: left,
        right: right,
        child: Container(
          height: ((accounts?.length ?? 0) > (maxLine ?? 3)
                  ? (maxLine ?? 3)
                  : (accounts?.length ?? 0)) *
              44,
          width: screenWidth - 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: accounts?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return BaseListItem(
                onTap: () => onTap?.call(index),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 44,
                title: accounts?[index].title ?? '',
                selected: accounts?[index].selected,
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: ThemeColor.mainTextColor),
              );
            },
          ),
        ),
      ),
    );
  }
}
