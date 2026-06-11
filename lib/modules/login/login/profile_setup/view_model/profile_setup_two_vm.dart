import 'package:flutter/services.dart';
import 'package:kellychat/modules/home/doing/model/doing_hot_tags_entity.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/edit_profile_draft.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/edit_region_indices.dart';
import 'package:kellychat/utils/extension/lists/lists.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';
import 'package:kellychat/widget/bubble/model/bubble_model.dart';
import 'package:kellychat/widget/region_picker/region_picker_data.dart';
import 'package:kellychat/widget/region_picker/region_picker_sheet.dart';
import 'profile_setup_vm.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// FileName: profile_setup_two_vm
///
/// @Author 谌文
/// @Date 2026/6/11 22:59
///
/// @Description 完善基础信息 -vm
extension ProfileSetupTwoVM on ProfileSetupVM {
  /// MARK - 完善地区，标签信息
  ///
  /// 配置地区
  void configRegion(RegionPickerSelection region) {
    stepTwo.region = region;
  }

  /// 选择的位置
  String? get selectLocation {
    if (stepTwo.region == null) return null;
    return '${stepTwo.region?.province ?? ''}' +
        '-${stepTwo.region?.city ?? ''}' +
        '-${stepTwo.region?.district ?? ''}';
  }

  /// 配置 用户注册时候，可选的标签
  void conRegisterTags(List<DoingHotTagsEntity>? values) {
    stepTwo.optionTags.clear();
    for (DoingHotTagsEntity value in (values ?? [])) {
      stepTwo.optionTags.add(BubbleModel(title: value.tagName ?? '--'));
    }
  }

  /// 点击添加标签
  void clickAddCustomTagTap(String value) {
    if (Strings.isEmpty(value)) return;
    if (selectTags.contains(value)) {
      EasyLoading.showToast('已经存在同样的标签');
      return;
    }
    if (selectTags.length >= EditProfileDraft.maxTags) {
      EasyLoading.showToast('最多${EditProfileDraft.maxTags}个标签');
      return;
    }
    stepTwo.customTags.add(value);
  }

  /// 获取选择好的标签
  List<String> get selectTags {
    final result = stepTwo.optionTags
        .where((element) => element.selected == true)
        .map((e) => e.title)
        .toList();
    result.addAll(stepTwo.customTags);
    return result;
  }

  /// 点击删除自定义标签
  void clickSelectDeleteCustomTag(String value) {
    stepTwo.customTags.remove(value);
  }

  /// 点击选择标签
  void clickSelectTagName(BubbleModel value) {
    if (true != value.selected &&
        selectTags.length >= EditProfileDraft.maxTags) {
      EasyLoading.showToast('最多${EditProfileDraft.maxTags}个标签');
      return;
    }
    value.selected = !(value.selected ?? false);
  }

  /// 加载本地的省市区
  Future<List<RegionProvince>?> loadProvinces() async {
    if (Lists.isNotEmpty(cachedProvinces)) return cachedProvinces;
    try {
      final raw = await rootBundle.loadString('assets/data/china_regions.json');
      cachedProvinces = parseRegionProvincesJson(raw);
    } catch (_) {
      EasyLoading.showToast('地区数据加载失败');
      return null;
    }
    return cachedProvinces;
  }

  /// 标记选中的地区
  EditRegionIndices? regionIndices(List<RegionProvince> provinces) {
    final pv = stepTwo.region?.province.trim();
    final cv = stepTwo.region?.city.trim();
    final dv = stepTwo.region?.district.trim();
    if (pv == null || pv.isEmpty) return null;
    final pi = provinces.indexWhere((e) => e.name.trim() == pv);
    if (pi < 0) return null;
    final cities = provinces[pi].cities;
    var ci = 0;
    var cityMatched = false;
    if (cv != null && cv.isNotEmpty) {
      final idx = cities.indexWhere((c) => c.name.trim() == cv);
      if (idx >= 0) {
        ci = idx;
        cityMatched = true;
      }
    }
    int? districtIndex;
    if (dv != null && dv.isNotEmpty && cities.isNotEmpty) {
      final ds = cities[ci].districts;
      final didx = ds.indexWhere((d) => d.trim() == dv);
      if (didx >= 0) districtIndex = didx;
    }
    final initialTabIndex = districtIndex != null ? 2 : (cityMatched ? 1 : 0);
    return EditRegionIndices(
      provinceIndex: pi,
      cityIndex: ci,
      districtIndex: districtIndex,
      initialTabIndex: initialTabIndex,
    );
  }
}
