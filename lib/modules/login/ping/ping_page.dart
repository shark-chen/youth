import 'package:youth/base/base_page.dart';
import 'ping_controller.dart';

/// FileName: ping_page
///
/// @Author 谌文
/// @Date 2026/1/22 10:35
///
/// @Description ping-页面
class PingPage extends BasePage<PingController> {
  const PingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.whiteColor,
      appBar: AppBarKit.appBar('ping', elevation: 0.2),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.only(left: 6, right: 6),
                decoration: BoxDecoration(
                    color: ThemeColor.blueBgColor,
                    borderRadius: BorderRadius.circular(6)),
                child: TextButton(
                  onPressed: controller.clickClear,
                  child: const Text("Clear"),
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.only(left: 6, right: 6),
                decoration: BoxDecoration(
                    color: ThemeColor.blueBgColor,
                    borderRadius: BorderRadius.circular(6)),
                child: TextButton(
                  onPressed: controller.clickPingNet,
                  child: const Text("Click Ping"),
                ),
              ),

              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.only(top: 4),
                padding: EdgeInsets.only(left: 6, right: 6),
                decoration: BoxDecoration(
                    color: ThemeColor.blueBgColor,
                    borderRadius: BorderRadius.circular(6)),
                child: TextButton(
                  onPressed: controller.clickSend,
                  child: const Text("Send"),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Obx(
            () => Expanded(
              child: ListView.separated(
                itemCount: controller.vm.value.rows.length,
                itemBuilder: (BuildContext context, int index) {
                  final str = controller.vm.value.rows[index];
                  return Container(
                    padding:
                        EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                    child: Text(str),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    LineView(height: 1, padding: EdgeInsets.zero),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
