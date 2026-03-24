import 'package:flutter/cupertino.dart';
import 'package:youth/base/base_page.dart';
import 'user_info_controller.dart';
import 'view/picture_wall_view.dart';
import 'view/user_header_info_view.dart';
import 'view/user_introduce_view.dart';
import 'view/user_label_info_view.dart';

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
      appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// 头像，姓名，性别，年龄，地址信息
                  UserHeaderInfoWidget(
                    headPortraitUrl: '',
                    userName: '哈哈哈',
                    age: '32岁',
                    address: '上海',
                  ),

                  SizedBox(height: 12),

                  /// 进行中的标签
                  UserLabelInfoWidget(
                    labels: [
                      '户外运动',
                      '周末变身奶爸',
                      '积极向上充满热情满怀希望',
                      '这是一个特别长的标签，一行必须展示完xxxxxx',
                    ],
                  ),
                  SizedBox(height: 12),

                  /// 个人标签
                  UserIntroduceWidget(
                    title: '个人标签',
                    content:
                        '个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域个人签名区域',
                  ),
                  SizedBox(height: 12),

                  /// 个人标签
                  UserIntroduceWidget(
                    title: '个人简介',
                    content:
                        '个人公开介绍内容展示区域个人公开介绍内容展示区域个人公开介绍内容展示区域个人公开介绍内容展示区域个人公开介绍内容展示区域个人公开介绍内容展示区域个人公开介绍内容展示区域',
                  ),

                  /// 图片墙- view
                  PictureWallWidget(
                    title: '照片墙',
                    pictures: ['', '', '', '', ''],
                  ),
                  SizedBox(height: 300),
                ],
              ),
            ),
          ),

          BottomButton(
            rightTitle: '聊一聊',
            leftTitle: '一起做',
          ),
        ],
      ),
    );
  }
}
