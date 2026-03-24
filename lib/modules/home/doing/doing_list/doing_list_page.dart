import 'package:flutter/cupertino.dart';
import 'package:youth/base/base_page.dart';
import 'doing_list_controller.dart';
import 'view/doing_list_cell.dart';
import 'view/doing_list_header_view.dart';

/// FileName: doing_list_page
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-页面-page
class DoingListPage extends BasePage<DoingListController> {
  const DoingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        textColor: ThemeColor.whiteColor,
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
          /// 正在做的清单-头部view
          DoingListHeaderWidget(
            title: '看电影',
            closeTap: controller.closePage,
            inviteTap: controller.closePage,
          ),

          /// 正在做的事情列表
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 12),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return DoingListCell();
              },
              separatorBuilder:  (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
            ),
          ),
        ],
      ),
    );
  }
}
