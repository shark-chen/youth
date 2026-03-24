import '../../../base/base_page.dart';
import '../../../widget/search/search_view.dart';
import 'network_look_controller.dart';
import 'view/network_cell.dart';

/// FileName network_look_page
///
/// @Author 谌文
/// @Date 2023/10/8 19:27
///
/// @Description 查看网络请求数据页面
class NetworkLookPage extends BasePage<NetworkLookController> {
  const NetworkLookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarKit.appBar(
        "接口网络数据",
        actions: [
          TextButton(
            onPressed: () {
              controller.netDataLists.clear();
              controller.netDataLists.refresh();
            },
            child: const Text(
              '清空',
              style: TextStyle(
                  color: ThemeColor.otherTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchInputWidget(
              padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
              controller: controller.editingController,
              hint: "请输入接口名称",
              height: 56,
              onSubmitted: (String result) async {
                controller.searchPath(result);
              }),
          Expanded(
            child: Obx(
                  () =>
                  ListView.separated(
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    itemCount: controller.netDataLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NetworkCell(
                          model: controller.netDataLists[index],
                          onTap: () {
                            controller.netDataLists[index].unfold =
                            !(controller.netDataLists[index].unfold ?? false);
                            controller.netDataLists.refresh();
                          },
                          sendTap: ()=> controller.requestSendApiData(index)
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(color: ThemeColor.lineColor, height: 1),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
