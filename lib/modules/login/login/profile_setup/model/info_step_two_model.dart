import 'package:kellychat/widget/bubble/model/bubble_model.dart';
import 'package:kellychat/widget/region_picker/region_picker_sheet.dart';

/// FileName: info_step_two_model
///
/// @Author 谌文
/// @Date 2026/6/10 00:03
///
/// @Description 设置用户信息第二步模型数据
class InfoStepTwoModel {
  /// 地区
  RegionPickerSelection? region;

  /// 自定义标签
  List<String> customTags = [];

  /// 可选择的标签
  List<BubbleModel> optionTags = [];
}
