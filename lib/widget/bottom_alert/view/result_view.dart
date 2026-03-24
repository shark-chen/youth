import 'package:youth/base/base_stateless_widget.dart';

/// FileName result_view
///
/// @Author 谌文
/// @Date 2025/2/21 14:16
///
/// @Description 操作结果view
class ResultWidget extends BaseStatelessWidget {
  const ResultWidget({
    Key? key,
    this.showResultLogo,
    this.title,
    this.content,
    this.failReasons,
    this.confirmTap,
  }) : super(key: key);

  /// 是否展示成功失败图标 默认展示
  final bool? showResultLogo;

  /// 失败标题
  final String? title;

  /// 失败内容
  final String? content;

  /// 失败列表
  final List<String>? failReasons;

  /// 点击确定按钮
  final VoidCallback? confirmTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 8),
          width: Get.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/image/icons/error@3x.png",
                  width: 42, height: 42),

              SizedBox(height: 8),

              /// 标题
              Text(
                LocaleKeys.operationFailure.tr,
                style: TextStyles(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),

              /// 内容
              Text(content ?? ''),
              Visibility(
                visible: Strings.isNotEmpty(content),
                child: SizedBox(height: 20),
              ),

              Visibility(
                visible: Lists.isNotEmpty(failReasons),
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: 240, minWidth: screenWidth - 32),
                  padding:
                      EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 3),
                  decoration: BoxDecoration(
                      color: ThemeColor.thinGrayColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Scrollbar(
                    thumbVisibility: true,
                    radius: Radius.circular(8),
                    thickness: 4,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      controller: ScrollController(),
                      child: Text(
                        textAlign: TextAlign.left,
                        failReasons?.map((id) => id.toString()).join("\n") ??
                            '',
                        style: TextStyle(
                            height: 1.7,
                            fontSize: 13,
                            color: ThemeColor.otherTextColor),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              /// 底部确定按钮
              BottomButton(
                leftMargin: 0,
                rightMargin: 0,
                showLine: false,
                leftTitle: LocaleKeys.Confirm.tr,
                leftTitleColor: Colors.white,
                leftTap: confirmTap,
                leftDecoration: BoxDecoration(
                  color: ThemeColor.lineBlueColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
