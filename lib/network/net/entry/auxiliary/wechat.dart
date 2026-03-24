import 'dart:convert';
import '../../net_mixin.dart';
import '../../net_result.dart';
export '../../net.dart';

/// FileName wechat
///
/// @Author 谌文
/// @Date 2024/8/5 16:38
///
/// @Description 企微
String wechatKey = 'b96db0a9-7285-46ad-aed8-8bb3e3ed1ed4';

/// APP-测试环境接口数据群
String apiDataKey = 'b2fdf3a1-8ecb-436c-97df-58b9ae89c1db';

/// 代码异常监控
String codeExceptionKey = 'de872473-d5c4-4f85-9442-9d8b15d37594';

/// 打印机监控群
String posPrintExceptionKey = '0ef716af-d877-4272-a95e-ad8255dd9413';

class Wechat extends NetMixin<Wechat> {
  Wechat();

  factory Wechat.init() => Wechat();

  /// NetMixin
  /// 基础地址
  @override
  String? baseUrl = 'https://qyapi.weixin.qq.com';

  /// 发送文本消息
  Future<NetResult<T>> requestSendText<T>({String? msg}) async {
    final data = {
      'msgtype': 'text',
      'text': {'content': msg}
    };
    var params = {'key': wechatKey};
    return await post<T>('/cgi-bin/webhook/send', params: params, data: data);
  }

  /// 获取上传文件标识符
  Future<NetResult<T>> requestUploadMedia<T>({
    data,
  }) async {
    var params = {
      'key': wechatKey,
      'type': 'file',
    };
    return await post<T>('/cgi-bin/webhook/upload_media',
        params: params, data: data);
  }

  /// 发送文件
  Future<NetResult<T>> requestUploadFile<T>({String? mediaId}) async {
    final message = {
      'msgtype': 'file',
      'file': {'media_id': mediaId},
    };
    var params = {'key': wechatKey};
    return await post<T>('/cgi-bin/webhook/send',
        params: params, data: jsonEncode(message));
  }

  /// 发送测试环境接口数据到  - APP-测试环境接口数据群
  Future<NetResult<T>> requestSendDeBugApiData<T>({String? msg}) async {
    final data = {
      'msgtype': 'text',
      'text': {'content': msg}
    };
    var params = {'key': apiDataKey};
    return await post<T>('/cgi-bin/webhook/send', params: params, data: data);
  }

  /// 发送 截图到 数据到  - APP-测试环境接口数据群
  Future<NetResult<T>> requestSendScreenshot<T>({
    String? base64,
    String? md5,
  }) async {
    final message = {
      'msgtype': 'image',
      'image': {'base64': base64, 'md5': md5},
    };
    var params = {'key': apiDataKey};
    return await post<T>('/cgi-bin/webhook/send',
        params: params, data: jsonEncode(message));
  }

  /// Request -发送APP代码异常监控
  Future<NetResult<T>> requestCodeExceptionData<T>({String? msg}) async {
    final data = {
      'msgtype': 'text',
      'text': {'content': msg}
    };
    var params = {'key': codeExceptionKey};
    return await post<T>('/cgi-bin/webhook/send', params: params, data: data);
  }

  /// Request -发送 打印机监控群
  Future<NetResult<T>> requestPosPrintExceptionData<T>({String? msg}) async {
    final data = {
      'msgtype': 'text',
      'text': {'content': msg}
    };
    var params = {'key': posPrintExceptionKey};
    return await post<T>('/cgi-bin/webhook/send', params: params, data: data);
  }
}
