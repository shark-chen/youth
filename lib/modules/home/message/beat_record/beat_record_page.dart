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
      body: ListView.builder(
        padding: EdgeInsets.only(top: 12),
        itemCount: 300,
        // itemCount: controller.rows.length,
        itemBuilder: (BuildContext context, int index) {
          return BeatRecordCell(
            headPortraitUrl: '',
            name: '大三大四的',
            time: '12:12',
            userInfoTap: controller.pushUserInfoPage,
          );
        },
      ),
    );
  }
}
