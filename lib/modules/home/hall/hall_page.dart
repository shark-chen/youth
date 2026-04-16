import 'package:flutter/cupertino.dart';

import '../../../base/base_page.dart';
import 'hall_controller.dart';
import 'model/card_item.dart';
import 'view/card_stack_view.dart';
import 'view/find_friend_prompt_view.dart';
import 'view/input_ai_view.dart';
import 'view/make_friend_view.dart';

/// 首页大厅页面
class HallPage extends BasePage<HallController> {
  const HallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        backgroundColor: ThemeColor.themeColor,
        textColor: ThemeColor.whiteColor,
        leading: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              SizedBox(width: 14),
              GestureDetector(
                onTap: controller.pushUserInfoPage,
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeColor.whiteColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text(
                    '头像',
                    style: TextStyles(),
                  ),
                ),
              ),
            ],
          ),
        ),
        '找人',
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(color: Colors.transparent, height: 1.0),
          preferredSize: Size.fromHeight(1.0),
        ),
        actions: [
          Image.asset(
            "assets/image/common/create_chat@3x.png",
            width: 32,
            height: 32,
          ),
        ],
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 输入你想找的人，AI智能匹配提示语
            Visibility(
              visible: controller.findPrompt,
              child: FindFriendPromptWidget(),
            ),
            Visibility(
              visible: controller.findPrompt,
              child: Spacer(),
            ),

            /// 热门活动卡片（提示语模式：aiTags）
            Visibility(
              visible: controller.findPrompt,
              child: Center(
                child: CardStackPage(
                  findTap: (content) =>
                      controller.editingController?.text = content,
                  items: controller.vm.value.aiTags,
                  emptyHintWhenNoData: '暂无热门标签',
                  emptyHintWhenNoMore: '没有更多了',
                ),
              ),
            ),

            /// 找人卡片（找友模式：匹配结果 friends）
            Visibility(
              visible: !controller.findPrompt,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: CardStackDemo(),
              ),
            ),
            Spacer(),

            /// 底部输入框
            InputAiWidget(
              hint: '输入你正在做的事…',
              controller: controller.editingController,
              focusNode: controller.focusNode,
              onSubmittedTap: (content) async {
                /// 点击开始找人
                controller.clickStartFindFriend(content);
              },
            ),
            SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
