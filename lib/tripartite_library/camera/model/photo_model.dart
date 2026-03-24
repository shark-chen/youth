import 'dart:ui' as ui;
import 'dart:ui';
import '../../../utils/image/image_deal.dart';
import '../../image_compress/image_compress.dart';
import '../cameras.dart';
import 'package:dio/dio.dart' as dio;

/// FileName photo_model
///
/// @Author 谌文
/// @Date 2024/3/12 13:23
///
/// @Description 图片资源
class PhotoModel {
  PhotoModel({this.file, this.image});

  /// 图片image
  ui.Image? image;

  CameraImage? cameraImage;

  /// 拍照获取到的资源
  XFile? file;

  /// 上传图片的资源
  dio.MultipartFile? _multipartFile;

  dio.MultipartFile? get multipartFile => _multipartFile;

  /// 是否已经上传保存过图
  bool saveEd = false;

  /// 是否是空资源
  bool isEmptyResource() {
    if (image == null && file == null) {
      return true;
    }
    return false;
  }

  /// 获取图片资源地址
  String get getPath {
    return file?.path ?? '';
  }

  /// 生成上传图片资源
  Future<dio.MultipartFile?> generateMultipartFile() async {
    if (_multipartFile != null) return _multipartFile;
    if (image != null) {
      image?.toByteData(format: ImageByteFormat.png).then((byteData) {
        ImageDeal().compressImage(byteData).then((imageData) {
          Stream<List<int>> stream =
              Stream.value(imageData?.uint8List?.toList() ?? []);
          _multipartFile = dio.MultipartFile(
              stream, imageData?.byteData?.lengthInBytes ?? 0,
              filename: 'senderPhoto.jpg');
        });
      });
    } else {
      /// 图片压缩
      imageCompress(file).then((value) async {
        String? fileName = file?.path.split('/').last;
        dio.MultipartFile.fromFile(file?.path ?? '', filename: fileName)
            .then((value) => _multipartFile = value);
      });
    }
    return _multipartFile;
  }

  /// 生成上传图片资源
  Future<dio.MultipartFile?> syncGenerateMultipartFile() async {
    if (_multipartFile != null) return _multipartFile;
    if (image != null) {
      final byteData = await image?.toByteData(format: ImageByteFormat.png);
      ImageByteData? imageData = await ImageDeal().compressImage(byteData);
      Stream<List<int>> stream =
          Stream.value(imageData?.uint8List?.toList() ?? []);
      _multipartFile = dio.MultipartFile(
          stream, imageData?.byteData?.lengthInBytes ?? 0,
          filename: 'senderPhoto.jpg');
    } else {
      /// 图片压缩
      await imageCompress(file);
      String? fileName = file?.path.split('/').last;
      _multipartFile = await dio.MultipartFile.fromFile(file?.path ?? '',
          filename: fileName);
    }
    return _multipartFile;
  }

  /// 重新生成
  void reGenerateMultipartFile() {
    _multipartFile = null;
    generateMultipartFile();
  }

  void clearMultipartFile() {
    _multipartFile = null;
  }

  /// 图片压缩到5M以内
  Future imageCompress(XFile? _file) async {
    int targetSizeInBytes = 6 * 1024 * 1024;
    if (targetSizeInBytes < ((await file?.length()) ?? 0)) {
      file = await ImageCompress.compressImage(file, targetSizeInBytes);
    }
    return file;
  }
}
