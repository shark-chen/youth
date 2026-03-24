import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// FileName: documents
///
/// @Author 谌文
/// @Date 2026/3/4 09:41
///
/// @Description 文件目录
class Documents {
  static final Documents _instance = Documents._();

  factory Documents() => _instance;

  Documents._();

  Directory? _appDocDir;

  /// 获取文件路径
  Future<Directory> get directory async {
    if (_appDocDir == null) {
      _appDocDir = await getApplicationDocumentsDirectory();
    }
    return _appDocDir!;
  }
}
