import 'package:kellychat/base/base_bindings.dart';
import 'profile_setup_controller.dart';

class ProfileSetupBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSetupController>(() => ProfileSetupController());
  }
}
