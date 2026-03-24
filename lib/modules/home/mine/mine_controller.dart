import 'package:youth/utils/utils/language/lang_value.dart';
import 'package:youth/utils/utils/language/language_utils.dart';
import '../../../base/base_controller.dart';
import '../../../network/reporter/wechat/wechat_report.dart';
import '../../user/global.dart';
import '../home/view/tabs.dart';
import 'model/mine_entity.dart';
import 'model/mine_model.dart';
import 'view_model/mine_vm.dart';
import 'controller/mine_request_controller.dart';
import 'controller/mine_route_controller.dart';
export 'controller/mine_route_controller.dart';

/// FileName mine_controller
///
/// @Author 谌文
/// @Date 2023/8/23 11:40
///
/// @Description 我的页面控制器
class MineController extends BaseController {
  var isNewVersion = false.obs;
  var versionText = "--".obs;

  /// 我的页面数据类型
  Rx<MineEntity> mineEntity = MineEntity().obs;

  /// vm
  Rx<MineVM> vm = MineVM().obs;

  @override
  void onInit() async {
    super.onInit();
    vm.value.refresh = vm.refresh;
  }

  @override
  void onReady() async {
    super.onReady();

    /// 添加通知
    addEventBusManager();

    /// 创建我的页面的数据
    await vm.value.buildRows();

    /// request - 获取服务端最新版本号
    requestNewVersion();

    /// 配置用户信息
    await vm.value.configAccountInfo();
  }

  @override
  void changeMetricsUpdateUI() {
    vm.refresh();
  }

  /// 添加通知
  void addEventBusManager() {
    /// 每次切换到首页需要获取一遍是否有新消息
    EventBusManager().listen<HomeTabs>(this, (event) async {
      if (event == HomeTabs.mine) {
        if (Global.actualLogin.value) {
          await requestNewVersion();
        }
      }
    });

    /// 语言变化的通知, 刷新UI
    EventBusManager().listen<LangValue>(this, (event) async {
      /// 创建我的页面的数据
      await vm.value.buildRows();
    });
  }

  /// 点击cell
  void clickCell(MineModel item) async {
    /// 点击了店铺授权，需要判断权限
    if (item.routeName == Routes.shopAuth) {
      return await pushShopAuthPage();
    }

    /// 点击了版本信息，需要获取新版本提示
    if (item.routeName == null && item.title == LocaleKeys.VersionInfo.tr) {
      /// request -请求检查升级
      return await requestCheckUpgrade();
    }

    /// 点击了退登
    if (item.routeName == null &&
        item.middleContent == LocaleKeys.LoginOut.tr) {
      /// 请求退出登录
      return await requestLoginOut();
    }

    /// 点击了注销账号
    if (item.routeName == null &&
        item.middleContent == LocaleKeys.CancelAccount.tr) {
      /// request -注销账户
      return await requestUnsubscribeAccount();
    }



    /// 跳转下一级页面
    if (Strings.isNotEmpty(item.routeName)) {
      await Get.toNamed(item.routeName!, parameters: item.routeParameter);
    }
  }

  /// 点击我的标题
  Future clickMineTitle() async {
    // AuxiliaryCenter().autoOpenCloseDebug();
    await WechatReport.requestReportFile();
  }


  /// MARK - PUSH
  ///
  /// push - 跳转到系统设置页面
  Future pushSystemSetPage() async {
    await Get.toNamed(Routes.settings);
  }

  /// push - 跳转联系我们页面
  Future pushContactWayPage() async {
    await Get.toNamed(Routes.contactWayPage);
  }

  /// push - 跳转到店铺授权页面
  Future pushShopAuthPage() async {
    await AppRouter.toNamed(Routes.shopAuth);
  }
}
