import 'dart:ui';
import 'package:youth/utils/stores/stores.dart';
import '../../user/user_center/user_center.dart';

/// FileName daily_active
///
/// @Author 谌文
/// @Date 2024/2/4 16:26
///
/// @Description APP日活
class DailyActive {
  static final DailyActive _instance = DailyActive._();

  factory DailyActive() => _instance;

  bool requestIng = false;

  DailyActive._();

  /// APP日活接口
  Future requestDailyActive({AppLifecycleState? state}) async {
    if (UserCenter().user?.puid == null) return;
    String? date = await Stores().get<String>('dailyActiveKey', userLat: true);
    DateTime currentDate = DateTime.now();
    String currentDataStr =
        '${currentDate.year}:${currentDate.month}:${currentDate.day}';
    if (date == currentDataStr) return;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.resumed) {

    }
  }
}
