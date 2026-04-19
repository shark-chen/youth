import 'package:youth/base/base_page.dart';
import 'package:youth/modules/home/doing/doing_list/view/doing_list_header_view.dart';
import 'package:youth/utils/extension/lists/lists.dart';
import 'package:youth/widget/bottom_alert/bottom_alert.dart';
import 'package:youth/widget/bottom_dialog/bottom_dialog.dart';
import 'package:youth/widget/input/sure_input/input_sure.dart';
import 'message_controller.dart';
import 'view/chat_list_cell.dart';
import 'view/input_search_view.dart';
import 'view/invite_record_view.dart';
import 'view/msg_clout_view.dart';
import 'view/msg_doing_view.dart';

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
    return Scaffold(
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
              Container(
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
            child: ListView.builder(
              itemCount: controller.vm.value.conversations.length + 4,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  /// 消息列表-正在做的任务
                  return GestureDetector(
                    onTap: controller.clickDeleteStatusDoing,
                    child: DoingListHeaderWidget(
                      title: controller.vm.value.myDoing?.tagName ?? '--',
                      inviteTap: controller.pushInviteAlert,
                    ),
                  );
                  ;
                } else if (index == 1) {
                  /// 邀约中的任务view
                  return InviteRecordWidget(
                    tap: controller.pushInviteRecordPage,
                    time: Lists.isNotEmpty(controller.vm.value.togetherList)
                        ? controller.vm.value.togetherList.first.completedAt
                        : '',
                    headPortraits: controller.vm.value.togetherList
                        .map((e) => e.initiatorAvatar ?? '')
                        .toList(),
                  );
                } else if (index == 2) {
                  if(Lists.isNotEmpty(controller.vm.value.beatList)) {
                    return MsgCloutWidget(
                      onTap: controller.pushBeatRecordPage,
                      name: controller.vm.value.beatList.first.fromNickname,
                      cloutNum: '${controller.vm.value.beatList.length ?? 0}',
                      time: controller.vm.value.beatList.first.createdAt,
                    );
                  }
                 return Container();
                } else if (index == 3) {
                  return Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 12, left: 12),
                    child: Text(
                      '聊天',
                      style: TextStyles(
                        fontSize: 18,
                        color: ThemeColor.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                final item = controller.vm.value.conversations[index - 4];
                return ChatListCell(
                  onTap: controller.pushChatPage,
                  headPortraitUrl: item.avatar,
                  name: item.nickname,
                  msg: item.lastMessage,
                  time: item.lastMessageTimeRaw,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
