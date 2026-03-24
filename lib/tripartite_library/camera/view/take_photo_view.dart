import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../generated/locales.g.dart';
import '../../../utils/marco/marco.dart';
import '../../../utils/utils/theme_color.dart';
import '../../../widget/button/icon_button/icon_button.dart';
import 'select_image_view.dart';
import '../config/sharpness_config.dart';

/// FileName take_photo_view
///
/// @Author 谌文
/// @Date 2023/12/5 15:47
///
/// @Description 底部拍照View
class TakePhotoWidget extends StatelessWidget {
  const TakePhotoWidget({
    Key? key,
    this.sharpness,
    this.sharpnessTap,
    this.showElect,
    this.cancelTap,
    this.takeTap,
    this.switchTap,
    this.selectTap,
    this.selectImageTap,
  }) : super(key: key);

  /// 清晰度 1 标清 2 高清 3：超清
  final int? sharpness;

  /// 显示选项
  final bool? showElect;

  /// 清晰度开关点击
  final VoidCallback? sharpnessTap;

  /// 点击取消
  final VoidCallback? cancelTap;

  /// 点击拍照
  final VoidCallback? takeTap;

  /// 点击切换摄像头
  final VoidCallback? switchTap;

  /// 选择点击
  final ValueChanged<int>? selectTap;

  /// 点击图片回调
  final VoidCallback? selectImageTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// 清晰度view + 选图按钮
          _sharpnessWidget(),

          /// 拍照+ 旋转相机
          Container(
            height: 120 + bottomPadding,
            color: Colors.black,
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: cancelTap,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    width: 60,
                    height: 48,
                    child: Text(LocaleKeys.Cancel.tr,
                        style: ThemeColor.white18Text),
                  ),
                ),
                IconButton(
                  onPressed: takeTap,
                  icon: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white),
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: switchTap,
                  child: Container(
                    width: 60,
                    height: 48,
                    alignment: Alignment.center,
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: ThemeColor.greyColor,
                      ),
                      child: const ImageIcon(
                          AssetImage("assets/image/icons/rotate@2x.png"),
                          size: 32,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 清晰度view
  Widget _sharpnessWidget() {
    return Container(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// 清晰度选择view
          Visibility(
            visible: showElect == true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 22),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: 128,
                  decoration: BoxDecoration(
                    color: ThemeColor.greyBlackColor.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectButton(
                          LocaleKeys.standardSharpness.tr, sharpness == 1, 1),
                      SizedBox(width: 6),
                      _selectButton(
                          LocaleKeys.highSharpness.tr, sharpness == 2, 2),
                      SizedBox(width: 6),
                      _selectButton(
                          LocaleKeys.superSharpness.tr, sharpness == 3, 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),

          /// 清晰度打开按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: sharpnessTap,
                child: Container(
                  margin: EdgeInsets.only(left: 22),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  height: 44,
                  decoration: BoxDecoration(
                    color: ThemeColor.greyBlackColor.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ButtonIcon(
                    title: sharpnessMap[sharpness]?.title,
                    iconColor: Colors.white,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    path: showElect == true
                        ? "assets/image/common/common_arrows_up@3x.png"
                        : "assets/image/common/common_arrows_down@3x.png",
                  ),
                ),
              ),
              Expanded(child: Container()),

              /// 选择按钮
              SelectImageWidget(onTap: selectImageTap),
              SizedBox(width: 22),
            ],
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  /// 选择按钮
  Widget _selectButton(String title, bool selected, int sharpness) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => selectTap?.call(sharpness),
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        height: 39,
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          alignment: Alignment.center,
          decoration: selected
              ? BoxDecoration(
                  border: Border.all(color: Colors.white60, width: 0.5),
                  borderRadius: BorderRadius.circular(14.0),
                )
              : null,
          height: 28,
          child: Text(
            title,
            style: TextStyle(
                color: selected ? Colors.white : Colors.white54,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
        ),
      ),
    );
  }
}
