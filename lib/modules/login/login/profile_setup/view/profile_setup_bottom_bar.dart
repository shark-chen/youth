import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

class ProfileSetupBottomBar extends StatelessWidget {
  const ProfileSetupBottomBar({
    super.key,
    required this.step,
    required this.nextEnabled,
    required this.onNext,
    required this.onPrevious,
    required this.onComplete,
  });

  final int step;
  final bool nextEnabled;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    if (step == 0) {
      return _singleButton(
        label: '下一步',
        enabled: nextEnabled,
        onTap: onNext,
      );
    }
    if (step == 1) {
      return _dualButtons(
        leftLabel: '上一个',
        rightLabel: '下一个',
        rightEnabled: nextEnabled,
        onLeft: onPrevious,
        onRight: onNext,
      );
    }
    return _dualButtons(
      leftLabel: '上一个',
      rightLabel: '完成',
      rightEnabled: true,
      onLeft: onPrevious,
      onRight: onComplete,
    );
  }

  Widget _singleButton({
    required String label,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: _primaryButton(label: label, enabled: enabled, onTap: onTap),
      ),
    );
  }

  Widget _dualButtons({
    required String leftLabel,
    required String rightLabel,
    required bool rightEnabled,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: Row(
          children: [
            TextButton(
              onPressed: onLeft,
              child: Text(
                leftLabel,
                style: TextStyle(
                  color: ThemeColor.whiteColor.withOpacity(0.55),
                  fontSize: 15,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 148,
              child: _primaryButton(
                label: rightLabel,
                enabled: rightEnabled,
                onTap: onRight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _primaryButton({
    required String label,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: enabled
              ? ThemeColor.themeGreenColor
              : ThemeColor.themeGreenColor.withOpacity(0.35),
          foregroundColor: ThemeColor.themeBlackColor,
          shape: const StadiumBorder(),
          disabledBackgroundColor:
              ThemeColor.themeGreenColor.withOpacity(0.35),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
