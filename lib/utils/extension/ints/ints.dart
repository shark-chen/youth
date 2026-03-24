/// FileName ints
///
/// @Author 谌文
/// @Date 2025/2/13 19:11
///
/// @Description ints工具类
extension Ints on int {
  static int value(String? value) {
    return int.tryParse(value ?? '0') ?? 0;
  }
}

extension NumberExtensions on num {
  int floorTo(int multiple) {
    return (this / multiple).floor() * multiple;
  }
}