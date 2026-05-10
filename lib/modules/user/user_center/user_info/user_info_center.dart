import 'dart:io';

import 'package:get/get.dart';
import 'package:kellychat/modules/home/mine/user_info/model/user_info_entity.dart';
import 'package:kellychat/network/downloader/downloader.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import 'package:kellychat/network/net/net.dart';
import 'package:kellychat/tripartite_library/documents/documents.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';

import '../user_mixin/user_mixin.dart';

/// FileName user_info_center
///
/// @Author 谌文
/// @Date 2023/12/12 11:18
///
/// @Description 用户信息数据中心
class UserInfoCenter extends BaseUser {
  static final UserInfoCenter _instance = UserInfoCenter._();

  factory UserInfoCenter() => _instance;

  UserInfoCenter._();

  /// 用户信息模型属性
  UserInfoEntity? userInfoEntity;

  /// 本地头像文件读入内存后的字节（供 [ImageLookWidget.imageBytes] 使用，不传路径）
  final Rxn<Uint8List> avatarImageBytes = Rxn<Uint8List>();

  String? _lastSyncedAvatarUrl;

  Future<File?> _avatarFileForUserId(int? id) async {
    if (id == null) return null;
    final dir = await Documents().directory;
    return File('${dir.path}/user_avatar_$id.jpg');
  }

  Future<void> _refreshAvatarBytesFromDisk() async {
    final f = await _avatarFileForUserId(userInfoEntity?.id);
    if (f == null) return;
    try {
      if (await f.exists()) {
        avatarImageBytes.value = await f.readAsBytes();
      }
    } catch (_) {}
  }

  Future<void> _syncAvatarFromUrl(String? url) async {
    if (Strings.isEmpty(url)) return;
    if (url == _lastSyncedAvatarUrl && avatarImageBytes.value != null) return;
    final f = await _avatarFileForUserId(userInfoEntity?.id);
    if (f == null) return;
    try {
      await Downloader.download(url!, f.path);
      if (await f.exists()) {
        _lastSyncedAvatarUrl = url;
        avatarImageBytes.value = await f.readAsBytes();
      }
    } catch (_) {}
  }

  Future<void> _afterUserInfoReadyForAvatar() async {
    await _refreshAvatarBytesFromDisk();
    await _syncAvatarFromUrl(userInfoEntity?.avatar);
  }

  @override
  Future init() async {
    super.init();
    await requestUserInfo();
  }

  @override
  void clear() {
    final id = userInfoEntity?.id;
    super.clear();
    userInfoEntity = null;
    avatarImageBytes.value = null;
    _lastSyncedAvatarUrl = null;
    if (id != null) {
      Future.microtask(() async {
        try {
          final f = await _avatarFileForUserId(id);
          if (f != null && await f.exists()) {
            await f.delete();
          }
        } catch (_) {}
      });
    }
  }

  Future<UserInfoEntity?> get userInfo async {
    userInfoEntity ??= await requestUserInfo();
    return userInfoEntity;
  }

  /// 获取用户信息接口
  Future<UserInfoEntity?> requestUserInfo({bool? update}) async {
    if (userInfoEntity != null && update != true) {
      await _afterUserInfoReadyForAvatar();
      return userInfoEntity;
    }
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      if (value != null) {
        userInfoEntity = value;
      }
    }).requestUserInfo<UserInfoEntity>();
    if (response.succeed) {
      userInfoEntity = response.value;
      await _afterUserInfoReadyForAvatar();
      return userInfoEntity;
    }
    return null;
  }
}
