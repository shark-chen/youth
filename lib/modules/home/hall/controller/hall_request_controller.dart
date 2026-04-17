import 'package:youth/network/net/entry/doing/doing.dart';
import 'package:youth/network/net/net.dart';
import 'package:youth/utils/extension/lists/lists.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../hall_controller.dart';
import '../model/smart_match_people_entity.dart';

/// FileName: hall_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 19:12
///
/// @Description 首页控制器
extension HallRequestController on HallController {
  /// mark - request
  ///
  /// 获取配对建议列表
  Future requestMatchSuggestions() async {
    EasyLoading.show();
    var response =
    await Net.value<Doing>().requestMatchSuggestions<String>();
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
}
