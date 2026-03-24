import 'package:hive/hive.dart';
import '../store.dart';

/// FileName hive_store
///
/// @Author 谌文
/// @Date 2024/4/22 21:12
///
/// @Description Hive本地缓存类
class HiveStore implements Store {
  /// Initialize Hive by giving it a home directory.
  /// _path: 数据存储位置
  /// _name: 数据库名称
  /// identify: 分区：如不同账户
  HiveStore(this._path, this._name, {String? identify = ''}) {
    try {
      Hive.init(_path);
      _identify = identify;
      Hive.openBox('BigSeller$_name$identify').then((value) => _box = value);
    } catch (_) {
    } finally {}
  }

  final String? _path;
  final String? _name;
  String? _identify;
  Box? _box;

  Future<Box?> get box async {
    try {
      if (_box != null) return _box;
      _box = await Hive.openBox('BigSeller$_name$_identify');
      return _box;
    } catch (_) {
      return null;
    } finally {}
  }

  /// Checks whether the box contains the [key].
  @override
  Future<bool> containsKey(dynamic key) async {
    try {
      return (await box)?.containsKey(key) ?? false;
    } catch (_) {
      return false;
    } finally {}
  }

  /// Saves the [key] - [value] pair.
  @override
  Future<void> put<E>(dynamic key, E value) async {
    try {
      return await (await box)?.put(key, value);
    } catch (_) {
      return null;
    } finally {}
  }

  /// If it does not exist, nothing happens.
  @override
  Future<void> delete(dynamic key) async {
    try {
      return await (await box)?.delete(key);
    } catch (_) {
      return null;
    } finally {}
  }

  /// Removes all entries from the box.
  @override
  Future<int> clear() async {
    try {
      return await (await box)?.clear() ?? 0;
    } catch (_) {
      return 0;
    } finally {}
  }

  /// Removes the file which contains the box and closes the box.
  ///
  /// In the browser, the IndexedDB database is being removed.
  @override
  Future<void> deleteFromDisk() async {
    try {
      return await (await box)?.deleteFromDisk();
    } catch (_) {
      return null;
    } finally {}
  }

  @override
  Future<E?> get<E>(dynamic key, {E? defaultValue}) async {
    try {
      return (await box)?.get(key, defaultValue: defaultValue);
    } catch (_) {
      return null;
    } finally {}
  }
}
