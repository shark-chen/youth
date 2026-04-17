import 'package:flutter/services.dart';
import 'package:youth/base/base_stateless_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// 邀请好友一起做 — 底部弹层内容（与 [showModalBottomSheet] / [BottomAlert.alerts] 搭配）
///
/// 关闭：`closeTap` 或 `Navigator.pop`
class InviteTogetherSheetWidget extends BaseStatelessWidget {
  const InviteTogetherSheetWidget({
    super.key,
    this.inviteCode = '666 999 333',
    this.shareLink,
    this.closeTap,
    this.onCopyCode,
    this.onWeChatTap,
    this.onCopyLinkTap,
  });

  /// 展示用口令文案（不含「口令：」前缀也可，内部会加前缀）
  final String inviteCode;

  /// 复制链接用；为空时复制按钮仍可回调，由外部决定
  final String? shareLink;

  final VoidCallback? closeTap;

  /// 点击口令区复制；未实现时默认复制 [inviteCode] 到剪贴板
  final VoidCallback? onCopyCode;

  final VoidCallback? onWeChatTap;

  final VoidCallback? onCopyLinkTap;

  static const Color _weChatGreen = Color(0xFF07C160);

  Future<void> _defaultCopyCode() async {
    await Clipboard.setData(ClipboardData(text: inviteCode.replaceAll(' ', '')));
    EasyLoading.showToast('复制成功');
  }

  Future<void> _defaultCopyLink() async {
    final link = shareLink ?? '';
    if (link.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: link));
    EasyLoading.showToast('复制成功');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            color: ThemeColor.textBlackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 8, 12, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      '邀请好友一起做',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColor.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: IconButton(
                      onPressed: closeTap,
                      icon: Icon(
                        Icons.close,
                        color: ThemeColor.whiteColor.withOpacity(0.9),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '好友通过口令或链接可与你建立一起做的状态。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColor.whiteColor.withOpacity(0.55),
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 24),
              _buildCodePill(context),
              const SizedBox(height: 28),
              _buildShareRow(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodePill(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: ThemeColor.whiteColor.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '口令： $inviteCode',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (onCopyCode != null) {
                onCopyCode!();
              } else {
                _defaultCopyCode();
              }
            },
            icon: Icon(
              Icons.copy_outlined,
              color: ThemeColor.whiteColor.withOpacity(0.85),
              size: 22,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildShareRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _shareAction(
          icon: FaIcon(
            FontAwesomeIcons.weixin,
            color: ThemeColor.whiteColor,
            size: 26,
          ),
          iconBackground: _weChatGreen,
          label: '微信好友',
          onTap: onWeChatTap,
        ),
        _shareAction(
          icon: Icon(
            Icons.link,
            color: const Color(0xFF5AC8FA),
            size: 26,
          ),
          iconBackground: ThemeColor.doingListCellBgColor,
          label: '复制链接',
          onTap: () {
            if (onCopyLinkTap != null) {
              onCopyLinkTap!();
            } else {
              _defaultCopyLink();
            }
          },
        ),
      ],
    );
  }

  Widget _shareAction({
    required Widget icon,
    required Color iconBackground,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: icon,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: ThemeColor.whiteColor.withOpacity(0.9),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
