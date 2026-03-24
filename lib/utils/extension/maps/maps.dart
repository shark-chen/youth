/// FileName maps
///
/// @Author 谌文
/// @Date 2025/2/11 15:18
///
/// @Description MAP扩展类
extension Maps on Map {
  /// 判断数组是否为空
  static bool isEmpty(dynamic objc) {
    if(objc != null && objc is Map && objc.isNotEmpty) {
      return false;
    }
    return true;
  }

  /// 判断字典是否为不为空
  static bool isNotEmpty(dynamic objc) {
    return !Maps.isEmpty(objc);
  }

  /// 深拷贝字典
  static Map deepCopy(Map original) {
    Map copy = {};
    original.forEach((key, value) {
      if (value is Map) {
        copy[key] = deepCopy(value);
      } else if (value is List) {
        copy[key] = value.map((item) {
          if (item is Map) {
            return deepCopy(item);
          } else {
            return item;
          }
        }).toList();
      } else {
        copy[key] = value;
      }
    });
    return copy;
  }
}