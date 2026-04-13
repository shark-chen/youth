import 'package:youth/base/base_controller.dart';
import 'package:youth/modules/user/global.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'user_info/model/user_info_entity.dart';
import 'view_model/mine_vm.dart';

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

  /// mark - request
  ///
  /// 拉取个人资料（头像、昵称等）
  Future<void> refreshProfile() async {
    final response = await Net.value<User>().requestUserInfo<UserInfoEntity>();
    if (response.succeed) {
      /// 当前登录用户资料（与资料页同源模型）
      vm.value.configUserProfile(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
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
    final changed = await Get.toNamed(Routes.userInfoPage);
    await refreshProfile();
  }

  /// 关于 KellyChat
  Future<void> pushAbout() async {
    await Get.toNamed(Routes.aboutKellyChatPage);
  }

  /// 退出登录
  Future<void> confirmLogout() async {
    final ok = await showDialog<bool>(
      context: Get.context!,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ThemeColor.inputBgColor,
          title: Text(
            '提示',
            style: TextStyle(color: ThemeColor.whiteColor),
          ),
          content: Text(
            LocaleKeys.LoginOutConfirm.tr,
            style: TextStyle(color: ThemeColor.whiteColor.withOpacity(0.85)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(
                '取消',
                style: TextStyle(color: ThemeColor.themeA2Color),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(
                '确定',
                style: TextStyle(color: ThemeColor.themeGreenColor),
              ),
            ),
          ],
        );
      },
    );
    if (ok != true) return;
    await Global.clearAccessToken();
    Global.actualLogin.value = false;
    await UserCenter().clear(loginOut: true);
    await Get.offAllNamed(Routes.login);
  }
}
