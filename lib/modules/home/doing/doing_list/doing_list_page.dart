import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/utils/extension/lists/lists.dart';
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

  /// 与 [SexSelectController] 一致：1 男 · 2 女
  static bool? _sexFromGender(int? gender) {
    if (gender == 1) return true;
    if (gender == 2) return false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        controller.title ?? '我正在',
        backTap: controller.closePage,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 12),
            Obx(() {
              return GestureDetector(
                onTap: controller.clickDeleteStatusDoing,
                child: DoingListHeaderWidget(
                  title: controller.vm.value.myDoing?.tagName ?? '--',
                  inviteTap: controller.pushInviteAlert,
                ),
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
              child: Obx(() {
                if (Lists.isEmpty(controller.rows)) {
                  return Center(
                    child: Text(
                      '暂无同频用户',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 15,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 6, bottom: 24),
                  itemCount: controller.rows?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.rows?[index];
                    return DoingListCell(
                      headerIcon: item?.avatar,
                      name: item?.nickname,
                      sex: _sexFromGender(item?.gender),
                      age: item?.age != null ? '${item?.age}' : null,
                      address: item?.city,
                      signature: item?.signature,
                      isOnline: false,
                      onKnockTap: () async => controller.clickKnock(item),
                      onTogetherTap: () async =>
                          controller.clickJoinTogether(item),
                      onTap: () async => controller.clickLookUserInfo(item),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
