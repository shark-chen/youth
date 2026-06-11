import 'dart:async';

import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/widget/region_picker/region_picker_data.dart';
import '../model/info_step_one_model.dart';
import '../model/info_step_three_model.dart';
import '../model/info_step_two_model.dart';
import 'profile_setup_check_vm.dart';
export 'profile_setup_check_vm.dart';
export 'profile_setup_one_vm.dart';
export 'profile_setup_two_vm.dart';
import 'profile_setup_two_vm.dart';
export 'profile_setup_three_vm.dart';

/// 完善资料页 UI 状态
class ProfileSetupVM extends BaseVM {
  /// 当前步骤 0..2
  int currentStep = 0;

  /// MARK - 完善基础信息
  ///
  /// 昵称
  InfoStepOneModel stepOne = InfoStepOneModel();

  /// MARK - 完善地区，标签信息
  ///
  InfoStepTwoModel stepTwo = InfoStepTwoModel();
  List<RegionProvince>? cachedProvinces;

  /// MARK - 图片墙， 简介
  ///
  InfoStepThreeModel stepThree = InfoStepThreeModel();

  @override
  void onInit() {
    super.onInit();
    stepOne.nicknameController?.addListener(() => refresh?.call());
    unawaited(loadProvinces());
  }

  @override
  void onClear() {
    super.onClear();
    stepOne.nicknameController?.dispose();
  }

  /// 下一步是否可用
  bool get nextEnable {
    switch (currentStep) {
      case 0:
        return stepOneCheck;
      case 1:
        return stepTwoCheck;
      case 2:
        return stepThreeCheck;
      default:
        return true;
    }
  }
}
