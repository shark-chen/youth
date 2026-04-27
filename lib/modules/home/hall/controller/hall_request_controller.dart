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
  Future requestMatchSuggestions() async {
    EasyLoading.show();
    var response = await Net.value<Doing>().caches<String>((values) {
      /// 配置AI标签（含空列表，用于清空展示）
      vm.value.configAiTags(values);
      vm.refresh();
    }).requestMatchSuggestions<String>();
    EasyLoading.dismiss();
    if (response.succeed) {
      /// 配置AI标签（含空列表，用于清空展示）
      vm.value.configAiTags(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// POST /api/match/search
  Future<bool> requestMatchSearch({
    String description = '',
    int page = 1,
    int size = 20,
  }) async {
    final response =
        await Net.value<Doing>().requestMatchSearch<SmartMatchPeopleEntity>(
      description: description,
      page: page,
      size: size,
    );
    if (response.succeed) {
      vm.value.friends = response.value?.list;
      vm.refresh();
      return Lists.isNotEmpty(vm.value.friends);
    }
    return false;
  }

  /// 获取个人信息 · GET /api/user/profile
  Future<void> requestUserProfile() async {
    EasyLoading.show();
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      vm.value.configUserInfo(value);
      vm.refresh();
    }).requestUserInfo<UserInfoEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configUserInfo(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
