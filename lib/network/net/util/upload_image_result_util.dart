import 'package:kellychat/modules/home/mine/edit_mine_info/model/image_links_entity.dart';
import 'package:kellychat/network/net/net_result.dart';
import 'package:kellychat/utils/marco/debug_print.dart';

/// 解析上传图片接口返回（兼容 code 0/200、data 为对象或 URL 字符串）
class UploadImageResultUtil {
  UploadImageResultUtil._();

  /// 上传是否业务成功
  static bool isBusinessOk(NetResult<ImageLinksEntity> response) {
    final code = response.code;
    return code == 200 || code == 0;
  }

  /// 从 [NetResult] 解析图片 URL；失败返回 null 并打印调试信息
  static ImageLinksEntity? parse(NetResult<ImageLinksEntity> response) {
    DebugPrint(
      '[UploadImage] 响应 code=${response.code} msg=${response.msg ?? response.message} '
      'succeed=${response.succeed} dataType=${response.data.runtimeType} '
      'value.url=${response.value?.url}',
    );

    if (!isBusinessOk(response)) {
      DebugPrint('[UploadImage] 业务失败: ${response.msg ?? response.message}');
      return null;
    }

    final fromValue = response.value;
    if (fromValue?.url?.isNotEmpty == true) {
      return fromValue;
    }

    final raw = response.data;
    if (raw is String) {
      final url = (raw as String).trim();
      if (url.isNotEmpty) {
        DebugPrint('[UploadImage] data 为字符串 URL，已适配');
        return ImageLinksEntity()..url = url;
      }
    }
    if (raw is Map) {
      final entity = ImageLinksEntity.fromJson(raw);
      if (entity.url?.isNotEmpty == true) {
        return entity;
      }
    }

    DebugPrint('[UploadImage] 业务 code 成功但未解析到 url，原始 data=$raw');
    return null;
  }

  static String failureMessage(NetResult<ImageLinksEntity> response) {
    final msg = response.msg ?? response.message;
    if (msg != null && msg.isNotEmpty) return msg;
    if (!isBusinessOk(response)) return '上传失败';
    return '上传失败：未返回图片地址';
  }
}
