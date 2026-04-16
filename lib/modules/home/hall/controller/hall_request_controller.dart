import 'package:youth/network/net/entry/doing/doing.dart';
import 'package:youth/network/net/net.dart';
import 'package:youth/utils/extension/lists/lists.dart';

import '../hall_controller.dart';
import '../model/smart_match_people_entity.dart';

/// FileName: hall_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 19:12
///
/// @Description 首页控制器
extension HallRequestController on HallController {
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
