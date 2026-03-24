import 'package:youth/tripartite_library/documents/documents.dart';
import '../../../../tripartite_library/store/hive/hive_store.dart';

/// FileName user_id_store
///
/// @Author 谌文
/// @Date 2024/12/31 13:56
///
/// @Description
class UserIdStores {
  static final UserIdStores _instance = UserIdStores._();

  factory UserIdStores() => _instance;

  UserIdStores._();

  HiveStore? _hive;

  init() => hive;

  /// 销毁
  void dispose() async {
    _hive = null;
  }

  /// 存储类
  Future<HiveStore> get hive async {
    try {
      return _hive ??= HiveStore(
          (await Documents().directory).path, 'stores',
          identify: 'user_id');
    } catch (_) {
      return HiveStore('', '');
    }
  }

  /// Checks whether the box contains the [key].
  Future<bool> containsKey(dynamic key) async {
    try {
      return await (await hive).containsKey(key);
    } catch (_) {
      return false;
    }
  }

  /// Saves the [key] - [value] pair.
  Future<void> put<E>(dynamic key, E value) async {
    try {
      return await (await hive).put<E>(key, value);
    } catch (_) {}
  }

  /// If it does not exist, nothing happens.
  Future<void> delete(dynamic key) async {
    try {
      return await (await hive).delete(key);
    } catch (_) {}
  }

  /// Removes all entries from the box.
  Future<int> clear() async {
    try {
      return await (await hive).clear();
    } catch (_) {
      return -1;
    }
  }

  /// Removes the file which contains the box and closes the box.
  ///
  /// In the browser, the IndexedDB database is being removed.
  Future<void> deleteFromDisk() async {
    try {
      return await (await hive).deleteFromDisk();
    } catch (_) {}
  }

  Future<E?> get<E>(dynamic key, {E? defaultValue}) async {
    try {
      return (await hive).get(key, defaultValue: defaultValue);
    } catch (_) {
      return defaultValue;
    }
  }
}