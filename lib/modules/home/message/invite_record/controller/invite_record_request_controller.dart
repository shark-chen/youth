import 'package:youth/network/net/entry/doing/doing.dart';

import '../../model/message_person_list_entity.dart';
import '../invite_record_controller.dart';
import 'package:youth/base/base_controller.dart';

import '../model/together_list_entity.dart';

/// FileName: invite_record_request_controller
///
/// @Author 谌文
/// @Date 2026/4/18
///
/// @Description 邀约记录-请求-controller
extension InviteRecordRequestController on InviteRecordController {
  /// mark - request
  ///
  /// GET /api/together/my-list
  Future<void> requestTogetherMyList() async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().caches<TogetherListEntity>((values) {
      vm.value.configTogetherList(values);
      vm.refresh();
    }).requestTogetherMyList<TogetherListEntity>();
    EasyLoading.dismiss();
    if (response.success) {
      vm.value.configTogetherList(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
