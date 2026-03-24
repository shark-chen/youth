import 'package:youth/tripartite_library/tripartite_library.dart';
import '../model/hall_entity.dart';
import '../model/hall_item_entity.dart';
import 'hall_vm.dart';

/// FileName hall_store_vm
///
/// @Author 谌文
/// @Date 2024/12/24 19:16
///
/// @Description 首页缓存VM
extension HallStoreVM on HallVM {
  /// 获取uid存储的币种
  Future<String?> getStoreCurrency() async {
    return await Stores().get<String>("storeCurrency");
  }

  /// 按uid记忆上一次选择的Tab
  Future saveStoreCurrency(String currency) async {
    await Stores().put("storeCurrency", currency);
  }

  /// 预加载语音包： num:数量
  Future preDownloadVoices() async {
    if (Lists.isEmpty(rows)) return;
    if (voicesDownloaded) return;
    var containWaveTwicePick = false;
    outerLoop:
    for (HallEntity value in (rows ?? [])) {
      for (HallItemEntity item in (value.items ?? [])) {
        if (item.pageName == Routes.waveTwicePickHomePage) {
          containWaveTwicePick = true;
          break outerLoop;
        }
      }
    }
    if (containWaveTwicePick == false) return;
    voicesDownloaded = true;
  }
}
