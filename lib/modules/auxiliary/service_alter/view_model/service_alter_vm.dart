import 'package:youth/base/base_vm.dart';
import '../../../../config/environment_config/app_config.dart';

/// FileName service_alter_vm
///
/// @Author 谌文
/// @Date 2024/7/12 17:28
///
/// @Description 服务地址VM
class ServiceAlterVM extends BaseVM {
  ServiceAlterVM();

  final serverController = TextEditingController();
  final htmlController = TextEditingController();

  List<BubbleModel> servers = [];
  List<BubbleModel> htmlList = [];

  /// 是否展示服务选择框
  bool showServers = false;
  bool showHtml = false;

  @override
  void onInit() {
    serverController.text = AppConfig.apiHost;
    htmlController.text = AppConfig.clientHost;

    /// 配置服务地址
    configServers();

    /// 配置H5地址
    configHtmlList();
  }

  /// 配置服务地址
  void configServers() {
    var list = [
      'https://bs1-priv-www.meiyunji.net',
      'https://bs2-priv-www.meiyunji.net',
      'https://bs3-priv-www.meiyunji.net',
      'https://bs4-priv-www.meiyunji.net',
      'https://bs5-priv-www.meiyunji.net',
      'https://bs6-priv-www.meiyunji.net',
      'https://bs7-priv-www.meiyunji.net',
      'https://bs8-priv-www.meiyunji.net',
      'https://bs9-priv-www.meiyunji.net',
    ];
    if (!(list.contains(AppConfig.apiHost))) {
      list.insert(0, AppConfig.apiHost);
    }

    list.forEach((element) {
      servers.add(BubbleModel(title: element));
    });

    servers.forEach((element) {
      if (element.title == AppConfig.apiHost) {
        element.selected = true;
      }
    });
  }

  /// 配置H5地址
  void configHtmlList() {
    var list = [
      'https://bs1-priv-www.meiyunji.net',
      'https://bs2-priv-www.meiyunji.net',
      'https://bs3-priv-www.meiyunji.net',
      'https://bs4-priv-www.meiyunji.net',
      'https://bs5-priv-www.meiyunji.net',
      'https://bs6-priv-www.meiyunji.net',
      'https://bs7-priv-www.meiyunji.net',
      'https://bs8-priv-www.meiyunji.net',
      'https://bs9-priv-www.meiyunji.net',
      'https://bs10-priv-www.meiyunji.net',
      'https://bs11-priv-www.meiyunji.net',
      'https://bs12-priv-www.meiyunji.net',
      'https://bs13-priv-www.meiyunji.net',
    ];

    if (!(list.contains(AppConfig.clientHost))) {
      list.insert(0, AppConfig.clientHost);
    }
    list.forEach((element) {
      htmlList.add(BubbleModel(title: element));
    });

    htmlList.forEach((element) {
      if (element.title == AppConfig.clientHost) {
        element.selected = true;
      }
    });
  }
}
