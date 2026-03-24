import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:youth/widget/input/sure_input/input_sure.dart';
import 'package:youth/widget/input/sure_input/sure_input.dart';
import '../../../base/base_page.dart';
import 'hall_controller.dart';
import 'view/hall_cell.dart';
import 'view/message_view.dart';
import 'view_model/hall_vm.dart';

/// 首页大厅页面
class HallPage extends BasePage<HallController> {
  const HallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        backgroundColor: ThemeColor.themeColor,
        textColor: ThemeColor.whiteColor,
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
        '找人',
        elevation: 0.2,
        actions: [
          Icon(
            Icons.chat,
            color: ThemeColor.whiteColor,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),

          /// AI找人的icon
          Center(
            child: ImageLookWidget(
              width: 80,
              height: 80,
              imgUrl: '',
            ),
          ),

          SizedBox(
            height: 120,
          ),

          /// 昵称
          Text(
            'Hi，维肯特劳\n告诉KellyChat,你想找什么养的人?\n🎉 输入找人需求，AI 智能搜索匹配…',
            style: TextStyles(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ThemeColor.whiteColor,
            ),
          ),


          Expanded(child: Container()),

          /// 底部输入框
          InputSure(hintText: '描述你想找的人…',),

          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
