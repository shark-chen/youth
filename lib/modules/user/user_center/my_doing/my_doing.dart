import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/net.dart';

import '../user_mixin/user_mixin.dart';

/// FileName: my_doing
///
/// @Author 谌文
/// @Date 2026/5/1 22:59
///
/// @Description
class MyDoing extends BaseUser {
  static final MyDoing _instance = MyDoing._();

  factory MyDoing() => _instance;

  MyDoing._();

  /// 正在做的事情
  PublishDoingEntity? _doing;

  @override
  Future init() async {
    super.init();
    await requestMyDoing();
  }

  @override
  void clear() {
    super.clear();
    _doing = null;
  }

  PublishDoingEntity? get doing  {
    return _doing;
  }

  Future<PublishDoingEntity?> get doInfo async {
    _doing ??= await requestMyDoing();
    return _doing;
  }

  /// mark - request
  ///
  /// GET /api/status/my-doing
  Future<PublishDoingEntity?> requestMyDoing() async {
    final response =
        await Net.value<Doing>().cache<PublishDoingEntity>((value) {
      if (value == null) return;
      _doing = value;
    }).requestMyDoing<PublishDoingEntity>();
    if (response.succeed) {
      _doing = response.value;
    } else if (response.code == 200) {
      _doing = null;
    }
    return _doing;
  }
}
