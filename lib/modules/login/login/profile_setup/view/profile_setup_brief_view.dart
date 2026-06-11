import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/edit_profile_draft.dart';

/// FileName: profile_setup_brief_view
///
/// @Author 谌文
/// @Date 2026/6/11 23:09
///
/// @Description 个人简介（字数限制见 [EditProfileDraft.maxSignatureLength]）
class ProfileSetupBriefWidget extends BaseStatelessWidget {
  const ProfileSetupBriefWidget({
    super.key,
    this.controller,
    required this.maxLength,
  });

  /// controller
  final TextEditingController? controller;

  /// 最大字符长度
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '个人简介（可选填）',
          style: TextStyle(
            color: ThemeColor.whiteColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: ThemeColor.inputBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLines: 100,
            minLines: 5,
            maxLength: maxLength,
            style: TextStyle(
              color: ThemeColor.whiteColor,
              fontSize: 15,
              height: 1.4,
            ),
            cursorColor: ThemeColor.themeGreenColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(14, 12, 14, 36),
              hintText: '介绍一下自己吧，例如爱好、学习、工作…',
              hintStyle: TextStyle(
                color: ThemeColor.secondaryTextColor,
                fontSize: 15,
              ),
            ),
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    '$currentLength/${maxLength ?? EditProfileDraft.maxSignatureLength}',
                    style: TextStyle(
                      color: ThemeColor.secondaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
