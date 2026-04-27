import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/widget/region_picker/region_picker_data.dart';
import 'package:kellychat/widget/region_picker/region_picker_sheet.dart';
import '../../sex_select/model/user_info_param.dart';

/// FileName: city_set_vm
///
/// @Author 谌文
/// @Date 2026/3/28 23:20
///
/// @Description 城市设置-vm
class CitySetVM extends BaseVM {
  /// 省市区数据
  List<RegionProvince>? _cachedProvinces;

  /// 选择的省市区
  RegionPickerSelection? selectRegion;

  /// 注册登录用户信息参数
  UserInfoParam? userInfoParam;

  @override
  void onInit() async {
    super.onInit();
    unawaited(_preloadRegions());
  }

  /// 选择的位置
  String? get selectLocation {
    return '${selectRegion?.province ?? ''}' +
        '${selectRegion?.city ?? ''}' +
        '${selectRegion?.district ?? ''}';
  }

  /// 预加载省市区数据
  Future<void> _preloadRegions() async {
    try {
      final raw = await rootBundle.loadString('assets/data/china_regions.json');
      _cachedProvinces = parseRegionProvincesJson(raw);
    } catch (_) {
      _cachedProvinces = null;
    }
  }

  /// 省市区数据
  Future<List<RegionProvince>?>? get cachedProvinces async {
    if (Lists.isNotEmpty(_cachedProvinces)) return _cachedProvinces;
    try {
      final raw = await rootBundle.loadString('assets/data/china_regions.json');
      _cachedProvinces = parseRegionProvincesJson(raw);
    } catch (_) {
      EasyLoading.showToast('地区数据加载失败');
      return null;
    }
    return _cachedProvinces;
  }
}
