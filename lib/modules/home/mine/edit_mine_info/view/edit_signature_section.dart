import 'package:flutter/material.dart';
import 'package:youth/utils/utils/theme_color.dart';

import '../model/edit_profile_draft.dart';
import 'edit_mine_card.dart';

/// 个人简介（字数限制见 [EditProfileDraft.maxSignatureLength]）
class EditSignatureSection extends StatelessWidget {
  const EditSignatureSection({
    super.key,
    required this.controller,
    required this.maxLength,
  });

  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return EditMineCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '个人简介',
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: ThemeColor.themeColor.withOpacity(0.45),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller,
                maxLines: 4,
                minLines: 3,
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
                  hintText: '介绍一下自己吧',
                  hintStyle: TextStyle(
                    color: ThemeColor.secondaryTextColor,
                    fontSize: 15,
                  ),
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
                      '$currentLength/${maxLength ?? EditProfileDraft.maxSignatureLength}',
                      style: TextStyle(
                        color: ThemeColor.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
