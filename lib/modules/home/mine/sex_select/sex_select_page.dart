import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:youth/base/base_controller.dart';
import 'package:youth/base/base_page.dart';
import 'package:youth/base/base_service.dart';
import 'package:youth/modules/modules.dart';
import 'package:youth/tripartite_library/camera/camera_engine/camera_engine.dart';
import 'package:youth/tripartite_library/camera/cameras.dart';
import 'sex_select_controller.dart';
import 'view_model/sex_select_vm.dart';

/// FileName: sex_select_page
///
/// @Author 谌文
/// @Date 2026/3/25 23:51
///
/// @Description 性别选择-页面-page
class SexSelectPage extends BasePage<SexSelectController> {
  const SexSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      body: SafeArea(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                '选择性别',
                style: TextStyles(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: ThemeColor.whiteColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '完善性别、生日、地区信息后，即可开始使用',
                style: TextStyles(
                  color: ThemeColor.whiteColor.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 60),

              /// 男
              GestureDetector(
                onTap: () => controller.selectSex(Sex.boy),
                child: Container(
                  height: 120,
                  margin: EdgeInsets.only(left: 45, right: 45),
                  decoration: BoxDecoration(
                    color: (Sex.boy == controller.vm.value.sex)
                        ? ThemeColor.poolBlueColor
                        : ThemeColor.inputBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 106,
                        child: Text(
                          '男',
                          style: TextStyles(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: (Sex.boy == controller.vm.value.sex)
                                ? ThemeColor.themeBlackColor
                                : ThemeColor.whiteColor,
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/image/common/select_boy@3x.png",
                        width: 120,
                        height: 106,
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              /// 女
              GestureDetector(
                onTap: () => controller.selectSex(Sex.girl),
                child: Container(
                  height: 120,
                  margin: EdgeInsets.only(left: 45, right: 45),
                  decoration: BoxDecoration(
                    color: (Sex.girl == controller.vm.value.sex)
                        ? ThemeColor.pinkColor
                        : ThemeColor.inputBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10),
                      Image.asset(
                        "assets/image/common/select_girl@3x.png",
                        width: 120,
                        height: 106,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 106,
                        child: Text(
                          '女',
                          style: TextStyles(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: (Sex.girl == controller.vm.value.sex)
                                ? ThemeColor.themeBlackColor
                                : ThemeColor.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: controller.pushBirthdaySelectPage,
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 45, right: 45),
                  decoration: BoxDecoration(
                    color: ThemeColor.themeGreenColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    '继续',
                    style: TextStyles(
                      color: ThemeColor.themeBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
