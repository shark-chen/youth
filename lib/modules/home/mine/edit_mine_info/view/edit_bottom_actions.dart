import 'package:flutter/material.dart';
import 'package:youth/utils/utils/theme_color.dart';

/// 底部取消 / 保存
class EditBottomActions extends StatelessWidget {
  const EditBottomActions({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.saving = false,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: saving ? null : onCancel,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: ThemeColor.whiteColor.withOpacity(0.2),
                    ),
                    foregroundColor: ThemeColor.whiteColor,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('取消'),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: saving ? null : onSave,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ThemeColor.themeGreenColor,
                    disabledBackgroundColor:
                        ThemeColor.themeGreenColor.withOpacity(0.45),
                    foregroundColor: ThemeColor.themeColor,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    saving ? '保存中…' : '保存',
                    style: TextStyle(
                      color: ThemeColor.themeColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
}
