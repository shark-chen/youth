import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: edit_nickname_widget.dart
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description 编辑昵称底部弹层（设计稿：圆顶、胶囊输入、绿色确定；随键盘上移避免遮挡）
class EditNickNameSheetWidget extends BaseStatelessWidget {
  const EditNickNameSheetWidget({
    Key? key,
    this.title,
    this.nickname,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.closeTap,
    this.sureTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 昵称
  final String? nickname;

  /// 最大可输入长度
  final int? maxLength;

  /// 输入框控制
  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// 关闭按钮点击
  final VoidCallback? closeTap;

  /// 确定按钮点击
  final VoidCallback? sureTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox.shrink()),
        AnimatedPadding(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(bottom: bottomInset > 500? 500: bottomInset),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: Get.width,
            decoration: const BoxDecoration(
              color: ThemeColor.themeColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '--',
                        style: TextStyle(
                          color: ThemeColor.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
                const SizedBox(height: 24),
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLength: maxLength,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 16,
                  ),
                  cursorColor: ThemeColor.themeGreenColor,
                  scrollPadding: const EdgeInsets.only(bottom: 120),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColor.doingListCellBgColor,
                    hintText: '请输入昵称...',
                    hintStyle: TextStyle(
                      color: ThemeColor.secondaryTextColor,
                      fontSize: 16,
                    ),
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: ThemeColor.themeGreenColor.withOpacity(0.65),
                        width: 1,
                      ),
                    ),
                  ),
                  onSubmitted: (_) => sureTap?.call(),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: sureTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColor.themeGreenColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: ThemeColor.themeColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
