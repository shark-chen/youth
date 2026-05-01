import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/user_info/model/user_info_entity.dart';
import 'package:kellychat/utils/marco/debug_print.dart';
import '../../../network/net/request/dio/dio_net.dart';
import '../../../network/reporter/report_util.dart';
export 'user_info/user_info_center.dart';
import 'my_doing/my_doing.dart';
import 'user_mixin/user_mixin.dart';
export 'user_options/user_options.dart';
export 'user_info/model/user_info_entity.dart';

/// FileName user_center
///
/// @Author 谌文
/// @Date 2023/5/30 11:32
///
/// @Description 用户中心
class UserCenter extends BaseUser {
  static final UserCenter _instance = UserCenter._();

  factory UserCenter() => _instance;

  UserCenter._();

  /// 苹果审核用
  late bool unsubscribed = false;

  /// 是否成功
  bool? get succeed {
    return UserInfoCenter().succeed == true;
  }

  /// APP启动就会调用
  /// awaitUserRights: 是否需要登录请求权限接口,什么场景下用，就是主账号，就是什么权限都是有的
  /// （UserRights是用来控制子账号的），所以没必要一定要获取这个接口
  /// 前提是 必须是主账号才生效
  @override
  Future init({bool? awaitUserRights = true}) async {
    super.init();

    /// 用户信息数据中心
    try {
      await UserInfoCenter().init();
    } catch (e) {
      ReportUtil().record('UserInfoCenter.init()$e');
    }

    /// 存储类
    try {
      await Stores().init();
    } catch (e) {
      ReportUtil().record('Stores.init()$e');
    }

    /// 正在做的事情
    try {
      await MyDoing().init();
    } catch (e) {
      ReportUtil().record('MyDoing.init()$e');
    }

    /// 存在本地的一些用户配置
    try {
      UserOptions().init();
    } catch (e) {
      ReportUtil().record('UserOptions.init()$e');
    }

    /// request-获取用户信息接口
    requestUserInfo(update: true);

    if (kDebugMode) {
      DebugPrint('puid: ${UserCenter().user?.id}');
    }
  }

  /// 刷新
  @override
  Future update() async {
    super.update();
    await init();
  }

  /// 清除个人中心数据
  @override
  Future clear({bool? loginOut = true}) async {
    super.clear();
    UserInfoCenter().clear();

    DioNet().clear();
    Stores().dispose();
  }

  /// MARK: -用户本地设置的信息 - UserOptions

  /// 用户本地设置的信息
  UserOptions get userOptions {
    return UserOptions();
  }

  /// 是否设置为相机扫描:
  bool get isCamera {
    return UserOptions().isCamera ?? true;
  }

  /// 相机扫描间隔时间 - 复默认扫描间隔时间：1秒
  double get scanTimeInterval {
    return UserOptions().scanTimeInterval;
  }

  /// 设置是否是相机扫描
  Future cameraScan(bool enable) async {
    return await UserOptions().cameraScan(enable);
  }

  /// 是否展示拣货车编码
  bool get showPickingCar {
    return UserOptions().showPickingCar ?? false;
  }

  /// 设置是否展示拣货车编码
  Future setShowPickingCar(bool open) async {
    return await UserOptions().setShowPickingCar(open);
  }

  /// 拍照是否使用原生相机
  Future<bool> get nativeCamera async {
    return await UserOptions().nativeCamera;
  }

  /// 保存用户设置
  Future saveCameraWay(bool open) async {
    return await UserOptions().saveCameraWay(open);
  }

  /// MARK: -用户信息模块 - UserInfoCenter

  /// 获取用户信息+信息为空会请求-之后使用缓存
  Future<UserInfoEntity?> get userInfo async {
    return await UserInfoCenter().userInfo;
  }

  /// 使用缓存
  UserInfoEntity? get user {
    return UserInfoCenter().userInfoEntity;
  }

  /// request-获取用户信息接口
  Future<UserInfoEntity?> requestUserInfo({bool? update}) async {
    return UserInfoCenter().requestUserInfo(update: update);
  }
}
