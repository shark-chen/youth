import '../../../generated/locales.g.dart';
import '../../../utils/stores/stores.dart';
import '../camera_engine/camera_engine.dart';
import 'package:get/get.dart';

import '../mixin/camera_pattern_mixin.dart';

/// FileName sharpness_config
///
/// @Author 谌文
/// @Date 2024/7/5 11:35
///
/// @Description 相机清晰度配置
Map<int, SharpnessModel> sharpnessMap = {
  1: SharpnessModel(
      title: LocaleKeys.standardSharpness.tr,
      preset: ResolutionPreset.high,
      sharpness: 1),
  2: SharpnessModel(
      title: LocaleKeys.highSharpness.tr,
      preset: ResolutionPreset.veryHigh,
      sharpness: 2),
  3: SharpnessModel(
      title: LocaleKeys.superSharpness.tr,
      preset: ResolutionPreset.ultraHigh,
      sharpness: 3),
};

class SharpnessModel {
  SharpnessModel({this.title, this.preset, this.sharpness});

  int? sharpness = 1;

  /// 标题
  String? title = LocaleKeys.standardSharpness.tr;

  /// 清晰度
  ResolutionPreset? preset = ResolutionPreset.high;
}

class SharpnessConfig {
  /// 默认标清
  ResolutionPreset? preset = ResolutionPreset.high;

  /// 是否展示清晰度选项
  var showSharpnessElect = false.obs;

  /// 像素 1: 标清， 2：高清， 3：超清
  var sharpness = 1.obs;

  /// 点击清晰度按钮
  void clickSharpness() {
    showSharpnessElect.value = !showSharpnessElect.value;
  }

  /// 设置清晰度
  Future selectSharpness(int sharpness) async {
    this.sharpness.value = sharpness;
    showSharpnessElect.value = false;
  }

  /// 获取用户清晰度配置
  Future<SharpnessModel?> getUserSharpnessConfig() async {
    try {
      var value = await Stores().get('cameraSharpnessConfig', defaultValue: 1);
      SharpnessModel? sharpnessModel = sharpnessMap[value];
      sharpness.value = sharpnessModel?.sharpness ?? 1;
      preset = sharpnessModel?.preset;
      return sharpnessModel;
    } catch (_) {
      return SharpnessModel();
    }
  }

  /// 设置拍照清晰度
  void setPhotoSharpness(ResolutionPreset? configPreset) {
    if(configPreset == null) return;
    sharpnessMap.forEach((key, value) {
      if (value.preset == configPreset) {
        SharpnessModel? sharpnessModel = sharpnessMap[value];
        sharpness.value = sharpnessModel?.sharpness ?? 1;
        preset = sharpnessModel?.preset;
      }
    });
  }

  /// 如果是用手机原相机拍照，则扫描统一使用ResolutionPreset.high清晰度
  void sharpnessByCameraPattern(CameraPattern cameraPattern) {
    if (cameraPattern == CameraPattern.scanAndPickerPattern) {
      preset = ResolutionPreset.high;
    }
  }

  /// 保存用户设置
  Future saveUserSharpnessConfig(SharpnessModel sharpness) async {
    try {
      preset = sharpness.preset;
      this.sharpness.value = sharpness.sharpness ?? 1;
      await Stores().put('cameraSharpnessConfig', sharpness.sharpness);
    } catch (_) {}
  }
}
