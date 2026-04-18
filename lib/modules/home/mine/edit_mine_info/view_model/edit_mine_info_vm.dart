import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youth/base/base_vm.dart';
import 'package:youth/modules/home/mine/user_info/model/user_info_entity.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/utils/authority/photos_authority.dart';
import 'package:youth/widget/region_picker/region_picker_data.dart';
import 'package:youth/widget/region_picker/region_picker_sheet.dart';

import '../../sex_select/model/gender.dart';
import '../model/edit_profile_draft.dart';
import '../model/edit_region_indices.dart';
import '../model/user_private_info_entity.dart';

/// FileName: edit_mine_info_vm
///
/// @Author 谌文
/// @Date 2026/4/12 22:55
///
/// @Description 编辑资料：数据组装、校验与网络（流程由 Controller 调度）
class EditMineInfoVM extends BaseVM {
  /// 草稿
  EditProfileDraft draft = EditProfileDraft();

  late final TextEditingController signatureController;

  List<RegionProvince>? _cachedProvinces;

  final ImagePicker _imagePicker = ImagePicker();

  /// 私密信息
  UserPrivateInfoEntity? userPrivateInfoEntity;

  /// 相册选图：关闭 Loading、下一帧再调起，避免遮罩/重建与系统相册冲突；iOS 关闭全量元数据以减轻卡死
  Future<XFile?> _pickImageFromGallery({
    int imageQuality = 85,
  }) async {
    return await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 2048,
      maxHeight: 2048,
      imageQuality: imageQuality,
      requestFullMetadata: false,
    );
  }

  @override
  void onInit() {
    super.onInit();
    signatureController = TextEditingController();
    signatureController.addListener(() => refresh?.call());
    unawaited(_preloadRegions());
  }

  void disposeExtra() {
    signatureController.dispose();
  }

  Future<void> _preloadRegions() async {
    try {
      final raw = await rootBundle.loadString('assets/data/china_regions.json');
      _cachedProvinces = parseRegionProvincesJson(raw);
    } catch (_) {
      _cachedProvinces = null;
    }
  }

  Future<List<RegionProvince>?> loadProvinces() async {
    if (Lists.isNotEmpty(_cachedProvinces)) return _cachedProvinces;
    try {
      final raw = await rootBundle.loadString('assets/data/china_regions.json');
      _cachedProvinces = parseRegionProvincesJson(raw);
    } catch (_) {
      EasyLoading.showToast('地区数据加载失败');
      return null;
    }
    return _cachedProvinces;
  }

  void applyUserInfo(UserInfoEntity? u) {
    draft = EditProfileDraft.fromUserInfo(u);
    signatureController.text = draft.signature;
    refresh?.call();
  }

  String genderDisplay() {
    switch (draft.gender) {
      case 1:
        return '男';
      case 2:
        return '女';
      default:
        return '未知';
    }
  }

  String regionDisplay() {
    final parts = <String>[];
    final p = draft.province?.trim();
    final c = draft.city?.trim();
    if (p != null && p.isNotEmpty) parts.add(p);
    if (c != null && c.isNotEmpty) parts.add(c);
    return parts.join('·');
  }

  void setGender(int g) {
    draft.gender = g.clamp(0, 2);
    refresh?.call();
  }

  Gender? get gender {
    if (1 == draft.gender) {
      return Gender.boy;
    } else if (2 == draft.gender) {
      return Gender.girl;
    }
    return null;
  }

  void setBirthday(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    draft.birthday = '$y-$m-$day';
    refresh?.call();
  }

  void applyRegion(RegionPickerSelection s) {
    draft.province = s.province;
    draft.city = s.city;
    draft.district = s.district;
    refresh?.call();
  }

  void applyNickname(String raw) {
    final t = raw.trim();
    draft.nickname = t;
    refresh?.call();
  }

  EditRegionIndices? regionIndices(List<RegionProvince> provinces) {
    final pv = draft.province;
    final cv = draft.city;
    final dv = draft.district;
    if (pv == null || pv.isEmpty) return null;
    final pi = provinces.indexWhere((e) => e.name == pv);
    if (pi < 0) return null;
    final cities = provinces[pi].cities;
    var ci = 0;
    if (cv != null && cv.isNotEmpty) {
      final idx = cities.indexWhere((c) => c.name == cv);
      if (idx >= 0) ci = idx;
    }
    int? districtIndex;
    if (dv != null && dv.isNotEmpty && cities.isNotEmpty) {
      final ds = cities[ci].districts;
      final didx = ds.indexWhere((d) => d == dv);
      if (didx >= 0) districtIndex = didx;
    }
    return EditRegionIndices(
      provinceIndex: pi,
      cityIndex: ci,
      districtIndex: districtIndex,
    );
  }

  void reorderTags(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    if (oldIndex < 0 ||
        oldIndex >= draft.tags.length ||
        newIndex < 0 ||
        newIndex >= draft.tags.length) {
      return;
    }
    final item = draft.tags.removeAt(oldIndex);
    draft.tags.insert(newIndex, item);
    refresh?.call();
  }

  void addTag(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return;
    if (draft.tags.length >= EditProfileDraft.maxTags) {
      EasyLoading.showToast('最多${EditProfileDraft.maxTags}个标签');
      return;
    }
    draft.tags.add(t);
    refresh?.call();
  }

  void removeTagAt(int index) {
    if (index < 0 || index >= draft.tags.length) return;
    draft.tags.removeAt(index);
    refresh?.call();
  }

  Future<void> pickAvatarFile() async {
    try {
      if (!await PhotosAuthority.request()) return;
      final x = await _pickImageFromGallery(imageQuality: 90);
      if (x == null) return;
      draft.pendingAvatarLocalPath = x.path;
      refresh?.call();
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
    }
  }

  Future<void> pickPhotoFile() async {
    if (draft.photos.length >= EditProfileDraft.maxPhotos) return;
    try {
      if (!await PhotosAuthority.request()) return;
      final x = await _pickImageFromGallery(imageQuality: 88);
      if (x == null) return;
      draft.photos.add(x.path);
      refresh?.call();
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
    }
  }

  void removePhotoAt(int index) {
    if (index < 0 || index >= draft.photos.length) return;
    draft.photos.removeAt(index);
    refresh?.call();
  }

  /// 同步签名输入框到草稿（保存前调用）
  void syncSignatureFromInput() {
    draft.signature = signatureController.text.trim();
  }

  Future<String?> _uploadPendingAvatarIfNeeded() async {
    final path = draft.pendingAvatarLocalPath;
    if (path == null || path.isEmpty) return null;
    final res =
        await Net.value<User>().requestUploadUserAvatarFromPath<dynamic>(
      path,
      filename:
          'image_picker_6EE1DF4E-FC22-452A-B5CB-2989CE652F37-31083-00000A84C9D7C0EB.png',
    );
    if (res.succeed || res.success || (res.code == 200) || (res.code == 0)) {
      draft.pendingAvatarLocalPath = null;
      final data = res.data;
      if (data is Map && data['avatar'] is String) {
        draft.avatarUrl = data['avatar'] as String;
      } else if (data is String && data.startsWith('http')) {
        draft.avatarUrl = data;
      }
      return null;
    }
    return res.msg ?? '头像上传失败';
  }

  /// 落库：先头像再 PUT 资料
  Future<String?> persistProfile() async {
    syncSignatureFromInput();

    final err = await _uploadPendingAvatarIfNeeded();
    if (err != null) return err;

    final remotePhotos = draft.remotePhotoUrls();
    final hadLocalPhotos = draft.hasLocalPhotos;
    return '';
    final response = await Net.value<User>().requestUpdateUserInfo<dynamic>(
      gender: draft.gender,
      birthday: draft.birthday,
      province: draft.province,
      city: draft.city,
      district: draft.district,
      nickname: draft.nickname.isEmpty ? null : draft.nickname,
      signature: draft.signature.isEmpty ? null : draft.signature,
      photos: remotePhotos.isEmpty ? null : remotePhotos,
    );

    final ok = response.succeed ||
        response.success ||
        response.code == 200 ||
        response.code == 0;
    if (!ok) {
      return response.msg ?? LocaleKeys.NetworkError.tr;
    }

    if (hadLocalPhotos) {
      EasyLoading.showToast('相册中本地图片暂未上传，已保存其余资料');
    }

    return null;
  }

  DateTime? birthdayAsDate() {
    final s = draft.birthday;
    if (s == null || s.length < 8) return null;
    try {
      return DateTime.parse(s);
    } catch (_) {
      return null;
    }
  }
}
