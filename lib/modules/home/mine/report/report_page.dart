import 'package:youth/base/base_page.dart';

import 'model/report_reason_data.dart';
import 'report_controller.dart';

/// FileName: report_page
///
/// @Author 谌文
/// @Date 2026/4/19
///
/// @Description 举报理由（分组列表）
class ReportPage extends BasePage<ReportController> {
  const ReportPage({Key? key}) : super(key: key);

  static const double _cardRadius = 14;

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
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var s = 0; s < ReportReasonData.sections.length; s++) ...[
              if (s > 0) const SizedBox(height: 20),
              _section(
                ReportReasonData.sections[s],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _section(ReportReasonSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: TextStyle(
            color: ThemeColor.secondaryTextColor,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: ThemeColor.doingListCellBgColor,
            borderRadius: BorderRadius.circular(_cardRadius),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < section.items.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: ThemeColor.whiteColor.withOpacity(0.06),
                  ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () =>
                        controller.onSelectReason(section.items[i]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              section.items[i].label,
                              style: TextStyle(
                                color: ThemeColor.whiteColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: ThemeColor.secondaryTextColor,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
