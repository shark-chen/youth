import 'package:youth/base/base_page.dart';
import 'mine_controller.dart';

/// FileName: mine_page
///
/// @Author 谌文
/// @Date 2026/4/12 20:41
///
/// @Description 我的页面
class MinePage extends BasePage<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Obx(() {
                return _MineCard(
                  onTap: controller.pushMyProfile,
                  child: Row(
                    children: [
                      ImageLookWidget(
                        width: 56,
                        height: 56,
                        imgUrl: controller.userProfile?.avatar ?? '',
                        imgBorderRadius: BorderRadius.circular(28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    Strings.isNotEmpty(
                                            controller.userProfile?.nickname)
                                        ? (controller.userProfile?.nickname ??
                                            '')
                                        : '未设置昵称',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ThemeColor.whiteColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (controller.userProfile?.gender == 1) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.male,
                                      size: 20, color: Color(0xFF5AC8FA)),
                                ] else if (controller.userProfile?.gender ==
                                    2) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.female,
                                      size: 20, color: Color(0xFFFF2D55)),
                                ],
                              ],
                            ),
                            if (Strings.isNotEmpty(
                                controller.userProfile?.regionInfo)) ...[
                              const SizedBox(height: 4),
                              Text(
                                controller.userProfile?.regionInfo ?? '',
                                style: TextStyle(
                                  color:
                                      ThemeColor.whiteColor.withOpacity(0.55),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: ThemeColor.whiteColor.withOpacity(0.45),
                        size: 22,
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
              _MineCard(
                onTap: controller.pushAbout,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '关于 KellyChat',
                        style: TextStyle(
                          color: ThemeColor.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: ThemeColor.whiteColor.withOpacity(0.45),
                      size: 22,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _MineCard(
                onTap: controller.confirmLogout,
                child: Center(
                  child: Text(
                    LocaleKeys.LoginOut.tr,
                    style: TextStyle(
                      color: ThemeColor.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MineCard extends StatelessWidget {
  const _MineCard({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            color: ThemeColor.doingListCellBgColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: child,
          ),
        ),
      ),
    );
  }
}
