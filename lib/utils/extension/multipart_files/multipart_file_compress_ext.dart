import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kellychat/utils/image/image_deal.dart';
import 'package:kellychat/utils/marco/debug_print.dart';

/// [MultipartFile] 图片上传扩展：支持按 MB 上限压缩后构造 multipart
extension MultipartFiles on MultipartFile {
  /// 从本地文件创建 [MultipartFile]。
  ///
  /// [maxSizeMb] 大于 0 时先压缩到不超过该大小（MB）；未传或 ≤0 则不压缩。
  static Future<MultipartFile> fromFileWithMaxMb(
    String filePath, {
    double? maxSizeMb,
    String? filename,
    MediaType? contentType,
  }) async {
    final originBytes = await _fileLength(filePath);
    var uploadPath = filePath;
    final maxBytes = maxSizeMb != null && maxSizeMb > 0
        ? (maxSizeMb * 1024 * 1024).round()
        : null;

    if (maxBytes != null) {
      uploadPath = await ImageDeal().compressFileUnderMaxBytes(
        filePath,
        maxBytes: maxBytes,
      );
    }

    final uploadBytes = await _fileLength(uploadPath);
    final stillOverLimit =
        maxBytes != null && uploadBytes > maxBytes;
    DebugPrint(
      '[MultipartFiles] fromFileWithMaxMb\n'
      '  原文件: $filePath (${_formatBytes(originBytes)})\n'
      '  上传文件: $uploadPath (${_formatBytes(uploadBytes)})\n'
      '  上限: ${maxSizeMb ?? 0} MB'
      '${maxBytes != null ? ' (${_formatBytes(maxBytes)})\n' : '\n'}'
      '  是否压缩: ${uploadPath != filePath}\n'
      '  是否仍超限: $stillOverLimit',
    );
    if (stillOverLimit) {
      DebugPrint(
        '[MultipartFiles] 警告: 压缩后仍超过上限，可能触发网关 413，'
        '请降低 AppConfig.uploadImageMaxSizeMb 或调大网关 client_max_body_size',
      );
    }

    final name = filename ?? _basename(uploadPath);
    return MultipartFile.fromFile(
      uploadPath,
      filename: name,
      contentType: contentType ?? _defaultImageMediaType(name, uploadPath),
    );
  }
}

String _basename(String path) {
  final i = path.lastIndexOf('/');
  return i >= 0 ? path.substring(i + 1) : path;
}

String _imageMimeSubtype(String filename, String path) {
  final name = filename.contains('.') ? filename : path;
  final ext = name.split('.').last.toLowerCase();
  if (ext == 'jpg') return 'jpeg';
  if (ext.isEmpty) return 'jpeg';
  return ext;
}

MediaType _defaultImageMediaType(String filename, String path) {
  return MediaType('image', _imageMimeSubtype(filename, path));
}

Future<int> _fileLength(String path) async {
  final file = File(path);
  if (!await file.exists()) return 0;
  return file.length();
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) {
    return '${(bytes / 1024).toStringAsFixed(2)} KB ($bytes B)';
  }
  return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB ($bytes B)';
}
