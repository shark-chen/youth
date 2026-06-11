import 'package:image_picker/image_picker.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/birthday_sheet/view/edit_birthday_sheet_widget.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_nickname_sheet_widget.dart';
import 'package:kellychat/tripartite_library/image_picker/images_picker.dart';
import 'package:kellychat/widget/region_picker/region_picker_sheet.dart';
import '../profile_setup_controller.dart';
import '../view_model/profile_setup_vm.dart';

extension ProfileSetupRouteController on ProfileSetupController {
  Future<void> pushEditNiceNameAlert({
    String? title,
    String? text,
    String? hintText,
    required ValueChanged<String> sureCall,
  }) async {
    final tec = TextEditingController(text: text);
    final focusNode = FocusNode();
    focusNode.requestFocus();
    await BottomAlert.alerts(
      Get.context!,
      isDismissible: true,
      wholeCustomWidget: EditNickNameSheetWidget(
        title: title,
        nickname: tec.text,
        maxLength: 30,
        controller: tec,
        focusNode: focusNode,
        hintText: hintText,
        closeTap: Get.back,
        sureTap: () => sureCall(tec.text.trim()),
      ),
    );
  }

  /// push - 打开生日选择
  Future<void> pushEditBirthdaySheet() async {
    final now = DateTime.now();
    final initial = vm.value.birthdayAsDate() ?? DateTime(now.year - 25);
    final picked = await showDialog<DateTime>(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (dialogContext) => EditBirthdaySheetDialog(initialDate: initial),
    );
    if (picked != null) {
      vm.value.configBirthday(picked);
      vm.refresh();
    }
  }

  /// push - 地区选择 弹框
  Future<void> pushRegionPickerAlert() async {
    final provinces = await vm.value.loadProvinces();
    if (Lists.isEmpty(provinces)) return;
    final indices = vm.value.regionIndices(provinces!);
    await showModalBottomSheet<void>(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SizedBox(
          height: screenHeight * 0.65,
          child: RegionPickerSheet(
            title: '选择地区',
            provinces: provinces,
            initialProvinceIndex: indices?.provinceIndex ?? 0,
            initialCityIndex: indices?.cityIndex ?? 0,
            initialDistrictIndex: indices?.districtIndex,
            initialTabIndex: indices?.initialTabIndex ?? 0,
            onClose: Get.back,
            onSelectionChanged: (s) {
              if (Strings.isEmpty(s.district)) return;

              /// 配置地区
              vm.value.configRegion(s);
              vm.refresh();
              Get.back();
            },
          ),
        );
      },
    );
  }

  /// push - 选择图片
  Future<XFile?> pushPickAvatarFilePage() async {
    try {
      final x = await ImagesPicker().pickImageFromGalleryThenEdit(
        Get.context!,
        cropAspectRatio: 1,
        lockCropRect: true,
      );
      if (x == null) return null;
      return x;
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
      return null;
    }
  }

  /// 添加图片墙
  Future<XFile?> pickPhotoFile() async {
    try {
      final x = await ImagesPicker().pickImageFromGallery();
      if (x == null) return null;
      return x;
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
      return null;
    }
  }
}
