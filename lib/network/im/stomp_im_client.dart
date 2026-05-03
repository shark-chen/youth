import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:kellychat/config/environment_config/app_config.dart';

import 'im_models.dart';

/// SockJS + STOMP IM 客户端（对齐 `tools/websocket-test.html`）
class StompImClient {
  static final StompImClient _instance = StompImClient._();

  factory StompImClient() => _instance;

  StompImClient._();

  StompClient? _client;
  Timer? _reconnectTimer;
  bool _manualDisconnect = false;
  int _reconnectAttempt = 0;

  String? _lastSockJsUrl;

  final StreamController<ImConnectionState> _stateController =
      StreamController.broadcast();
  final StreamController<ImIncomingMessage> _messageController =
      StreamController.broadcast();
  final StreamController<ImIncomingMessage> _errorController =
      StreamController.broadcast();

  ImConnectionState _state = ImConnectionState.disconnected;

  ImConnectionState get state => _state;

  Stream<ImConnectionState> get stateStream => _stateController.stream;

  /// 订阅：`/user/queue/messages`
  Stream<ImIncomingMessage> get messageStream => _messageController.stream;

  /// 订阅：`/user/queue/errors`
  Stream<ImIncomingMessage> get errorStream => _errorController.stream;

  bool get isConnected => _state == ImConnectionState.connected;

  Future<void> connect({
    required String token,
    String tokenKey = 'token',
    String? path,
    Map<String, String>? extraQuery,
  }) async {
    final sockJsUrl = AppConfig.buildImSockJsUrl(
      token: token,
      tokenKey: tokenKey,
      path: path,
      extraQuery: extraQuery,
    );
    return connectSockJsUrl(sockJsUrl);
  }

  Future<void> connectSockJsUrl(String sockJsUrl) async {
    _manualDisconnect = false;
    _lastSockJsUrl = sockJsUrl;
    _cancelReconnect();
    _setState(ImConnectionState.connecting);

    _client = StompClient(
      config: StompConfig.sockJS(
        url: sockJsUrl,
        onConnect: _onConnect,
        onWebSocketError: (dynamic err) {
          print(err);
          _handleDown();
        },
        onStompError: (StompFrame frame) {
          print(frame);
          _errorController.add(ImIncomingMessage(frame.body));
        },
        onDisconnect: (StompFrame frame) {
          print(frame);
          _handleDown();
        },
        onDebugMessage: (String msg) {
          print(msg);
          // 可按需接入 DebugPrint；此处保持静默避免噪音
        },
      ),
    );

    _client?.activate();
  }

  Future<void> disconnect() async {
    _manualDisconnect = true;
    _cancelReconnect();
    try {
      _client?.deactivate();
    } catch (e) {
      print(e);
    }
    _client = null;
    _setState(ImConnectionState.disconnected);
  }

  /// 发送消息（对齐 `stompClient.send("/app/chat.send", ...)`）
  Future<void> sendChatMessage({
    required int toUserId,
    required int contentType,
    required String content,
  }) async {
    final client = _client;
    if (client == null || !isConnected) {
      throw StateError('IM 未连接');
    }
    final body = jsonEncode({
      'toUserId': toUserId,
      'contentType': contentType,
      'content': content,
    });
    client.send(destination: '/app/chat.send', body: body);
  }

  void _onConnect(StompFrame frame) {
    _reconnectAttempt = 0;
    _setState(ImConnectionState.connected);

    // 订阅私信队列：/user/queue/messages
    _client?.subscribe(
      destination: '/user/queue/messages',
      callback: (StompFrame f) {
        _messageController.add(ImIncomingMessage(f.body));
      },
    );

    // 订阅错误队列：/user/queue/errors
    _client?.subscribe(
      destination: '/user/queue/errors',
      callback: (StompFrame f) {
        _errorController.add(ImIncomingMessage(f.body));
      },
    );
  }

  void _handleDown() {
    if (_manualDisconnect) {
      _setState(ImConnectionState.disconnected);
      return;
    }
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    final url = _lastSockJsUrl;
    if (url == null) {
      _setState(ImConnectionState.disconnected);
      return;
    }

    _reconnectAttempt += 1;
    _setState(ImConnectionState.reconnecting);

    final delay = _computeBackoffDelay(_reconnectAttempt);
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () async {
      if (_manualDisconnect) return;
      await connectSockJsUrl(url);
    });
  }

  void _cancelReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  Duration _computeBackoffDelay(int attempt) {
    final seconds = 1 << (attempt - 1);
    final capped = seconds.clamp(1, 30);
    return Duration(seconds: capped);
  }

  void _setState(ImConnectionState s) {
    _state = s;
    _stateController.add(s);
  }
}

