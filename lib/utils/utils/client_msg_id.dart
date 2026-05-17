import 'package:uuid/uuid.dart';

/// 生成 IM 发送用的客户端消息 ID（后端原样回传用于乐观 UI 匹配）
String newClientMsgId() => const Uuid().v4();
