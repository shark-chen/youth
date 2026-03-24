import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../generated/locales.g.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName select_image_view
///
/// @Author 谌文
/// @Date 2024/9/24 10:55
///
/// @Description 选择image
class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  /// 点击图片回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ThemeColor.greyBlackColor.withOpacity(0.55),
              borderRadius: BorderRadius.circular(23),
            ),
            width: 46,
            height: 46,
            child: Center(
              child: Image.asset("assets/image/hall/select_image@3x.png",
                  width: 20, height: 20),
            ),
          ),
          SizedBox(height: 4),
          Text(
            LocaleKeys.selectPhoto.tr,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
