import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/auxiliary/wechat.dart';
import 'package:youth/network/network_monitor/network_monitor.dart';
import 'view_model/ping_vm.dart';

/// FileName: ping_controller
///
/// @Author 谌文
/// @Date 2026/1/22 10:35
///
/// @Description ping_controller
class PingController extends BaseController {
  /// vm
  Rx<PingVM> vm = PingVM().obs;

  @override
  void onInit() async {
    super.onInit();

    /// 开启网络监听
    NetworkMonitor().startMonitor(monitor: true);
  }

  /// 点击ping网络数据
  void clickPingNet() async {
    clickClear();
    await NetworkMonitor().ping(
      count: 20,
      complete: (value) {
        vm.value.addRow(value.toString());
        vm.refresh();
      },
    );
  }

  /// 清空数据
  void clickClear() {
    vm.value.clearRows();
    vm.refresh();
  }

  /// 点击发送
  Future clickSend() async {
    if (Lists.isEmpty(vm.value.rows)) return;
    var response = await Net.value<Wechat>()
        .requestSendDeBugApiData(msg: vm.value.rows.first);
    if (response.response?.data['errcode'] == 0) {
      EasyLoading.showToast('已发送到《APP-测试环境接口数据群》，不在群里可找谌文加群');
    } else {
      EasyLoading.showToast(response.response?.data['errmsg'] ?? response.msg);
    }
    vm.refresh();
  }
}
