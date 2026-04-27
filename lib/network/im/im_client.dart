@Deprecated('后端测试代码为 SockJS+STOMP，请使用 StompImClient')
class ImClient {
  static final ImClient _instance = ImClient._();
  factory ImClient() => _instance;
  ImClient._();
}

