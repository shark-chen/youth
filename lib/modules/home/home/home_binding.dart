import 'package:kellychat/modules/home/doing/doing_list/doing_list_controller.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import '../../../base/base_bindings.dart';
import '../doing/doing_controller.dart';
import '../doing/model/doing_hot_tags_entity.dart';
import '../hall/hall_controller.dart';
import '../message/message_controller.dart';
import 'home_controller.dart';
import 'package:kellychat/network/im/im_service.dart';

/// FileName home_binding
///
/// @Author 谌文
/// @Date 2023/12/18 15:37
///
/// @Description APP-home-binding
class HomeBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<HallController>(HallController());
    final doing = MyDoing().doing;
    if (doing != null) {
      Get.put<DoingListController>(
        DoingListController(
          value: DoingHotTagsEntity()
            ..tagName = doing.tagName
            ..tagId = doing.tagId,
        ),
      );
    } else {
      Get.put<DoingController>(DoingController());
    }
    Get.put<MessageController>(MessageController());
    Get.put<ImService>(ImService(), permanent: true);
  }
}
