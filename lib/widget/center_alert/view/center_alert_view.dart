import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: center_alert_view
///
/// @Author 谌文
/// @Date 2026/1/22 18:41
///
/// @Description 中间对话框view
class CenterAlertWidget extends BaseStatelessWidget {
  const CenterAlertWidget({
    Key? key,
    this.title,
    this.content,
    this.leftTitle,
    this.rightTitle,
    this.leftTap,
    this.rightTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  /// 左边按钮
  final String? leftTitle;

  /// 右边按钮
  final String? rightTitle;

  /// 左边按钮点击
  final VoidCallback? leftTap;

  /// 右边按钮点击
  final VoidCallback? rightTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      padding: const EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 标题
                Text(
                  title ?? '',
                  style: TextStyles(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),

                /// 内容
                Container(
                  constraints: const BoxConstraints(maxHeight: 240),
                  child: SingleChildScrollView(
                    child: Text(
                      content ?? '',
                      style: TextStyles(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                /// 取消+授权按钮
                BottomButton(
                  showLine: false,
                  leftTitle: leftTitle ?? LocaleKeys.Cancel.tr,
                  leftTap: leftTap,
                  rightTitle: rightTitle ?? LocaleKeys.Confirm.tr,
                  rightTap: rightTap,
                  height: 72,
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
