import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/user/global.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
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

    /// 若当前有正在连接中的「一起做」，则自动断开
    final partner = MyDoing().doing?.togetherPartner;
    if (partner != null) {
      final tid = partner.togetherId;
      if (tid != null) {
        await requestCancelTogether(
          togetherId: tid.toString(),
          showLoad: false,
        );
      }
    }

    final apiOk = await requestAuthLogout();
    if (!apiOk) return;
    await Global.clearAccessToken();
    Global.actualLogin.value = false;
    await UserCenter().clear(loginOut: true);
    await Get.offAllNamed(Routes.login);
  }

  /// 点击注销账号
  Future<void> clickCancelAccount() async {
   final confirm = await pushDialogAlert(
      content: '账号注销后，你将无法使用该账号。个人资料、聊天、互动等所有数据将被永久删除。确定要注销吗？',
      rightTitle: '确定注销',
      rightCountdownSeconds: 10,
    );
   if(!confirm) return;
   /// request - 注销账号
   final result = await requestUnsubscribeUser();
   if(!result) return;
   /// 注销账户后，10分钟内不能登录
   await Stores(userLat: false).put<int>('unsubscribed_limit_time',
       (DateTime.now().millisecondsSinceEpoch / 1000).round());
   await Global.clearAccessToken();
   Global.actualLogin.value = false;
   await UserCenter().clear(loginOut: true);
   await Get.offAllNamed(Routes.login);
  }
}
