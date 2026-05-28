import 'package:path_provider/path_provider.dart';
import '../../modules/user/user_center/user_center.dart';
import '../../tripartite_library/store/hive/hive_store.dart';

/// FileName store
///
/// @Author 谌文
/// @Date 2024/6/26 19:43
///
/// @Description 存储类
class Stores {
  static final Stores _instance = Stores._();

  /// userLat: 是否是用户维度
  factory Stores({bool userLat = true}) {
    _instance._userLat = userLat;
    return _instance;
  }

  Stores._();

  /// 是否是用户维度
  bool _userLat = true;

  /// 用户维度
  HiveStore? _userLatHive;

  Future init() async => await userLatHive;

  /// 设备维度
  HiveStore? _deviceLatHive;

  Future initDeviceLat() async => await deviceLatDive;

  /// 销毁
  void dispose() async {
    _userLatHive = null;
  }

  /// 存储类
  Future<HiveStore?> get hive async {
    if (_userLat) return await userLatHive;
    return await deviceLatDive;
  }

  /// 用户维度存储类
  Future<HiveStore?> get userLatHive async {
    try {
      if (UserCenter().user?.id == null) return null;
      return _userLatHive ??= HiveStore(
          (await getApplicationDocumentsDirectory()).path, 'stores',
          identify: UserCenter().user?.id.toString());
    } catch (_) {
      return null;
    } finally {}
  }

  /// 设备维度存储类
  Future<HiveStore?> get deviceLatDive async {
    try {
      return _deviceLatHive ??= HiveStore(
          (await getApplicationDocumentsDirectory()).path, 'deviceStores');
    } catch (_) {
      return null;
    } finally {}
  }

  /// Checks whether the box contains the [key].
  Future<bool> containsKey(dynamic key) async {
    try {
      return await (await hive)?.containsKey(key) ?? false;
    } catch (_) {
      return false;
    } finally {}
  }

  /// Saves the [key] - [value] pair.
  Future<void> put<E>(dynamic key, E value) async {
    try {
      return await (await hive)?.put<E>(key, value);
    } catch (_) {
    } finally {}
  }

  /// If it does not exist, nothing happens.
  Future<void> delete(dynamic key) async {
    try {
      return await (await hive)?.delete(key);
    } catch (_) {
    } finally {}
  }

  /// Removes all entries from the box.
  Future<int> clear() async {
    try {
      return await (await hive)?.clear() ?? -1;
    } catch (_) {
      return -1;
    } finally {}
  }

  /// Removes the file which contains the box and closes the box.
  ///
  /// In the browser, the IndexedDB database is being removed.
  Future<void> deleteFromDisk() async {
    try {
      return await (await hive)?.deleteFromDisk();
    } catch (_) {
    } finally {}
  }

  Future<E?> get<E>(dynamic key, {E? defaultValue}) async {
    try {
      return (await hive)?.get<E>(key, defaultValue: defaultValue).timeout(
        const Duration(seconds: 1),
      );
    } catch (_) {
      return defaultValue;
    } finally {}
  }
}