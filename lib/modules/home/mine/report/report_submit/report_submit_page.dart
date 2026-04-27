import 'dart:io';

import 'package:kellychat/base/base_page.dart';

import 'report_submit_controller.dart';

/// FileName: report_submit_page
///
/// @Author 谌文
/// @Date 2026/4/19
///
/// @Description 举报证据
class ReportSubmitPage extends BasePage<ReportSubmitController> {
  const ReportSubmitPage({Key? key}) : super(key: key);

  static const double _fieldRadius = 14;
  static const double _thumbSize = 72;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        backgroundColor: ThemeColor.themeColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBarKit.appBar(
          controller.title ?? '',
          backgroundColor: ThemeColor.themeColor,
          elevation: 0,
          textColor: ThemeColor.whiteColor,
          backTap: controller.closePage,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.reasonLabel != null &&
                        controller.reasonLabel!.isNotEmpty) ...[
                      Text(
                        '举报类型：${controller.reasonLabel}',
                        style: ThemeColor.white14Text.copyWith(
                          color: ThemeColor.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _sectionLabel('举报描述（选填）'),
                    const SizedBox(height: 8),
                    _contentField(),
                    const SizedBox(height: 20),
                    _sectionLabel('图片证据（选填，最多3张）'),
                    const SizedBox(height: 6),
                    Text(
                      '请上传涉嫌违规的相关图片证据',
                      style: ThemeColor.white14Text.copyWith(
                        color: ThemeColor.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _imageRow(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Obx(
                () => SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.requesting.value
                        ? null
                        : controller.submit,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ThemeColor.themeGreenColor,
                      disabledBackgroundColor:
                          ThemeColor.themeGreenColor.withOpacity(0.5),
                      foregroundColor: ThemeColor.themeColor,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      LocaleKeys.submit.tr,
                      style: TextStyle(
                        color: ThemeColor.themeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: ThemeColor.white14Text.copyWith(fontWeight: FontWeight.w500),
    );
  }

  Widget _contentField() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.doingListCellBgColor,
        borderRadius: BorderRadius.circular(_fieldRadius),
      ),
      child: TextField(
        controller: controller.contentController,
        maxLines: 6,
        minLines: 5,
        maxLength: ReportSubmitController.maxContentLength,
        style: ThemeColor.white16Text,
        cursorColor: ThemeColor.themeGreenColor,
        decoration: InputDecoration(
          isDense: true,
          hintText:
              '请详细描述用户涉及违规的场景或内容，以提升举报成功率',
          hintStyle: ThemeColor.white14Text.copyWith(
            color: ThemeColor.secondaryTextColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 36),
          counterText: '',
        ),
        buildCounter: (
          BuildContext context, {
          required int currentLength,
          required bool isFocused,
          required int? maxLength,
        }) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 10),
            child: Text(
              '$currentLength/${maxLength ?? ReportSubmitController.maxContentLength}',
              style: ThemeColor.white14Text.copyWith(
                color: ThemeColor.secondaryTextColor,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imageRow() {
    return Obx(
      () => Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          ...List.generate(controller.imagePaths.length, (i) {
            final path = controller.imagePaths[i];
            return _ImageThumb(
              path: path,
              onRemove: () => controller.removeImageAt(i),
            );
          }),
          if (controller.canAddImage) _addTile(),
        ],
      ),
    );
  }

  Widget _addTile() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: controller.pickImage,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: _thumbSize,
          height: _thumbSize,
          decoration: BoxDecoration(
            color: ThemeColor.doingListCellBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ThemeColor.whiteColor.withOpacity(0.9),
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                '添加',
                style: ThemeColor.white14Text.copyWith(
                  color: ThemeColor.secondaryTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageThumb extends StatelessWidget {
  const _ImageThumb({
    required this.path,
    required this.onRemove,
  });

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(path),
            width: ReportSubmitPage._thumbSize,
            height: ReportSubmitPage._thumbSize,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: ThemeColor.brightRedColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
