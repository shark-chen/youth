import 'dart:async';
import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/utils/marco/debug_print.dart';
import 'package:youth/widget/region_picker/region_picker_sheet.dart';
import '../sex_select/model/user_info_param.dart';
import 'view_model/city_set_vm.dart';

/// FileName: city_set_controller
///
/// @Author 谌文
/// @Date 2026/3/26 22:29
///
/// @Description 地区设置-controller
class CitySetController extends BaseController {
  /// 构造函数
  CitySetController({UserInfoParam? userInfoParam}) {
    vm.value.userInfoParam = userInfoParam;
    if (userInfoParam == null) {
      vm.value.userInfoParam = UserInfoParam();
    }
  }

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

  /// 点击获取位置
  Future clickGetLocation() async {
    try {
      final location = await LocationUtil.getProvinceCityDistrict();
      vm.value.selectRegion = RegionPickerSelection(
        province: location.province,
        city: location.city,
        district: location.city,
      );
      vm.refresh();
    } catch (e) {
      if (e is LocationUtilException) {
        EasyLoading.showToast(e.message);
      }
    }
  }

  /// 更新用户信息
  Future updateUserInfo(RegionPickerSelection? selection) async {
    if (Strings.isEmpty(selection?.district)) return;

    /// 需要落库或回填输入框时可写 vm
    DebugPrint(selection);

    /// request - 更新当前登录用户的信息
    final result = await requestUpdateUserInfo(
      province: selection?.province,
      city: selection?.city,
      district: selection?.district,
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
    String? district,
  }) async {
    EasyLoading.show();
    var response = await Net.value<User>().requestUpdateUserInfo(
      gender: vm.value.userInfoParam?.gender,
      birthday: vm.value.userInfoParam?.birthday,
      province: province,
      city: city,
      district: district,
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
            if (Strings.isNotEmpty(vm.value.selectRegion?.district)) {
              Get.back();
            }
          },
        );
      },
    );
  }
}
