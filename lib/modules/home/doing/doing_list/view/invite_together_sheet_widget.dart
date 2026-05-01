import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// 邀请好友一起做 — 底部弹层内容（与 [showModalBottomSheet] / [BottomAlert.alerts] 搭配）
///
/// 关闭：`closeTap` 或 `Navigator.pop`
class InviteTogetherSheetWidget extends BaseStatelessWidget {
  const InviteTogetherSheetWidget({
    super.key,
    this.inviteCode,
    this.shareLink,
    this.closeTap,
    this.onCopyCode,
    this.onWeChatTap,
    this.onCopyLinkTap,
  });

  /// 展示用口令文案（不含「口令：」前缀也可，内部会加前缀）
  final String? inviteCode;

  /// 复制链接用；为空时复制按钮仍可回调，由外部决定
  final String? shareLink;

  final VoidCallback? closeTap;

  /// 点击口令区复制；未实现时默认复制 [inviteCode] 到剪贴板
  final VoidCallback? onCopyCode;

  final VoidCallback? onWeChatTap;

  final VoidCallback? onCopyLinkTap;

  static const Color _weChatGreen = Color(0xFF07C160);

  Future<void> _defaultCopyCode() async {
    await Clipboard.setData(
        ClipboardData(text: inviteCode?.replaceAll(' ', '') ?? ''));
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
              GestureDetector(
                onTap: Get.back,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 48,
                    child: IconButton(
                      onPressed: closeTap,
                      icon: Icon(
                        Icons.close,
                        color: ThemeColor.whiteColor.withOpacity(0.4),
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '邀请好友一起做',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColor.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '好友通过口令或链接可与你建立一起做的状态。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColor.whiteColor.withOpacity(0.6),
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 32),
              _buildCodePill(context),
              const SizedBox(height: 32),
              _buildShareRow(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodePill(BuildContext context) {
    return Container(
      height: 49,
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: ThemeColor.whiteColor.withOpacity(0.12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '口令：',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColor.whiteColor.withOpacity(0.6),
              fontSize: 16,
            ),
          ),
          Text(
            '$inviteCode',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColor.whiteColor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: () {
              if (onCopyCode != null) {
                onCopyCode?.call();
              } else {
                _defaultCopyCode();
              }
            },
            icon: Image.asset(
              'assets/image/common/copy@3x.png',
              width: 20,
              height: 20,
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
          icon: Image.asset(
            'assets/image/common/we_chat@3x.png',
            width: 60,
            height: 60,
          ),
          iconBackground: _weChatGreen,
          label: '微信好友',
          onTap: onWeChatTap,
        ),
        _shareAction(
          icon: Image.asset(
            'assets/image/common/link@3x.png',
            width: 60,
            height: 60,
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: icon,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: ThemeColor.whiteColor.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
