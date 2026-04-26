import 'package:youth/base/base_controller.dart';
import 'package:youth/base/base_page.dart';
import 'package:youth/base/base_service.dart';
import 'hall_controller.dart';
import 'view/hot_tags_view.dart';
import 'view/find_friend_prompt_view.dart';
import 'view/input_ai_view.dart';
import 'view/make_friend_view.dart';
import 'view_model/hall_vm.dart';

/// FileName hall_controller
///
/// @Author 谌文
/// @Date 2023/8/23 15:57
///
/// @Description 首页大厅页面-page
class HallPage extends BasePage<HallController> {
  const HallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeColor.themeColor,
        appBar: AppBarKit.appBar(
          backgroundColor: ThemeColor.themeColor,
          textColor: ThemeColor.whiteColor,
          leading: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                SizedBox(width: 14),
                Obx(
                  () => GestureDetector(
                    onTap: controller.pushUserInfoPage,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ThemeColor.whiteColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: ImageLookWidget(
                        imgUrl: controller.vm.value.userInfo?.avatar ?? '',
                        width: 32,
                        height: 23,
                        enlargeLook: false,
                        imgBorderRadius: BorderRadius.circular(32),
                      ),
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
            GestureDetector(
              onTap: controller.clickNewChat,
              child: Padding(
                padding: EdgeInsets.only(right: 6),
                child: Image.asset(
                  "assets/image/common/create_chat@3x.png",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            final bottomSafe = MediaQuery.of(context).viewPadding.bottom;
            final y = (bottomInset - kBottomNavigationBarHeight - bottomSafe);
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// 输入你想找的人，AI智能匹配提示语
                    Visibility(
                      visible: controller.findPrompt,
                      child: FindFriendPromptWidget(
                        niceName: controller.vm.value.userInfo?.nickname,
                      ),
                    ),
                    Visibility(
                      visible: controller.findPrompt,
                      child: Spacer(),
                    ),

                    /// 热门活动卡片（提示语模式：aiTags）
                    Visibility(
                      visible: controller.findPrompt,
                      child: Center(
                        child: HotTagsWidget(
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
                        child: CardStackDemo(
                          friends: controller.vm.value.friends ?? [],
                          onTap: controller.clickLookUserInfo,
                          emptyHintWhenNoData: '暂无匹配用户',
                          emptyHintWhenNoMore: '没有更多了',
                          removeFriendCall: (count) {
                            if (count <= 0) {
                              controller.vm.value.findMode =
                                  FindMode.findPrompt;
                              controller.vm.refresh();
                            }
                          },
                          chatTap: (friend) {
                            controller.pushChatPage(friend);
                          },
                        ),
                      ),
                    ),

                    /// 保持主体布局占位，不随键盘挤压改变
                    // Spacer(),
                  ],
                ),

                /// 输入框悬浮层：随键盘抬起，贴在键盘上方
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(
                        bottom:
                            y > 0 ? (y > 0 ? y : bottomInset) : bottomInset),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: bottomInset > 60 ? 0 : (bottomSafe + 12),
                      ),
                      child: Container(
                        padding: bottomInset > 60
                            ? EdgeInsets.only(top: 8)
                            : EdgeInsets.zero,
                        color: bottomInset > 60
                            ? ThemeColor.textBlackColor.withOpacity(0.5)
                            : Colors.transparent,
                        child: InputAiWidget(
                          hint: '描述你想找的人…',
                          controller: controller.editingController,
                          focusNode: controller.focusNode,
                          onSubmittedTap: (content) async {
                            /// 点击开始找人
                            controller.clickStartFindFriend(content);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
