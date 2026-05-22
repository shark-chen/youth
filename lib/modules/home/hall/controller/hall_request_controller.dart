import 'package:kellychat/modules/user/user_center/user_info/user_info_center.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import 'package:kellychat/network/net/net.dart';
import 'package:kellychat/utils/extension/lists/lists.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../mine/user_info/model/user_info_entity.dart';
import '../hall_controller.dart';
import '../model/smart_match_people_entity.dart';

/// FileName: hall_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 19:12
///
/// @Description 首页-request-控制器-controller
extension HallRequestController on HallController {
  /// mark - request
  ///
  /// 获取配对建议列表
  Future<bool> requestMatchSuggestions({
    bool append = false,
    bool showLoading = true,
  }) async {
    if (showLoading) EasyLoading.show();
    final response = await Net.value<Doing>().requestMatchSuggestions<String>();
    if (showLoading) EasyLoading.dismiss();
    if (response.succeed) {
      if (append) {
        vm.value.appendAiTags(response.values);
      } else {
        vm.value.configAiTags(response.values);
      }
      vm.value = vm.value;
      if (!append) vm.refresh();
      return true;
    }
    if (showLoading) {
      EasyLoading.showToast(response.msg ?? '');
    }
    return false;
  }

  /// POST /api/match/search
  Future<bool> requestMatchSearch({
    String description = '',
    int page = 1,
    int size = 20,
  }) async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestMatchSearch<SmartMatchPeopleEntity>(
      description: description,
      page: page,
      size: size,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.friends = response.value?.list;
      vm.refresh();
      if (Lists.isEmpty(vm.value.friends)) {
        EasyLoading.showToast('未找到符合条件的用户');
      }
      return Lists.isNotEmpty(vm.value.friends);
    }
    return false;
  }

  /// 获取个人信息 · GET /api/user/profile
  Future<void> requestUserProfile() async {
    vm.value.configUserInfo(await UserInfoCenter().userInfo);
    vm.refresh();
  }
}
