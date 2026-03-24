import 'package:youth/base/base_bindings.dart';
import 'beat_record_controller.dart';

/// FileName: chat_record_binding
///
/// @Author 谌文
/// @Date 2026/3/17 23:23
///
/// @Description 敲一下记录- binding
class BeatRecordBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<BeatRecordController>(() => BeatRecordController());
  }
}
