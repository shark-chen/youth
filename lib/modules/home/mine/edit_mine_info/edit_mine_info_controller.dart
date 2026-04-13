import 'package:youth/base/base_controller.dart';
import 'package:youth/widget/region_picker/region_picker_sheet.dart';
import 'view/edit_nickname_widget.dart';
import 'view_model/edit_mine_info_vm.dart';
import 'controller/edit_mine_info_route_controller.dart';
export 'controller/edit_mine_info_route_controller.dart';

/// FileName: edit_mine_info_controller
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description 编辑资料：路由、弹窗、保存流程（数据处理在 [EditMineInfoVM]）
class EditMineInfoController extends BaseController {
  Rx<EditMineInfoVM> vm = EditMineInfoVM().obs;

  @override
  void onInit() {
    super.onInit();
    title = '编辑资料';
    vm.value.refresh = vm.refresh;
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    EasyLoading.show();
    final err = await vm.value.loadFromServer();
    EasyLoading.dismiss();
    if (err != null && err.isNotEmpty) {
      EasyLoading.showToast(err);
    }
    vm.refresh();
  }

  @override
  void onClose() {
    vm.value.disposeExtra();
    super.onClose();
  }

  void onCancel() {
    Get.back();
  }

  Future<void> onSave() async {
    if (requesting.value) return;
    requesting.value = true;
    EasyLoading.show(status: LocaleKeys.Commiting.tr);
    final err = await vm.value.persistProfile();
    EasyLoading.dismiss();
    requesting.value = false;
    if (err != null && err.isNotEmpty) {
      EasyLoading.showToast(err);
      return;
    }
    EasyLoading.showToast(LocaleKeys.submitSuccess.tr);
    Get.back(result: true);
  }

  Future<void> onAvatarTap() async {
    await vm.value.pickAvatarFile();
    vm.refresh();
  }



  Future<void> onGenderTap() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await showModalBottomSheet<void>(
      context: ctx,
      backgroundColor: ThemeColor.doingListCellBgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (c) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('男', style: TextStyle(color: ThemeColor.whiteColor)),
                onTap: () {
                  vm.value.setGender(1);
                  Navigator.pop(c);
                  vm.refresh();
                },
              ),
              ListTile(
                title: Text('女', style: TextStyle(color: ThemeColor.whiteColor)),
                onTap: () {
                  vm.value.setGender(2);
                  Navigator.pop(c);
                  vm.refresh();
                },
              ),
              ListTile(
                title: Text('未知', style: TextStyle(color: ThemeColor.whiteColor)),
                onTap: () {
                  vm.value.setGender(0);
                  Navigator.pop(c);
                  vm.refresh();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onBirthdayTap() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final now = DateTime.now();
    final initial = vm.value.birthdayAsDate() ?? DateTime(now.year - 25);
    final picked = await showDatePicker(
      context: ctx,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (c, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: ThemeColor.themeGreenColor,
              surface: ThemeColor.doingListCellBgColor,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) {
      vm.value.setBirthday(picked);
      vm.refresh();
    }
  }

  Future<void> onRegionTap() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final provinces = await vm.value.loadProvinces();
    if (provinces == null || provinces.isEmpty) return;
    final idx = vm.value.regionIndices(provinces);
    await showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (c) {
        return RegionPickerSheet(
          provinces: provinces,
          initialProvinceIndex: idx?.provinceIndex ?? 0,
          initialCityIndex: idx?.cityIndex ?? 0,
          initialDistrictIndex: idx?.districtIndex,
          initialTabIndex: idx?.districtIndex != null ? 2 : 0,
          onClose: () => Navigator.pop(c),
          onSelectionChanged: (s) {
            vm.value.applyRegion(s);
            vm.refresh();
            if (s.district.isNotEmpty) {
              Navigator.pop(c);
            }
          },
        );
      },
    );
  }

  void onTagReorder(int oldIndex, int newIndex) {
    vm.value.reorderTags(oldIndex, newIndex);
    vm.refresh();
  }

  Future<void> onAddTagTap() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final tec = TextEditingController();
    final result = await showDialog<String>(
      context: ctx,
      builder: (c) {
        return AlertDialog(
          backgroundColor: ThemeColor.inputBgColor,
          title: Text(
            '添加标签',
            style: TextStyle(color: ThemeColor.whiteColor),
          ),
          content: TextField(
            controller: tec,
            autofocus: true,
            style: TextStyle(color: ThemeColor.whiteColor),
            decoration: InputDecoration(
              hintText: '例如：🎬 看电影',
              hintStyle: TextStyle(
                color: ThemeColor.whiteColor.withOpacity(0.45),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(
                '取消',
                style: TextStyle(color: ThemeColor.themeA2Color),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(c, tec.text),
              child: Text(
                '确定',
                style: TextStyle(color: ThemeColor.themeGreenColor),
              ),
            ),
          ],
        );
      },
    );
    tec.dispose();
    if (result != null) {
      vm.value.addTag(result);
      vm.refresh();
    }
  }

  Future<void> onAddPhotoTap() async {
    await vm.value.pickPhotoFile();
    vm.refresh();
  }

  void onRemovePhoto(int index) {
    vm.value.removePhotoAt(index);
    vm.refresh();
  }

  void onPrivateAiTap() {
    EasyLoading.showToast('敬请期待');
  }

  void onChangePasswordTap() {
    EasyLoading.showToast('修改密码功能即将开放');
  }
}
