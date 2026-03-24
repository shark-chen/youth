import 'package:youth/utils/stores/stores.dart';
import '../../../config/environment_config/app_config.dart';
import '../../../network/net/entry/user/user.dart';
import '../../../network/net/net.dart';
import '../../../tripartite_library/screenshot/screenshot.dart';
import '../../../tripartite_library/store/preferences.dart';
import '../../auxiliary/network_look/model/network_model_utils.dart';
import '../../auxiliary/network_look/view/draggable_net_view.dart';

/// FileName load_item
///
/// @Author 谌文
/// @Date 2024/8/29 19:34
///
/// @Description 加载项目
class LoadItem {
  static final LoadItem _instance = LoadItem._();

  factory LoadItem() => _instance;

  LoadItem._();

  /// 首页加载项目
  Future homeLoad() async {
    /// 加载设置通知
    await loadNotification();

    if (AppConfig.env != Environment.prod) {
      /// 刷新浮动api显示
      await NetworkModelUtils().apiOpen;
      DraggableNetWidget.vm.refresh();

      /// 测试环境截图发群
      await Screenshot().init();
    }
  }

  /// 加载设置通知
  Future loadNotification() async {
    bool getTed = await Stores().get<bool>(
            UserConfigEnum.notificationConfigurationItem.toString()) ??
        false;
    if (getTed) return;

    /// 设置APP通知默认打开
    var response = await Net.value<User>().requestNotificationConfig();
    if (response.code == 0) {
      await Stores().put<bool>(
          UserConfigEnum.notificationConfigurationItem.toString(), true);
    }
  }
}
