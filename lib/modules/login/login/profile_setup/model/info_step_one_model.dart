import 'package:flutter/material.dart';
import 'package:kellychat/modules/home/mine/sex_select/model/gender.dart';

/// FileName: info_step_one_model
///
/// @Author 谌文
/// @Date 2026/6/9 22:51
///
/// @Description 设置用户信息第一步模型数据
class InfoStepOneModel {
  /// 头像url
  String? avatarUrl;

  /// 头像path
  String? avatarPath;

  /// 昵称
  TextEditingController? nicknameController = TextEditingController();

  /// 性别
  Gender? gender;

  /// 生日
  String? birthday;
}
