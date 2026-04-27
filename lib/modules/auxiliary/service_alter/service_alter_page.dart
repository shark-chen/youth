import 'package:kellychat/modules/login/login/view/input_verify_view.dart';
import '../../../base/base_page.dart';
import '../../login/login/view/accounts_view.dart';
import '../../login/view/login_button.dart';
import 'service_alter_controller.dart';

/// FileName service_alter_page
///
/// @Author 谌文
/// @Date 2024/7/12 16:12
///
/// @Description 服务修改页面
class ServiceAlterPage extends BasePage<ServiceAlterController> {
  const ServiceAlterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.vm.value.showServers = false;
        controller.vm.value.showHtml = false;
        controller.hideKeyboard();
        controller.vm.refresh();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarKit.appBar(controller.title ?? ''),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
          child: Obx(
            () => Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '服务端地址',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 6),

                    /// 手机验证码
                    InputVerifyWidget(
                      hint: '请输入服务端地址',
                      controller: controller.vm.value.serverController,
                      onTap: () {
                        controller.vm.value.showServers = true;
                        controller.vm.refresh();
                      },
                    ),

                    const SizedBox(height: 140),

                    /// 确认
                    LoginButton(title: '保存', onTap: controller.saveServiceConfig),
                  ],
                ),
                Visibility(
                  visible: controller.vm.value.showServers,
                  child: AccountsWidget(
                    maxLine: 6,
                    top: 73,
                    left: 0,
                    right: 0,
                    accounts: controller.vm.value.servers,
                    onTap: (index) {
                      controller.vm.value.showServers = false;
                      controller.vm.value.serverController.text =
                          controller.vm.value.servers[index].title;
                      controller.vm.refresh();
                    },
                  ),
                ),
                Visibility(
                  visible: controller.vm.value.showHtml,
                  child: AccountsWidget(
                    maxLine: 4,
                    top: 166,
                    left: 0,
                    right: 0,
                    accounts: controller.vm.value.htmlList,
                    onTap: (index) {
                      controller.vm.value.showHtml = false;
                      controller.vm.value.htmlController.text =
                          controller.vm.value.htmlList[index].title;
                      controller.vm.refresh();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
