import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// FileName flies
///
/// @Author 谌文
/// @Date 2025/2/11 15:13
///
/// @Description 文件扩展类
enum FileType {
  unknown,
  pdf,
  html,
  xml,
  png,
}
extension Files on File {

  /// 判断文件类型
  static FileType fileType(String path) {
    if (path.endsWith("pdf")) return FileType.pdf;
    if (path.endsWith("html")) return FileType.html;
    if (path.endsWith("xml")) return FileType.xml;
    return FileType.unknown;
  }

  /// 获取文件后缀名字
  static String fileName(String path) {
    List list = path.split('/');
    return list.last;
  }

  /// 获取getApplicationDocumentsDirectory。 path路径
  static Future<String> documentsPath() async {
    var directory = await getApplicationDocumentsDirectory();
    final String localPath = directory.path; // 本地路径
    return localPath;
  }

  /// getExternalStorageDirectory。 path路径
  static Future<String> storagePath() async {
    var directory = await getExternalStorageDirectory();
    final String localPath = directory!.path; // 本地路径
    return localPath;
  }
}