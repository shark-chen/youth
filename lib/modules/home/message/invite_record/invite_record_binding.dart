import 'package:kellychat/base/base_bindings.dart';
import 'invite_record_controller.dart';

/// FileName: invite_record_binding
///
/// @Author 谌文
/// @Date 2026/3/12 23:09
///
/// @Description 邀约记录-binding
class InviteRecordBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteRecordController>(() => InviteRecordController());
  }
}
