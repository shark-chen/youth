import 'package:youth/base/base_page.dart';
import 'doing_list_controller.dart';
import 'view/doing_list_cell.dart';
import 'view/doing_list_header_view.dart';

/// FileName: doing_list_page
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-页面-page
class DoingListPage extends BasePage<DoingListController> {
  const DoingListPage({Key? key}) : super(key: key);

  static const _demoNames = ['小雨', '阿宁', '橙子', 'Momo', '阿哲'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        controller.title ?? '我正在',
        backgroundColor: ThemeColor.themeColor,
        elevation: 0,
        textColor: ThemeColor.whiteColor,
        backTap: controller.closePage,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() {
            final v = controller.vm.value;
            return DoingListHeaderWidget(
              title: v.activityTitle,
              inviteTap: () {},
            );
          }),
          Obx(() {
            final v = controller.vm.value;
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 14,
                    height: 1.35,
                  ),
                  children: [
                    const TextSpan(text: '有 '),
                    TextSpan(
                      text: '${v.samePeopleCount}',
                      style: const TextStyle(
                        color: ThemeColor.themeGreenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: ' 人也在「${v.activityTitle}」'),
                  ],
                ),
              ),
            );
          }),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 6, bottom: 24),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                final name = _demoNames[index % _demoNames.length];
                final isMale = index % 3 != 1;
                return DoingListCell(
                  headerIcon:
                      'https://i.pravatar.cc/128?img=${(index % 70) + 1}',
                  name: name,
                  sex: isMale,
                  age: '${22 + (index % 18)}',
                  address: index.isEven ? '深圳' : '广州',
                  signature: '不讨好，不迎合，不够讨喜，但是做自己最真实',
                  isOnline: index == 0,
                  onKnockTap: () {},
                  onTogetherTap: () {},
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
            ),
          ),
        ],
      ),
    );
  }
}
