import 'package:youth/generated/json/succeed/user_info_entity.g.dart';
import 'dart:convert';
import '../../../../../utils/extension/maps/maps.dart';

class UserInfoEntity {
  UserInfoUser? user;

  int? puid;

  int? uid;

  /// 当前账号
  String? account;

  /// 当前账号 名称
  String? currentLoginAccount;

  /// 主账号
  String? mainAccount;

  /// 销售市场
  String? userSite;

  /// 是否是主账号
  bool? masterAccount;

  /// 语言
  String? language;

  /// 当前币种
  String? currency;

  /// VIP等级
  int? vipLevel;

  /// 波次发货开启状态 0 未开启 1 开启
  bool? waveOpenState;

  /// 是否开启多单位
  bool? multipleUnitsFlag;

  /// 批次管理  true 开启  false 关闭
  bool? openBatchManage;

  /// 开启失效日期强制录入 true开启  false 关闭
  bool? openExpiry;

  /// 失效日期强制录入-采购 true开启  false 关闭
  bool? purchaseOpenExpiry;

  /// 失效日期强制录入-收货入库 true开启  false 关闭
  bool? receivedOpenExpiry;

  /// 失效日期强制录入-入库 true开启  false 关闭
  bool? stockInOpenExpiry;

  /// 过期时间
  int? vipExpireTime;
  String? vipExpireTimeStr;
  int? vipExpireDay;
  int? currentVipExpireTime;
  String? currentVipExpireTimeStr;
  int? currentVipExpireDay;
  String? currentVipAllocateTimeStr;
  bool? modifyUser;
  dynamic closeModifyPwd;
  int? isNewActivation;
  dynamic activityRelationInfoVo;
  dynamic propagateTimeBanner;
  bool? login;

  UserInfoEntity();

  factory UserInfoEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      var result = $UserInfoEntityFromJson(json);
      result.account = result.user?.account;
      result.puid = result.user?.puid;
      result.uid = result.user?.id;
      result.mainAccount = result.user?.mainAccount;
      result.currentLoginAccount = result.user?.currentLoginAccount;
      return result;
    }
    return UserInfoEntity();
  }

  Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class UserInfoUser {
  int? id;
  int? puid;
  String? account;
  String? mainAccount;
  int? status;
  int? markModifyStatus;
  int? userMark;

  /// 当前账号 名称
  String? currentLoginAccount;

  /// 自定义字段
  String? password;

  UserInfoUser();

  factory UserInfoUser.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserInfoUserFromJson(json);
    }
    return UserInfoUser();
  }

  Map<String, dynamic> toJson() => $UserInfoUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
