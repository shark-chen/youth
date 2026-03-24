import '../../../../tripartite_library/store/preferences.dart';
import '../../../../utils/stores/stores.dart';
import '../user_mixin/user_mixin.dart';

/// FileName user_options
///
/// @Author 谌文
/// @Date 2023/12/1 09:26
///
/// @Description 存在本地的一些用户配置
class UserOptions extends BaseUser {
  static final UserOptions _instance = UserOptions._();

  factory UserOptions() => _instance;

  /// 拍照是否使用原生相机
  bool? nativeCameraOpen;

  /// 相机扫描间隔时间 - 复默认扫描间隔时间：1秒
  double scanTimeInterval = 1.0;

  UserOptions._();

  @override
  Future init() async {
    /// 提前加载配置
    await isCameraScan;
    nativeCamera;
    isShowPickingCar;
    getWaveSmallScreen;

    /// 加载上次保存的时间间隔
    await loadScanTimeInterval();
    succeed = true;
  }

  /// 是否设置为相机扫描
  bool? isCamera;

  /// 是否展示拣货车编码
  bool? showPickingCar;

  /// 是否展示拣货车编码
  Future<bool> get isShowPickingCar async {
    showPickingCar ??= (await Preferences()
            .getBool(UserConfigEnum.isShowPickingCar, userLat: true)) ??
        true;
    return showPickingCar ?? false;
  }

  /// 设置是否展示拣货车编码
  Future setShowPickingCar(bool open) async {
    showPickingCar = open;
    return await Preferences()
        .setBool(UserConfigEnum.isShowPickingCar, open, userLat: true);
  }

  /// 波次拣货是否是小屏模式
  bool? isWaveSmallScreen;

  /// 是否是小屏模式
  Future<bool> get getWaveSmallScreen async {
    isWaveSmallScreen ??= (await Stores()
            .get<bool>(UserConfigEnum.isWavePickSmallScreen.toString())) ??
        true;
    return isWaveSmallScreen ?? false;
  }

  /// 设置是否是小屏模式
  Future setWaveSmallScreen(bool open) async {
    isWaveSmallScreen = open;
    return await Stores()
        .put(UserConfigEnum.isWavePickSmallScreen.toString(), open);
  }
}

/// 相机设置
extension UserCameraOptions on UserOptions {
  /// 是否是相机扫描
  Future<bool> get isCameraScan async {
    isCamera ??= ((await Preferences()
            .getBool(UserConfigEnum.cameraOrPdaScanOpenKey, userLat: false)) ??
        true);
    return isCamera ?? true;
  }

  /// 设置是否是相机扫描
  Future cameraScan(bool enable) async {
    isCamera = enable;
    return await Preferences()
        .setBool(UserConfigEnum.cameraOrPdaScanOpenKey, enable, userLat: false);
  }

  /// 拍照是否使用原生相机
  Future<bool> get nativeCamera async {
    return nativeCameraOpen ??= await getCameraWay();
  }

  /// 获取用户清晰度配置
  Future<bool> getCameraWay() async {
    try {
      var value =
          await Stores().get<bool>('nativeCameraOpen', defaultValue: false);
      nativeCameraOpen = value;
      return value ?? false;
    } catch (_) {
      return false;
    }
  }

  /// 保存用户设置
  Future saveCameraWay(bool open) async {
    try {
      nativeCameraOpen = open;
      await Stores().put('nativeCameraOpen', open);
    } catch (_) {}
  }

  /// MARK- 扫描间隔
  ///
  /// 加载上次保存的时间间隔
  Future loadScanTimeInterval() async {
    try {
      final result = (await Stores()
          .get<double>(UserConfigEnum.scanTimeInterval.toString()));
      if (result != null) {
        scanTimeInterval = result;
      }
    } catch (_) {}
    return scanTimeInterval;
  }

  /// 保存的时间间隔
  Future saveScanTimeInterval(double timeInterval) async {
    try {
      scanTimeInterval = timeInterval;
      await Stores().put<double>(
          UserConfigEnum.scanTimeInterval.toString(), timeInterval);
    } catch (_) {}
  }
}
