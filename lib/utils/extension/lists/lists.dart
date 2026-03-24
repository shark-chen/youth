/// FileName lists
///
/// @Author 谌文
/// @Date 2025/2/11 15:07
///
/// @Description lists
extension Lists<T> on List<T> {
  /// 判断数组是否为空
  static bool isEmpty(dynamic objc) {
    if (objc != null && objc is List && objc.isNotEmpty) {
      return false;
    }
    return true;
  }

  /// 判断数组是否为不为空
  static bool isNotEmpty(dynamic objc) {
    return !Lists.isEmpty(objc);
  }

  /// 使用深度比较来比较两个数组是否相同
  static bool arraysEqual(List<dynamic>? array1, List<dynamic>? array2) {
    if (array1 == null || array2 == null) {
      return false;
    }

    if (array1.length != array2.length) {
      return false;
    }

    for (int i = 0; i < array1.length; i++) {
      if (array1[i] is List && array2[i] is List) {
        if (!arraysEqual(array1[i], array2[i])) {
          return false;
        }
      } else if (array1[i] != array2[i]) {
        return false;
      }
    }
    return true;
  }

  /// 忽略大小写比较字符串
  bool equalIgnoreCase(String str) {
    return any((value) {
      if (value is String) {
        return value.toLowerCase() == str.toLowerCase();
      }
      return false;
    });
  }

  /// 将列表按指定大小分组
  List<List<T>> groupBy(int groupSize) {
    List<List<T>> groups = [];
    for (int i = 0; i < length; i += groupSize) {
      int end = (i + groupSize < length) ? i + groupSize : length;
      groups.add(sublist(i, end));
    }
    return groups;
  }
}
