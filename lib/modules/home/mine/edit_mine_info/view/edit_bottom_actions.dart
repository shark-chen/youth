import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

/// 底部取消 / 保存
class EditBottomActions extends StatelessWidget {
  const EditBottomActions({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.saveEnable = false,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool saveEnable;

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
                  onPressed: onCancel,
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
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: saveEnable
                        ? ThemeColor.themeGreenColor
                        : ThemeColor.themeGreenColor.withOpacity(0.4),
                    foregroundColor: ThemeColor.themeColor,
                  ),
                  child: Text(
                    '保存',
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
