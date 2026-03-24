import 'package:youth/modules/user/user_center/user_info/model/user_info_entity.dart';
import 'package:youth/generated/json/convert/json_convert_content.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final UserInfoUser? user = jsonConvert.convert<UserInfoUser>(json['user']);
  if (user != null) {
    userInfoEntity.user = user;
  }
  final String? userSite = jsonConvert.convert<String>(json['userSite']);
  if (userSite != null) {
    userInfoEntity.userSite = userSite;
  }
  final bool? masterAccount = jsonConvert.convert<bool>(json['masterAccount']);
  if (masterAccount != null) {
    userInfoEntity.masterAccount = masterAccount;
  }
  final String? language = jsonConvert.convert<String>(json['language']);
  if (language != null) {
    userInfoEntity.language = language;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    userInfoEntity.currency = currency;
  }
  final int? vipLevel = jsonConvert.convert<int>(json['vipLevel']);
  if (vipLevel != null) {
    userInfoEntity.vipLevel = vipLevel;
  }
  final int? vipExpireTime = jsonConvert.convert<int>(json['vipExpireTime']);
  if (vipExpireTime != null) {
    userInfoEntity.vipExpireTime = vipExpireTime;
  }
  final String? vipExpireTimeStr =
      jsonConvert.convert<String>(json['vipExpireTimeStr']);
  if (vipExpireTimeStr != null) {
    userInfoEntity.vipExpireTimeStr = vipExpireTimeStr;
  }
  final int? vipExpireDay = jsonConvert.convert<int>(json['vipExpireDay']);
  if (vipExpireDay != null) {
    userInfoEntity.vipExpireDay = vipExpireDay;
  }
  final int? currentVipExpireTime =
      jsonConvert.convert<int>(json['currentVipExpireTime']);
  if (currentVipExpireTime != null) {
    userInfoEntity.currentVipExpireTime = currentVipExpireTime;
  }
  final String? currentVipExpireTimeStr =
      jsonConvert.convert<String>(json['currentVipExpireTimeStr']);
  if (currentVipExpireTimeStr != null) {
    userInfoEntity.currentVipExpireTimeStr = currentVipExpireTimeStr;
  }
  final int? currentVipExpireDay =
      jsonConvert.convert<int>(json['currentVipExpireDay']);
  if (currentVipExpireDay != null) {
    userInfoEntity.currentVipExpireDay = currentVipExpireDay;
  }
  final String? currentVipAllocateTimeStr =
      jsonConvert.convert<String>(json['currentVipAllocateTimeStr']);
  if (currentVipAllocateTimeStr != null) {
    userInfoEntity.currentVipAllocateTimeStr = currentVipAllocateTimeStr;
  }
  final bool? modifyUser = jsonConvert.convert<bool>(json['modifyUser']);
  if (modifyUser != null) {
    userInfoEntity.modifyUser = modifyUser;
  }
  final dynamic closeModifyPwd =
      jsonConvert.convert<dynamic>(json['closeModifyPwd']);
  if (closeModifyPwd != null) {
    userInfoEntity.closeModifyPwd = closeModifyPwd;
  }
  final int? waveOpenState = jsonConvert.convert<int>(json['waveOpenState']);
  if (waveOpenState != null) {
    if (waveOpenState == 1) {
      userInfoEntity.waveOpenState = true;
    } else {
      userInfoEntity.waveOpenState = false;
    }
  }
  final int? isNewActivation =
      jsonConvert.convert<int>(json['isNewActivation']);
  if (isNewActivation != null) {
    userInfoEntity.isNewActivation = isNewActivation;
  }
  final dynamic activityRelationInfoVo =
      jsonConvert.convert<dynamic>(json['activityRelationInfoVo']);
  if (activityRelationInfoVo != null) {
    userInfoEntity.activityRelationInfoVo = activityRelationInfoVo;
  }
  final dynamic propagateTimeBanner =
      jsonConvert.convert<dynamic>(json['propagateTimeBanner']);
  if (propagateTimeBanner != null) {
    userInfoEntity.propagateTimeBanner = propagateTimeBanner;
  }
  final bool? login = jsonConvert.convert<bool>(json['login']);
  if (login != null) {
    userInfoEntity.login = login;
  }
  final String? currentLoginAccount =
      jsonConvert.convert<String>(json['currentLoginAccount']);
  if (currentLoginAccount != null) {
    userInfoEntity.currentLoginAccount = currentLoginAccount;
  }
  final bool? multipleUnitsFlag =
      jsonConvert.convert<bool>(json['multipleUnitsFlag']);
  if (multipleUnitsFlag != null) {
    userInfoEntity.multipleUnitsFlag = multipleUnitsFlag;
  }
  final bool? openBatchManage =
      jsonConvert.convert<bool>(json['openBatchManage']);
  if (openBatchManage != null) {
    userInfoEntity.openBatchManage = openBatchManage;
  }
  final bool? openExpiry = jsonConvert.convert<bool>(json['openExpiry']);
  if (openExpiry != null) {
    userInfoEntity.openExpiry = openExpiry;
  }
  final bool? purchaseOpenExpiry =
      jsonConvert.convert<bool>(json['purchaseOpenExpiry']);
  if (purchaseOpenExpiry != null) {
    userInfoEntity.purchaseOpenExpiry = purchaseOpenExpiry;
  }
  final bool? receivedOpenExpiry =
      jsonConvert.convert<bool>(json['receivedOpenExpiry']);
  if (receivedOpenExpiry != null) {
    userInfoEntity.receivedOpenExpiry = receivedOpenExpiry;
  }
  final bool? stockInOpenExpiry =
      jsonConvert.convert<bool>(json['stockInOpenExpiry']);
  if (stockInOpenExpiry != null) {
    userInfoEntity.stockInOpenExpiry = stockInOpenExpiry;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user?.toJson();
  data['userSite'] = entity.userSite;
  data['masterAccount'] = entity.masterAccount;
  data['language'] = entity.language;
  data['currency'] = entity.currency;
  data['vipLevel'] = entity.vipLevel;
  data['vipExpireTime'] = entity.vipExpireTime;
  data['vipExpireTimeStr'] = entity.vipExpireTimeStr;
  data['vipExpireDay'] = entity.vipExpireDay;
  data['currentVipExpireTime'] = entity.currentVipExpireTime;
  data['currentVipExpireTimeStr'] = entity.currentVipExpireTimeStr;
  data['currentVipExpireDay'] = entity.currentVipExpireDay;
  data['currentVipAllocateTimeStr'] = entity.currentVipAllocateTimeStr;
  data['modifyUser'] = entity.modifyUser;
  data['closeModifyPwd'] = entity.closeModifyPwd;
  data['waveOpenState'] = entity.waveOpenState;
  data['puid'] = entity.puid;
  data['account'] = entity.account;
  data['mainAccount'] = entity.mainAccount;
  return data;
}

UserInfoUser $UserInfoUserFromJson(Map<String, dynamic> json) {
  final UserInfoUser userInfoUser = UserInfoUser();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userInfoUser.id = id;
  }
  final int? puid = jsonConvert.convert<int>(json['puid']);
  if (puid != null) {
    userInfoUser.puid = puid;
  }
  final String? account = jsonConvert.convert<String>(json['account']);
  if (account != null) {
    userInfoUser.account = account;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (account != null) {
    userInfoUser.password = password;
  }
  final String? mainAccount = jsonConvert.convert<String>(json['mainAccount']);
  if (mainAccount != null) {
    userInfoUser.mainAccount = mainAccount;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userInfoUser.status = status;
  }
  final int? markModifyStatus =
      jsonConvert.convert<int>(json['markModifyStatus']);
  if (markModifyStatus != null) {
    userInfoUser.markModifyStatus = markModifyStatus;
  }
  final int? userMark = jsonConvert.convert<int>(json['userMark']);
  if (userMark != null) {
    userInfoUser.userMark = userMark;
  }
  final String? currentLoginAccount =
      jsonConvert.convert<String>(json['currentLoginAccount']);
  if (currentLoginAccount != null) {
    userInfoUser.currentLoginAccount = currentLoginAccount;
  }
  return userInfoUser;
}

Map<String, dynamic> $UserInfoUserToJson(UserInfoUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  if (entity.id != null) {
    data['id'] = entity.id;
  }
  if (entity.puid != null) {
    data['puid'] = entity.puid;
  }
  if (entity.account != null) {
    data['account'] = entity.account;
  }
  if (entity.password != null) {
    data['password'] = entity.password;
  }
  if (entity.status != null) {
    data['status'] = entity.status;
  }
  if (entity.markModifyStatus != null) {
    data['markModifyStatus'] = entity.markModifyStatus;
  }
  if (entity.userMark != null) {
    data['userMark'] = entity.userMark;
  }
  return data;
}
