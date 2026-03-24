/// FileName hall_mark_model
///
/// @Author 谌文
/// @Date 2025/3/18 10:49
///
/// @Description 首页角标数量模型
class HallMarkModel {
  HallMarkModel({
    required this.markNum,
    required this.pageName,
  });

  /// 角标数量
  final int markNum;

  /// 对应的是那个图标，这里用路由记录
  final String pageName;
}
