import 'package:kellychat/base/base_stateless_widget.dart';

/// 一起做按钮状态
enum TogetherButtonStatus {
  /// 可用（可发起或加入）
  available,

  /// 置灰（对方已有连接，或自己已有其他连接）
  disabled,

  /// 已连接（显示取消）
  connected,
}

/// FileName: doing_list_cell
///
/// @Author 谌文
/// @Date 2026/3/9 23:41
///
/// @Description 正在做的清单-cell（同频用户卡片）
class DoingListCell extends BaseStatelessWidget {
  const DoingListCell({
    Key? key,
    this.headerIcon,
    this.name,
    this.sex,
    this.address,
    this.age,
    this.signature,
    this.isOnline = false,
    this.togetherStatus = TogetherButtonStatus.available,
    this.onKnockTap,
    this.onTogetherTap,
    this.onTap,
  }) : super(key: key);

  /// 头像 URL
  final String? headerIcon;

  /// 昵称
  final String? name;

  /// `true` 男 · `false` 女 · `null` 不展示性别标
  final bool? sex;

  /// 年龄展示文案（如 `33`）
  final String? age;

  /// 地区（如 `深圳`）
  final String? address;

  /// 简介 / 状态一行
  final String? signature;

  /// 头像右下角在线绿点
  final bool isOnline;

  /// 一起做按钮状态
  final TogetherButtonStatus togetherStatus;

  final VoidCallback? onKnockTap;
  final VoidCallback? onTogetherTap;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    final ageLoc = [
      if (Strings.isNotEmpty(age)) '$age岁',
      if (Strings.isNotEmpty(address)) address,
    ].join('·');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: ThemeColor.doingListCellBgColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Avatar(url: headerIcon ?? '', showOnlineDot: isOnline),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ThemeColor.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (sex != null) ...[
                        const SizedBox(width: 4),
                        Icon(
                          sex == true ? Icons.male : Icons.female,
                          size: 18,
                          color: sex == true
                              ? const Color(0xFF5AC8FA)
                              : const Color(0xFFFF2D55),
                        ),
                      ],
                    ],
                  ),
                  if (ageLoc.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      ageLoc,
                      style: const TextStyle(
                        color: ThemeColor.doingListSubLabelColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                  if (Strings.isNotEmpty(signature)) ...[
                    const SizedBox(height: 4),
                    Text(
                      signature!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ThemeColor.doingListBioLabelColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PillButton(
                  label: '敲一下',
                  background: ThemeColor.doingListKnockBgColor,
                  foreground: ThemeColor.themeGreenColor,
                  onTap: onKnockTap,
                ),
                const SizedBox(height: 8),
                _buildTogetherButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTogetherButton() {
    switch (togetherStatus) {
      case TogetherButtonStatus.disabled:
        return _PillButton(
          label: '一起做',
          background: const Color(0xFF3A3A3C),
          foreground: Colors.white.withOpacity(0.4),
          onTap: null,
        );
      case TogetherButtonStatus.connected:
        return _PillButton(
          label: '取消',
          background: const Color(0xFFFF3B30),
          foreground: Colors.white,
          onTap: onTogetherTap,
        );
      case TogetherButtonStatus.available:
      default:
        return _PillButton(
          label: '一起做',
          background: ThemeColor.doingListTogetherBgColor,
          foreground: Colors.white,
          onTap: onTogetherTap,
        );
    }
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.showOnlineDot});

  final String url;
  final bool showOnlineDot;

  @override
  Widget build(BuildContext context) {
    const size = 52.0;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Strings.isNotEmpty(url)
                ? Image.network(
                    url,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(size),
                  )
                : _placeholder(size),
          ),
          if (showOnlineDot)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: ThemeColor.themeGreenColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThemeColor.doingListCellBgColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _placeholder(double size) {
    return Container(
      width: size,
      height: size,
      color: const Color(0xFF48484A),
      alignment: Alignment.center,
      child: const Icon(Icons.person, color: Colors.white38, size: 28),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.background,
    required this.foreground,
    this.onTap,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(minWidth: 72),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
