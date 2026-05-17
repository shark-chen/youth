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

  /// 敲一下 点击
  final VoidCallback? onKnockTap;

  /// 一起做点击
  final VoidCallback? onTogetherTap;

  /// 点击 卡片
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
            /// 头像
            ImageLookWidget(
              imgUrl: headerIcon ?? '',
              width: 52,
              height: 52,
              heroTag: '${headerIcon ?? ''}_$ageLoc',
              imgBorderRadius: BorderRadius.circular(999),
              borderColor: Colors.transparent,
            ),
            const SizedBox(width: 12),

            /// 昵称 + 性别 + 地区
            /// 在列表上展示横版的用户资料卡片，资料卡片显示的信息有：头像、昵称、性别、年龄、地区、个人签名（最多一行，超出时用…省略）；
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
                              ? ThemeColor.maleIconColor
                              : ThemeColor.femaleIconColor,
                        ),
                      ],
                    ],
                  ),

                  /// 年龄 + 地址
                  if (ageLoc.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      ageLoc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ThemeColor.white75Color,
                        fontSize: 12,
                      ),
                    ),
                  ],

                  /// 简介
                  if (Strings.isNotEmpty(signature)) ...[
                    const SizedBox(height: 4),
                    Text(
                      signature ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ThemeColor.white4Color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),

            /// 敲一下
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

  /// 一起做的 || 取消 一起做
  Widget _buildTogetherButton() {
    switch (togetherStatus) {
      case TogetherButtonStatus.disabled:
        return _PillButton(
          label: '一起做',
          background: ThemeColor.white15Color,
          foreground: Colors.white,
          onTap: null,
        );
      case TogetherButtonStatus.connected:
        return _PillButton(
          label: '取消',
          background: ThemeColor.bloodRedColor,
          foreground: Colors.white,
          onTap: onTogetherTap,
        );
      case TogetherButtonStatus.available:
      default:
        return _PillButton(
          label: '一起做',
          background: ThemeColor.white15Color,
          foreground: Colors.white,
          onTap: onTogetherTap,
        );
    }
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
        borderRadius: BorderRadius.circular(999),
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
