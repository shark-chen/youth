import 'package:youth/base/base_page.dart';

import 'about_kelly_chat_controller.dart';

/// FileName: about_kelly_chat_page
///
/// @Author 谌文
/// @Date 2026/4/12 21:00
///
/// @Description 关于 KellyChat
class AboutKellyChatPage extends BasePage<AboutKellyChatController> {
  const AboutKellyChatPage({Key? key}) : super(key: key);

  static const _footerGrey = Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        '关于 KellyChat',
        backgroundColor: ThemeColor.themeColor,
        elevation: 0,
        textColor: ThemeColor.whiteColor,
        backTap: controller.closePage,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 28),
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeColor.themeGreenColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'K',
                      style: TextStyle(
                        color: ThemeColor.themeColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '关于 KellyChat',
                    style: TextStyle(
                      color: ThemeColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      '版本: ${controller.appVersion.value}',
                      style: TextStyle(
                        color: ThemeColor.whiteColor.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeColor.doingListCellBgColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          _AboutTile(
                            title: '用户协议',
                            onTap: controller.openUserAgreement,
                          ),
                          _divider(),
                          _AboutTile(
                            title: '隐私政策',
                            onTap: controller.openPrivacyPolicy,
                          ),
                          _divider(),
                          _AboutTile(
                            title: '版本更新',
                            onTap: controller.openAppStore,
                          ),
                          _divider(),
                          _AboutTile(
                            title: '反馈',
                            onTap: controller.openFeedback,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              children: [
                Text(
                  'ICP备案信息：粤ICP备2024344797号',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _footerGrey,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '光跃潮汐 版权所有',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _footerGrey,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Copyright © 2024-2026 GYCX. All Rights Reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _footerGrey.withOpacity(0.85),
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: ThemeColor.whiteColor.withOpacity(0.08),
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: ThemeColor.whiteColor.withOpacity(0.35),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
