import 'package:flutter/material.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'view/message_doing_header_view.dart';
import 'package:kellychat/tripartite_library/pull_to_refresh/refresher_header.dart';
import 'package:kellychat/utils/extension/dates/dates.dart';
import 'package:kellychat/utils/extension/lists/lists.dart';
import 'message_controller.dart';
import 'view/chat_list_cell.dart';
import 'view/input_search_view.dart';
import 'view/invite_record_view.dart';
import 'view/msg_clout_view.dart';

/// FileName: message_page
///
/// @Author 谌文
/// @Date 2026/3/10 19:53
///
/// @Description 消息模块页面-page
class MessagePage extends BasePage<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 刷新数据
    controller.refreshData();
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Obx(
        () => Scaffold(
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
                      child: ImageLookWidget(
                        imgUrl: UserCenter().user?.avatar ?? '',
                        width: 32,
                        height: 23,
                        enlargeLook: false,
                        imgBorderRadius: BorderRadius.circular(999),
                        heroTag:
                            '${UserCenter().user?.avatar ?? ''}_message_page_avatar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            '消息',
            elevation: 0.0,
            bottom: PreferredSize(
              child: Container(color: Colors.transparent, height: 1.0),
              preferredSize: Size.fromHeight(1.0),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 8),

              /// 底部输入框
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: InputSearchWidget(),
              ),

              SizedBox(height: 16),

              /// 列表
              Expanded(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  header: RefresherHeader.build(),
                  child: ListView.builder(
                    itemCount: controller.vm.value.conversations.length + 4,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        /// 消息列表-正在做的任务
                        final myDoing = MyDoing().doing;
                        if (myDoing?.togetherPartner == null) {
                          return const SizedBox.shrink();
                        }
                        return MessageDoingHeaderView(
                          tagName: myDoing?.tagName,
                          partnerName: myDoing?.togetherPartner?.nickname,
                          onCancelTap: controller.clickDeleteStatusDoing,
                        );
                      } else if (index == 1) {
                        /// 邀约中的任务view
                        return InviteRecordWidget(
                          tap: controller.pushInviteRecordPage,
                          time:
                              Lists.isNotEmpty(controller.vm.value.togetherList)
                                  ? controller
                                      .vm.value.togetherList.first.completedAt
                                  : '',
                          headPortraits: controller.vm.value.togetherList
                              .map((e) => e.initiatorAvatar ?? '')
                              .toList(),
                        );
                      } else if (index == 2) {
                        /// 敲一下记录列表
                        if (Lists.isNotEmpty(
                            controller.vm.value.knockRecordEntity?.items)) {
                          final item = controller
                              .vm.value.knockRecordEntity?.items?.first;
                          final unreadCount = controller
                              .vm.value.knockRecordEntity?.unreadCount;
                          return MsgCloutWidget(
                            onTap: controller.pushBeatRecordPage,
                            headPortraitUrl: item?.targetAvatar,
                            name: item?.targetNickname,
                            interactionDesc: item?.interactionDesc,
                            time: item?.timeAgo,
                            cloutNum: (unreadCount ?? 0) > 99
                                ? '99+'
                                : '${unreadCount ?? ''}',
                          );
                        }
                        return Container();
                      } else if (index == 3) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: 16, bottom: 12, left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '聊天',
                                style: TextStyles(
                                  fontSize: 18,
                                  color: ThemeColor.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Visibility(
                                visible: Lists.isEmpty(
                                    controller.vm.value.conversations),
                                child: SizedBox(height: 16),
                              ),
                              Visibility(
                                visible: Lists.isEmpty(
                                    controller.vm.value.conversations),
                                child: Text(
                                  '暂无消息',
                                  style:
                                      TextStyles(color: ThemeColor.white6Color),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      final conversations =
                          controller.vm.value.conversations;
                      final chatIndex = index - 4;
                      final item = conversations[chatIndex];
                      return ChatListCell(
                        showTopRadius: chatIndex == 0,
                        showBottomRadius:
                            chatIndex == conversations.length - 1,
                        onTap: () => controller.pushChatPage(item),
                        headPortraitUrl: item.avatar,
                        name: item.nickname,
                        msg: item.lastMessage,
                        time: Dates.formatChatRelativeTime(
                            item.lastMessageTimeRaw),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
