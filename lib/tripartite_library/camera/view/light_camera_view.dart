import 'package:flutter/material.dart';

/// FileName light_camera_view
///
/// @Author 谌文
/// @Date 2023/12/5 18:48
///
/// @Description 闪光灯开关
class LightCameraWidget extends StatelessWidget {
  const LightCameraWidget({
    Key? key,
    this.open = false,
    this.onTap,
  }) : super(key: key);

  /// 点击事件
  final VoidCallback? onTap;

  /// 打开还是关闭
  final bool? open;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(
              open ?? false
                  ? Icons.flashlight_on_rounded
                  : Icons.flashlight_off_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
