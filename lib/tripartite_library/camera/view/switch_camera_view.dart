import 'package:flutter/material.dart';
import '../../../utils/utils/click_utils.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName switch_camera_view
///
/// @Author 谌文
/// @Date 2023/12/5 18:41
///
/// @Description 切换相机View
class SwitchCameraWidget extends StatelessWidget {
  const SwitchCameraWidget({
    Key? key,
    this.switchTap,
  }) : super(key: key);

  /// 点击切换摄像头
  final VoidCallback? switchTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 35),
        child: Row(
          children: [
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: ClickUtils.debounce(switchTap),
              icon: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: ThemeColor.greyColor),
                padding: const EdgeInsets.all(9),
                child: const ImageIcon(
                  AssetImage("assets/image/icons/rotate@2x.png"),
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
