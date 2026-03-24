/// FileName store
///
/// @Author 谌文
/// @Date 2024/4/23 11:18
///
/// @Description 缓存接口类
abstract class Store {
  /// Checks whether the box contains the [key].
  Future<bool> containsKey(dynamic key);

  /// Returns the value associated with the given [key]. If the key does not
  /// exist, `null` is returned.
  ///
  /// If [defaultValue] is specified, it is returned in case the key does not
  /// exist.
  Future<E?> get<E>(dynamic key, {E? defaultValue});

  /// Saves the [key] - [value] pair.
  Future<void> put<E>(dynamic key, E value);

  /// If it does not exist, nothing happens.
  Future<void> delete(dynamic key);

  /// Removes all entries from the box.
  Future<int> clear();

  Future<void> deleteFromDisk();
}
