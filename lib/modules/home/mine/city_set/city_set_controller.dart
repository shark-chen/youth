import 'dart:async';

import 'package:flutter/services.dart';
import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/utils/marco/debug_print.dart';
import 'package:youth/widget/region_picker/region_picker_data.dart';
import 'package:youth/widget/region_picker/region_picker_sheet.dart';
import 'view_model/city_set_vm.dart';

/// FileName: city_set_controller
///
/// @Author 谌文
/// @Date 2026/3/26 22:29
///
/// @Description 地区设置-controller
class CitySetController extends BaseController {
  /// vm
  Rx<CitySetVM> vm = CitySetVM().obs;

  @override
  void onInit() async {
    super.onInit();
  }

  /// mark - method
  ///
  /// 点击完成
  Future clickFinish() async {
    if (vm.value.selectRegion == null ||
        Strings.isEmpty(vm.value.selectRegion?.district)) {
      EasyLoading.showToast('请选择城市');
      return;
    }

    /// 更新用户信息
    await updateUserInfo(vm.value.selectRegion);
  }

  /// 更新用户信息
  Future updateUserInfo(RegionPickerSelection? selection) async {
    if (Strings.isEmpty(selection?.district)) return;

    /// 需要落库或回填输入框时可写 vm
    DebugPrint(selection);

    /// request - 更新当前登录用户的信息
    final result = await requestUpdateUserInfo(
      province: selection?.province,
      city: '${selection?.city}' + '/' + '${selection?.district}',
    );
    if (!result) return;

    /// push-首页页面-page
    await pushHomePage();
  }

  /// mark - request
  ///
  /// request - 更新当前登录用户的信息
  Future<bool> requestUpdateUserInfo({
    String? province,
    String? city,
  }) async {
    EasyLoading.show();
    var response = await Net.value<User>().requestUpdateUserInfo(
      province: province,
      city: city,
    );
    EasyLoading.dismiss();
    if (response.success) {
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// mark - 路由
  ///
  /// push-首页页面-page
  Future pushHomePage() async {
    await Get.offAllNamed(Routes.homePage);
  }

  /// 底部弹出省市区选择（加载 assets/data/china_regions.json）
  Future<void> pushRegionPickerPage() async {
    final ctx = Get.context;
    if (ctx == null) return;
    var provinces = await vm.value.cachedProvinces;
    if (Lists.isEmpty(provinces)) return;
    await showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return RegionPickerSheet(
          provinces: provinces!,
          onClose: Get.back,
          onSelectionChanged: (s) async {
            print(s);
            vm.value.selectRegion = s;
            if(Strings.isNotEmpty(vm.value.selectRegion)) {
              Get.back();
            }
          },
        );
      },
    );
  }
}
