import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'stream_speed_assist.dart';
export 'stream_speed_assist.dart';

/// 下载工具类
class Downloader {
  /// 用于记录正在下载的url，避免重复下载
  static var downloadingUrls = <String, CancelToken>{};

  /// 计算网速工具
  static var downloadAssist = StreamSpeedAssist();
  static Dio? _dio;

  /// 初始化dio
  static Future<Dio> get dio async {
    if (_dio == null) {
      _dio = Dio();
      _dio?.options.connectTimeout = Duration(microseconds: 60 * 1000 * 60000);
      _dio?.options.headers['systemType'] = GetPlatform.isIOS ? 2 : 1;
    }
    return _dio!;
  }

  /// 普通方式下载
  static Future download(
    String url,
    String savePath, {
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function()? onError,
  }) async {
    try {
      return await (await dio).download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (_) {
      onError?.call();
    } on Exception catch (_) {
      onError?.call();
    }
  }

  /// 断点下载大文件(流方式下载)
  static Future<void> streamDownload({
    required String url,
    required String savePath,
    void Function(int, int, {StreamSpeedAssist speedAssist})? onReceiveProgress,
    void Function()? done,
    void Function(DioError?)? failed,
  }) async {
    int downloadStart = 0;
    bool fileExists = false;
    File f = File(savePath);
    if (await f.exists()) {
      downloadStart = f.lengthSync();
      fileExists = true;
      downloadAssist.currentLength = downloadStart;
      downloadAssist.lastCurrentLength = downloadAssist.currentLength;
    } else {
      downloadAssist.currentLength = 0;
      downloadAssist.lastCurrentLength = downloadAssist.currentLength;
    }
    if (fileExists && downloadingUrls.containsKey(url)) {
      return;
    }
    CancelToken cancelToken = CancelToken();
    downloadingUrls[url] = cancelToken;
    try {
      var response = await (await dio).get<ResponseBody>(
        url,
        options: Options(
          // 以流的方式接收响应数据
          responseType: ResponseType.stream,
          headers: {
            // 分段下载重点位置
            "range": "bytes=$downloadStart-",
          },
        ),
      );
      File file = File(savePath);
      RandomAccessFile raf = file.openSync(mode: FileMode.append);
      int received = downloadStart;
      int total = await _getContentLength(response);
      downloadAssist.maxLength = total;
      Stream<Uint8List> stream = response.data!.stream;
      StreamSubscription<Uint8List>? subscription;
      subscription = stream.listen(
        (data) {
          /// 写入文件必须同步
          raf.writeFromSync(data);
          received += data.length;
          downloadAssist.currentLength = received;
          onReceiveProgress?.call(received, total, speedAssist: downloadAssist);
        },
        onDone: () async {
          downloadingUrls.remove(url);
          await raf.close();
          done?.call();
        },
        onError: (e) async {
          await raf.close();
          downloadingUrls.remove(url);
          failed?.call(null);
        },
        cancelOnError: true,
      );
      cancelToken.whenCancel.then((_) async {
        await subscription?.cancel();
        await raf.close();
      });
    } on DioError catch (error) {
      // 请求已发出，服务器用状态代码响应它不在200的范围内
      if (CancelToken.isCancel(error)) {
      } else {
        failed?.call(error);
      }
      downloadingUrls.remove(url);
    }
  }

  /// 获取下载的文件大小
  static Future<int> _getContentLength(Response<ResponseBody> response) async {
    try {
      var headerContent =
          response.headers.value(HttpHeaders.contentRangeHeader);
      if (headerContent != null) {
        return int.tryParse(headerContent.split('/').last) ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  /// 取消任务
  static void cancelDownload(String url) {
    downloadingUrls[url]?.cancel();
    downloadingUrls.remove(url);
  }
}
