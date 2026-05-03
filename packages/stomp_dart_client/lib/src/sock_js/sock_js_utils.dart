import 'dart:math';

class SockJsUtils {
  static final SockJsUtils _instance = SockJsUtils._internal();

  factory SockJsUtils() => _instance;

  SockJsUtils._internal(); // private constructor

  final Random _random = Random();

  /// 生成 SockJS WebSocket 传输层 URL（`ws` / `wss`）。
  ///
  /// 不在此处使用 `Uri(..., port: uri.port, pathSegments: ...).toString()`：
  /// 部分 Flutter / dart:io 会把隐式 443/80 错误序列化为 `:0`，进而导致
  /// `WebSocketException: ... :0/... was not upgraded to websocket`。
  String generateTransportUrl(String url) {
    final uri = Uri.parse(url);

    if (uri.scheme != 'http' && uri.scheme != 'https') {
      throw ArgumentError('The url has to start with http/https');
    }

    final pathSegments = <String>[
      ...uri.pathSegments.where((s) => s.isNotEmpty),
      _generateServerId(),
      _generateSessionId(),
      'websocket',
    ];

    final wsScheme = uri.scheme == 'https' ? 'wss' : 'ws';
    final buf = StringBuffer()
      ..write(wsScheme)
      ..write('://');
    if (uri.userInfo.isNotEmpty) {
      buf.write(uri.userInfo);
      buf.write('@');
    }
    final host = uri.host;
    if (host.contains(':')) {
      buf.write('[$host]');
    } else {
      buf.write(host);
    }
    if (uri.hasPort && uri.port != 0) {
      buf.write(':');
      buf.write(uri.port);
    }
    buf.write('/');
    buf.write(pathSegments.join('/'));
    if (uri.query.isNotEmpty) {
      buf.write('?');
      buf.write(uri.query);
    }
    return buf.toString();
  }

  String _generateServerId() {
    return _random.nextInt(1000).toString().padLeft(3, '0');
  }

  String _generateSessionId() {
    var sessionId = '';
    var randomStringChars = 'abcdefghijklmnopqrstuvwxyz012345';
    var max = randomStringChars.length;
    for (var i = 0; i < 8; i++) {
      sessionId += randomStringChars[_random.nextInt(max)].toString();
    }
    return sessionId;
  }
}
