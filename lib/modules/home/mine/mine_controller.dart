import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/user/global.dart';
import 'user_info/model/user_info_entity.dart';
import 'view_model/mine_vm.dart';
import 'controller/mine_request_controller.dart';

/// FileName: mine_controller
///
/// @Author 谌文
/// @Date 2026/4/12 20:41
///
/// @Description 我的-tab 控制器
class MineController extends BaseController {
  /// 当前登录用户资料（与资料页同源模型）
  Rx<MineVM> vm = MineVM().obs;

  @override
  void onInit() {
    super.onInit();
    title = '个人中心';
    refreshProfile();
  }

  /// mark - method
  ///
  /// 获取个人信息
  UserInfoEntity? get userProfile {
    return vm.value.userProfile;
  }

  /// mark - push
  ///
  /// 进入「编辑资料」
  Future<void> pushMyProfile() async {
    await Get.toNamed(Routes.userInfoPage);
    await refreshProfile();
  }

  /// 关于 KellyChat
  Future<void> pushAbout() async {
    await Get.toNamed(Routes.aboutKellyChatPage);
  }

  /// 退出登录
  Future<void> confirmLogout() async {
    var ok = false;
    await pushDialogAlert(
      content: '确定要退出应用吗',
      leftTitleColor: ThemeColor.theme7FColor,
      rightTitle: '确定',
      rightTitleColor: ThemeColor.themeGreenColor,
      rightTitleBgColor: ThemeColor.doingListTogetherBgColor,
      rightTap: () {
        ok = true;
        Get.back();
      },
    );
    if (ok != true) return;
    final apiOk = await requestAuthLogout();
    if (!apiOk) return;
    await Global.clearAccessToken();
    Global.actualLogin.value = false;
    await UserCenter().clear(loginOut: true);
    await Get.offAllNamed(Routes.login);
  }
}
