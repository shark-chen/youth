import '../../../base/base_controller.dart';
import '../../../config/environment_config/app_config.dart';
import '../../../network/net/entry/auxiliary/wechat.dart';
import 'model/network_model.dart';
import 'model/network_model_utils.dart';

/// FileName network_look_controller
///
/// @Author 谌文
/// @Date 2023/10/8 19:26
///
/// @Description 查看网络请求数据controller
class NetworkLookController extends BaseController {
  /// 网络数据
  RxList<NetworkModel> netDataLists = <NetworkModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    editingController = TextEditingController();
    netDataLists.value = NetworkModelUtils().netDataLists;
  }

  /// 搜素接口
  void searchPath(String path) {
    netDataLists.value = NetworkModelUtils().netDataLists;
    List<NetworkModel> searchList = <NetworkModel>[];
    for (var element in netDataLists) {
      if (element.title?.contains(path) ?? false) {
        searchList.add(element);
      }
    }
    netDataLists.value = searchList;
    netDataLists.refresh();
  }

  /// 发送日志
  Future requestSendApiData(int index) async {
    try {
      if (index >= netDataLists.length) return;
      var model = netDataLists[index];
      EasyLoading.show();
      var msg = '账号：${UserCenter().user?.userInfo?.phone}\n' +
          '服务地址：${AppConfig.apiHost} \n\n' +
          '接口名称 ${model.title} \n' +
          '请求参数 ${model.requestParameters}\n' +
          '响应数据 ${model.responseParameters},\nOther: ${model.other}';
      var response =
          await Net.value<Wechat>().requestSendDeBugApiData(msg: msg);
      if (response.response?.data['errcode'] == 0) {
        EasyLoading.showToast('已发送到《APP-测试环境接口数据群》，不在群里可找谌文加群');
      } else {
        EasyLoading.showToast(
            response.response?.data['errmsg'] ?? response.msg);
      }
    } catch (_) {}
  }
}
