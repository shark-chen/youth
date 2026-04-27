import 'package:kellychat/tripartite_library/documents/documents.dart';
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
  factory Stores() {
    return _instance;
  }

  Stores._();

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
  /// userLat: 是否是用户维度
  Future<HiveStore?> hive({
    bool userLat = true,
  }) async {
    if (userLat != false) return await userLatHive;
    return await deviceLatDive;
  }

  /// 用户维度存储类
  Future<HiveStore?> get userLatHive async {
    try {
      if (UserCenter().user?.id == null) return null;
      return _userLatHive ??= HiveStore(
          (await Documents().directory).path, 'stores',
          identify: UserCenter().user?.id.toString());
    } catch (_) {
      return null;
    } finally {}
  }

  /// 设备维度存储类
  Future<HiveStore?> get deviceLatDive async {
    try {
      return _deviceLatHive ??= HiveStore(
          (await Documents().directory).path, 'deviceStores');
    } catch (_) {
      return null;
    } finally {}
  }

  /// Saves the [key] - [value] pair.
  /// userLat: 是否是用户维度
  Future<void> put<E>(
    dynamic key,
    E value, {
    bool userLat = true,
  }) async {
    try {
      return await (await hive(userLat: userLat))?.put<E>(key, value);
    } catch (_) {
    } finally {}
  }

  /// Returns the value associated with the given [key]. If the key does not
  /// exist, `null` is returned.
  ///
  /// If [defaultValue] is specified, it is returned in case the key does not
  /// exist.
  /// userLat: 是否是用户维度
  Future<E?> get<E>(
    dynamic key, {
    bool userLat = true,
    E? defaultValue,
  }) async {
    try {
      return (await hive(userLat: userLat))
          ?.get<E>(key, defaultValue: defaultValue)
          .timeout(const Duration(seconds: 1));
    } catch (_) {
      return defaultValue;
    } finally {}
  }

  /// Checks whether the box contains the [key].
  /// userLat: 是否是用户维度
  Future<bool> containsKey(
    dynamic key, {
    bool userLat = true,
  }) async {
    try {
      return await (await hive(userLat: userLat))?.containsKey(key) ?? false;
    } catch (_) {
      return false;
    } finally {}
  }

  /// If it does not exist, nothing happens.
  /// userLat: 是否是用户维度
  Future<void> delete(
    dynamic key, {
    bool userLat = true,
  }) async {
    try {
      return await (await hive(userLat: userLat))?.delete(key);
    } catch (_) {
    } finally {}
  }

  /// Removes all entries from the box.
  /// userLat: 是否是用户维度
  Future<int> clear({
    bool userLat = true,
  }) async {
    try {
      return await (await hive(userLat: userLat))?.clear() ?? -1;
    } catch (_) {
      return -1;
    } finally {}
  }

  /// Removes the file which contains the box and closes the box.
  ///
  /// In the browser, the IndexedDB database is being removed.
  /// userLat: 是否是用户维度
  Future<void> deleteFromDisk({
    bool userLat = true,
  }) async {
    try {
      return await (await hive(userLat: userLat))?.deleteFromDisk();
    } catch (_) {
    } finally {}
  }
}
