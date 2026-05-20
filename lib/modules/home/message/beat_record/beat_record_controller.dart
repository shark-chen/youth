import 'package:kellychat/base/base_controller.dart';
import '../model/knock_record_entity.dart';
import 'controller/beat_record_request_controller.dart';
export 'controller/beat_record_request_controller.dart';
import 'view_model/beat_record_vm.dart';
export 'controller/beat_record_route_controller.dart';

/// FileName: beat_record_controller
///
/// @Author 谌文
/// @Date 2026/3/17 23:23
///
/// @Description 敲一下记录- controller
class BeatRecordController extends BaseController {
  /// vm
  Rx<BeatRecordVM> vm = BeatRecordVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '敲一下';

    /// request - 敲一下收件箱 获取24小时内双向敲一下记录（我敲的+敲我的），
    /// 每对用户只显示最近一次，同时返回未读数
    requestKnockInbox();
  }

  /// 列表数据
  List<KnockRecordItems> get rows => vm.value.rows;
}
