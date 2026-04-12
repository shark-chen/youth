import 'package:youth/base/base_page.dart';
import 'about_kelly_chat_controller.dart';

/// FileName: about_kelly_chat_page
///
/// @Author 谌文
/// @Date 2026/4/12 21:00
///
/// @Description 关于 KellyChat）
class AboutKellyChatPage extends BasePage<AboutKellyChatController> {
  const AboutKellyChatPage({Key? key}) : super(key: key);

  static TextStyle get _footerStyle => TextStyle(
        color: ThemeColor.secondaryTextColor,
        fontSize: 12,
        height: 1.45,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        controller.title ?? '',
        backgroundColor: ThemeColor.themeColor,
        elevation: 0,
        textColor: ThemeColor.whiteColor,
        backTap: controller.closePage,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => SizedBox.expand(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 28),
                      _buildLogoMark(),
                      const SizedBox(height: 16),
                      Text(
                        controller.title ?? '关于 KellyChat',
                        style: ThemeColor.white18Text
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        LocaleKeys.CurrentVersion.trParams({
                          'version': controller.appVersion.value,
                        }),
                        style: ThemeColor.white14Text.copyWith(
                          color: ThemeColor.versionColor,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _AboutActionCard(
                          children: [
                            _AboutTile(
                              title: '用户协议',
                              onTap: controller.openUserAgreement,
                            ),
                            _aboutDivider(),
                            _AboutTile(
                              title: LocaleKeys.privacyPolicy.tr,
                              onTap: controller.openPrivacyPolicy,
                            ),
                            _aboutDivider(),
                            _AboutTile(
                              title: '版本更新',
                              onTap: controller.openAppStore,
                            ),
                            _aboutDivider(),
                            _AboutTile(
                              title: '反馈',
                              onTap: controller.openFeedback,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
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
                  style: _footerStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  '光跃潮汐 版权所有',
                  textAlign: TextAlign.center,
                  style: _footerStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  'Copyright © 2024-2026 GYCX. All Rights Reserved.',
                  textAlign: TextAlign.center,
                  style: _footerStyle.copyWith(
                    fontSize: 11,
                    color: ThemeColor.secondTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoMark() {
    return Container(
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
    );
  }

  Widget _aboutDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: ThemeColor.whiteColor.withOpacity(0.08),
    );
  }
}

class _AboutActionCard extends StatelessWidget {
  const _AboutActionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.doingListCellBgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
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
                  style: ThemeColor.white16Text,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: ThemeColor.trailingColor,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
