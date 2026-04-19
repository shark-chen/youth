/// 举报理由分组与选项（静态配置）
class ReportReasonItem {
  const ReportReasonItem({
    required this.id,
    required this.label,
  });

  final String id;
  final String label;
}

class ReportReasonSection {
  const ReportReasonSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<ReportReasonItem> items;
}

class ReportReasonData {
  ReportReasonData._();

  /// 根据 `id` 查找举报项文案（用于举报证据页展示）
  static String? labelForReasonId(String id) {
    for (final s in sections) {
      for (final it in s.items) {
        if (it.id == id) return it.label;
      }
    }
    return null;
  }

  /// 举报大类，对应接口字段 `reportType`（与 [sections] 分组顺序一致：0 用户违规 / 1 不良风气 / 2 其他）
  static int reportTypeForReasonId(String id) {
    for (var i = 0; i < sections.length; i++) {
      for (final it in sections[i].items) {
        if (it.id == id) return i;
      }
    }
    return 0;
  }

  static const List<ReportReasonSection> sections = [
    ReportReasonSection(
      title: '用户违规',
      items: [
        ReportReasonItem(id: 'porn', label: '色情低俗'),
        ReportReasonItem(id: 'political', label: '政治敏感'),
        ReportReasonItem(id: 'fraud', label: '涉嫌欺诈'),
        ReportReasonItem(id: 'abuse', label: '谩骂嘲讽'),
        ReportReasonItem(id: 'discrimination', label: '歧视'),
        ReportReasonItem(id: 'cyberbullying', label: '网络暴力'),
        ReportReasonItem(id: 'impersonation', label: '冒充他人'),
        ReportReasonItem(id: 'illegal', label: '违法违规'),
      ],
    ),
    ReportReasonSection(
      title: '不良风气',
      items: [
        ReportReasonItem(id: 'minor', label: '涉及未成年不当内容'),
        ReportReasonItem(id: 'public_order', label: '违反公德良序'),
        ReportReasonItem(id: 'safety', label: '危害人身安全'),
      ],
    ),
    ReportReasonSection(
      title: '其他',
      items: [
        ReportReasonItem(id: 'other', label: '其他违规类型'),
      ],
    ),
  ];
}
