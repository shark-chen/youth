/// FileName iterables
///
/// @Author 谌文
/// @Date 2025/7/8 10:02
///
/// @Description 遍历器
extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}