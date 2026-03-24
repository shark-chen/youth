import '../../../base/base_page.dart';
import 'mine_controller.dart';
import 'view/mine_cell.dart';

/// FileName mine_page
///
/// @Author 谌文
/// @Date 2023/8/23 11:40
///
/// @Description 我的页面
class MinePage extends BasePage<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.personalBackColor,
      appBar: AppBarKit.appBar(
        textColor: ThemeColor.whiteColor,
        controller.title ?? '',
        elevation: 0.2,
        leading: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ThemeColor.whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '消息',
            style: TextStyles(),
          ),
        ),
        backgroundColor: ThemeColor.themeColor,
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.vm.value.rows.length,
          itemBuilder: (BuildContext context, int index) {
            var item = controller.vm.value.rows[index];
            return MineCell(
              title: item.title,
              content: item.content,
              middleContent: item.middleContent,
              middleContentStyle: item.middleContentStyle,
              showArrow: item.showArrow,
              showRed: item.showRed,
              notVisible: item.notVisible,
              onTap: () => controller.clickCell(item),
            );
          },
          separatorBuilder: (context, index) {
            var item = controller.vm.value.rows[index];
            if (item.isSection == true) return const SizedBox(height: 13);
            return LineView(padding: EdgeInsets.only(left: 12));
          },
        ),
      ),
    );
  }
}
