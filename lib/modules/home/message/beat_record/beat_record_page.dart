import 'package:youth/base/base_page.dart';
import 'beat_record_controller.dart';
import 'view/beat_record_cell.dart';

/// FileName: beat_record_page
///
/// @Author 谌文
/// @Date 2026/3/17 23:22
///
/// @Description 敲一下记录- page
class BeatRecordPage extends BasePage<BeatRecordController> {
  const BeatRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.only(top: 12),
          itemCount: controller.rows.length,
          itemBuilder: (BuildContext context, int index) {
            final item = controller.rows[index];
            return BeatRecordCell(
              headPortraitUrl: item.fromAvatar,
              name: item.fromNickname,
              time: item.createdAt,
              userInfoTap: controller.pushUserInfoPage,
            );
          },
        ),
      ),
    );
  }
}
