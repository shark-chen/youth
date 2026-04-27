import 'package:kellychat/config/environment_config/config.dart';
import 'package:kellychat/network/net/entry/auxiliary/wechat.dart';
import 'auxiliary/auxiliary.dart';
import 'doing/doing.dart';
import 'message/message.dart';
import 'user/user.dart';

/// FileName net_entry
///
/// @Author 谌文
/// @Date 2024/4/30 10:16
///
/// @Description 具体请求类合集
/// 构造方法
T createNet<T>() {
  if ((environment != Environment.prod)) {
    netEntryMap[(Wechat).toString()] = Wechat.init;
  }
  return (netEntryMap[T.toString()]() as T);
}

/// 实现了NetMixin的请求类
late final Map<String, dynamic> netEntryMap = {
  (User).toString(): User.init,
  (Doing).toString(): Doing.init,
  (Message).toString(): Message.init,
  (Auxiliary).toString(): Auxiliary.init,
};
