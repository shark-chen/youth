import 'package:kellychat/modules/home/mine/user_info/model/user_info_entity.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import '../doing_controller.dart';
import 'package:kellychat/base/base_controller.dart';
import '../model/doing_hot_tags_entity.dart';
import '../model/publish_doing_entity.dart';

/// FileName: doing_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 21:02
///
/// @Description
extension DoingRequestController on DoingController {
  /// mark - request
  ///
  /// GET /api/status/my-doing
  Future<void> requestMyDoing() async {
    EasyLoading.show();
    final response =
    await Net.value<Doing>().cache<PublishDoingEntity>((value) {
      if (value == null) return;
    }).requestMyDoing<PublishDoingEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 获取当前热门的正在做标签列表
  /// /api/status/hot-tags
  Future requestHotTags() async {
    EasyLoading.show();
    var response =
        await Net.value<Doing>().requestHotTags<DoingHotTagsEntity>(limit: 20);
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configHotTags(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 发布一个正在做的状态
  /// POST /api/status/doing  body: `{ "tagName": "" }`
  Future<PublishDoingEntity?> requestPostStatusDoing({
    String tagName = '',
  }) async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestPostStatusDoing<PublishDoingEntity>(
      tagName: tagName,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.refresh();
      EasyLoading.showToast('发布成功');
      return response.value;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return null;
    }
  }



  /// 获取个人信息 · GET /api/user/profile
  Future<void> requestUserProfile() async {
    EasyLoading.show();
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      vm.value.configUserInfo(value);
      vm.refresh();
    }).requestUserInfo<UserInfoEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configUserInfo(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
