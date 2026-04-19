import 'package:flutter/cupertino.dart';
import 'package:youth/base/base_page.dart';
import 'user_info_controller.dart';
import 'view/picture_wall_view.dart';
import 'view/user_header_info_view.dart';
import 'view/user_introduce_view.dart';

/// FileName: user_info_page
///
/// @Author 谌文
/// @Date 2026/3/16 22:50
///
/// @Description 用户信息模块-页面-page
class UserInfoPage extends BasePage<UserInfoController> {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? '',
          elevation: 0.2,
          actions: controller.vm.value.userId != null
              ? [
                  IconButton(
                    onPressed: controller.pushMoreActionsAlert,
                    icon: Icon(
                      Icons.more_horiz,
                      color: ThemeColor.whiteColor,
                    ),
                  )
                ]
              : []),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 用户信息头像信息- view
                    UserHeaderInfoWidget(
                      headPortraitUrl: controller.userInfo?.avatar,
                      userName: controller.userInfo?.nickname,
                      age: controller.userInfo?.ageInfo,
                      address: controller.userInfo?.regionInfo,
                      gender: controller.userInfo?.gender,
                      showEdit: controller.vm.value.userId == null,
                      editTap: controller.pushEditMineInfoPage,
                    ),
                    const SizedBox(height: 24),
                    UserIntroduceWidget(
                      title: '个人标签',
                      content: Lists.isEmpty(controller.userInfo?.tags)
                          ? '暂无标签'
                          : controller.userInfo?.tags?.join('、'),
                    ),
                    const SizedBox(height: 28),

                    /// 用户标签信息- view
                    UserIntroduceWidget(
                      title: '个人简介',
                      content: Strings.isEmpty(controller.userInfo?.signature)
                          ? '暂无简介'
                          : controller.userInfo?.signature,
                    ),
                    const SizedBox(height: 16),

                    /// 照片墙
                    PictureWallWidget(
                      title: '照片墙',
                      pictures: controller.userInfo?.photos,
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.vm.value.userId != null,
              child: BottomButton(
                rightTitle: '聊一聊',
                leftTitle: '一起做',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
