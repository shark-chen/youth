import 'package:youth/utils/extension/strings/strings.dart';
import '../model/hall_mark_model.dart';
import 'hall_vm.dart';
import 'package:youth/utils/extension/lists/lists.dart';

/// FileName hall_msg_vm
///
/// @Author 谌文
/// @Date 2025/6/11 20:49
///
/// @Description 首页消息数量- 各个功能右上角标数量
extension HallMsgVM on HallVM {
  /// 配置合并后的总消息数量
  void configTotalMsg(int totalCount) async {
    if (totalCount <= 0) {
      messageCount = '';
    } else {
      messageCount = totalCount > 99 ? '99+' : totalCount.toString();
    }
  }

  /// 配置 移货 补货 波次 角标数量
  void configMark(HallMarkModel mark) {
    final index = marks.indexWhere((value) => value.pageName == mark.pageName);
    if (index != -1) {
      marks[index] = mark;
    } else {
      marks.add(mark);
    }

    /// 更新首页各个图标的角标数量
    updateHallMark();
  }

  /// 更新首页各个图标的角标数量
  void updateHallMark() {
    for (HallMarkModel value in marks) {
      rows?.forEach((element) {
        element.items?.forEach((item) {
          item.edgeHeight = 0;
          if (item.pageName == value.pageName) {
            item.markNum = value.markNum > 0
                ? (value.markNum > 99)
                    ? '99+'
                    : value.markNum.toString()
                : '';
          }
        });
      });
    }

    /// 由于有角标，会导致，有cell高度高，没角标的有低，排版不对齐，所以需要计算，某个有角标时，整行高度都需要调高
    rows?.forEach((element) {
      /// 获取4个一排数据， 判断这一排中是否有图标数量大于0的情况，有则高度度变高
      final rows = element.items?.groupBy(4);
      rows?.forEach((row) {
        final exist = row.any((item) => Strings.isNotEmpty(item.markNum));
        if (exist) {
          row.forEach((item) => item.edgeHeight = 12);
        }
      });
    });
  }
}
