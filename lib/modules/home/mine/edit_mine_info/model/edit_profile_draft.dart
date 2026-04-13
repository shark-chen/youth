import 'package:youth/modules/home/mine/user_info/model/user_info_entity.dart';

/// FileName: edit_profile_draft
///
/// @Author 谌文
/// @Date 2026/4/12 23:10
///
/// @Description 编辑资料页本地草稿（由 [EditMineInfoVM] 维护）
class EditProfileDraft {
  EditProfileDraft({
    this.avatarUrl = '',
    this.pendingAvatarLocalPath,
    this.nickname = '',
    this.gender = 0,
    this.birthday,
    this.province,
    this.city,
    this.district,
    List<String>? tags,
    this.signature = '',
    List<String>? photos,
    this.hasPrivateContent = false,
  })  : tags = List<String>.from(tags ?? const []),
        photos = List<String>.from(photos ?? const []);

  /// 当前头像 URL（服务端）
  String avatarUrl;

  /// 新选头像本地路径，上传成功后清空并写回 [avatarUrl]
  String? pendingAvatarLocalPath;

  String nickname;

  /// 0 未知 1 男 2 女
  int gender;

  String? birthday;

  String? province;
  String? city;
  String? district;

  List<String> tags;

  String signature;

  /// 网络 URL 或本地文件路径，最多 [maxPhotos]
  List<String> photos;

  bool hasPrivateContent;

  static const int maxTags = 10;
  static const int maxSignatureLength = 30;
  static const int maxPhotos = 4;
  static const int profileCardTagCount = 3;
  static const int profileCardPhotoCount = 3;

  factory EditProfileDraft.fromUserInfo(UserInfoEntity? u) {
    if (u == null) return EditProfileDraft();
    return EditProfileDraft(
      avatarUrl: u.avatar ?? '',
      nickname: u.nickname ?? '',
      gender: u.gender ?? 0,
      birthday: u.birthday,
      province: u.province,
      city: u.city,
      district: null,
      tags: u.tags,
      signature: u.signature ?? '',
      photos: u.photos,
      hasPrivateContent: u.hasPrivateContent ?? false,
    );
  }

  /// 仅提交远程可识别的图片地址（过滤本地路径）
  List<String> remotePhotoUrls() {
    return photos
        .where(
          (e) =>
              e.startsWith('http://') ||
              e.startsWith('https://'),
        )
        .toList();
  }

  bool get hasLocalPhotos =>
      photos.any((e) => !e.startsWith('http://') && !e.startsWith('https://'));
}
