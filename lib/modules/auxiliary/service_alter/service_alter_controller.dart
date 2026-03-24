import '../../../base/base_controller.dart';
import '../../../config/environment_config/app_config.dart';
import 'view_model/service_alter_vm.dart';

/// FileName service_alter_controller
///
/// @Author 谌文
/// @Date 2024/7/12 16:12
///
/// @Description 服务切换控制器
class ServiceAlterController extends BaseController {
  Rx<ServiceAlterVM> vm = ServiceAlterVM().obs;

  @override
  void onInit() {
    super.onInit();
    title = '服务地址';
  }

  /// 保存服务配置
  void saveServiceConfig() {
    if (AppConfig.env == Environment.prod) return;
    AppConfig.config.configModel?.serverHost = vm.value.serverController.text;
    AppConfig.config.configModel?.clientHost = vm.value.htmlController.text;
    Get.back();
  }
}
