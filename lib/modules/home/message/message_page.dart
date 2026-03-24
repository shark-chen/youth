import 'package:youth/base/base_page.dart';
import 'package:youth/widget/bottom_alert/bottom_alert.dart';
import 'package:youth/widget/input/sure_input/input_sure.dart';
import 'message_controller.dart';
import 'view/chat_list_cell.dart';
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
        controller.title ?? '',
        elevation: 0.2,
        leading: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ThemeColor.whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '头像',
            style: TextStyles(),
          ),
        ),
        backgroundColor: ThemeColor.themeColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 8),

          /// 底部输入框
          InputSure(
            hintText: '描述你想找的人…',
          ),

          SizedBox(height: 8),

          /// 列表
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  /// 消息列表-正在做的任务
                  return MsgDoingWidget(
                    doing: '正在看电影',
                    whoName: '小美',
                  );
                } else if (index == 1) {
                  /// 邀约中的任务view
                  return InviteRecordWidget(
                    tap: controller.pushInviteRecordPage,
                    time: '123小时',
                  );
                } else if (index == 2) {
                  return MsgCloutWidget(
                    onTap: controller.pushBeatRecordPage,
                    name: '小妹',
                    cloutNum: '123',
                    time: '22小时前',
                  );
                } else if (index == 3) {
                  return Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6, left: 12),
                    child: Text(
                      '聊天',
                      style: TextStyles(
                        color: ThemeColor.whiteColor,
                      ),
                    ),
                  );
                }
                return ChatListCell(
                  onTap: controller.pushChatPage,
                  headPortraitUrl: '',
                  name: '亚马逊',
                  msg: '你牛逼',
                  time: '23:00',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
