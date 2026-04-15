import 'package:youth/base/base_stateless_widget.dart';
import '../../sex_select/model/gender.dart';

/// 性别选择底部弹层内容（与 [showModalBottomSheet] 搭配，`Navigator.pop(context, gender)` 返回值）
///
/// gender: 0 未知 / 1 男 / 2 女
class EditGenderSheetWidget extends BaseStatelessWidget {
  const EditGenderSheetWidget({
    super.key,
    this.selectGender,
    this.closeTap,
    this.selectTap,
  });

  /// 选择的性别- 选择的性别
  final Gender? selectGender;

  /// 关闭按钮点击
  final VoidCallback? closeTap;

  /// 确定按钮点击
  final ValueChanged<Gender>? selectTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: ThemeColor.textBlackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '编辑昵称',
                      style: TextStyle(
                        color: ThemeColor.whiteColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: closeTap,
                    icon: Icon(
                      Icons.close,
                      color: ThemeColor.whiteColor.withOpacity(0.9),
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => selectTap?.call(Gender.boy),
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  height: 44,
                  child: Text(
                    '男',
                    style: TextStyle(
                      color: Gender.boy == selectGender
                          ? ThemeColor.themeGreenColor
                          : ThemeColor.white6Color,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectTap?.call(Gender.girl),
                child: Container(
                  color: Colors.transparent,
                  height: 44,
                  alignment: Alignment.center,
                  child: Text(
                    '女',
                    style: TextStyle(
                      color: Gender.girl == selectGender
                          ? ThemeColor.themeGreenColor
                          : ThemeColor.white6Color,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
