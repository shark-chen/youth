import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/widget/fly_toast/fly_toast_util.dart';

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
class DoingListCell extends StatefulWidget {
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

  /// 敲一下 点击；参数为按钮在屏幕上的中心点（可为 null）
  final Future<void> Function(Offset? knockButtonCenter)? onKnockTap;

  /// 一起做点击
  final VoidCallback? onTogetherTap;

  /// 点击 卡片
  final VoidCallback? onTap;

  @override
  State<DoingListCell> createState() => _DoingListCellState();
}

class _DoingListCellState extends State<DoingListCell>
    with TickerProviderStateMixin {
  static const Duration _knockScaleDuration = Duration(milliseconds: 140);
  static const Duration _shakeDuration = Duration(milliseconds: 150);

  late final AnimationController _knockScaleController;
  late final Animation<double> _knockScale;
  late final AnimationController _shakeController;
  late final Animation<double> _shakeOffset;

  final GlobalKey _knockButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _knockScaleController = AnimationController(
      vsync: this,
      duration: _knockScaleDuration,
    );
    _knockScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0.88),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.88, end: 1),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _knockScaleController,
        curve: Curves.easeOut,
      ),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: _shakeDuration,
    );
    _shakeOffset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 6), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 6, end: -4), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: -4, end: 2), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 2, end: 0), weight: 25),
    ]).animate(_shakeController);
  }

  @override
  void dispose() {
    _knockScaleController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _onKnockTap() async {
    if (widget.onKnockTap == null) return;
    final center = FlyToastUtil.globalCenterFromKey(_knockButtonKey);
    _knockScaleController.forward(from: 0);
    _shakeController.forward(from: 0);
    await widget.onKnockTap!(center);
  }

  @override
  Widget build(BuildContext context) {
    final ageLoc = [
      if (Strings.isNotEmpty(widget.age)) '${widget.age}岁',
      if (Strings.isNotEmpty(widget.address)) widget.address,
    ].join('·');

    return AnimatedBuilder(
      animation: Listenable.merge([_shakeController, _knockScaleController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeOffset.value, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
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
              ImageLookWidget(
                imgUrl: widget.headerIcon ?? '',
                width: 52,
                height: 52,
                heroTag: '${widget.headerIcon ?? ''}_$ageLoc',
                imgBorderRadius: BorderRadius.circular(999),
                borderColor: Colors.transparent,
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
                            widget.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ThemeColor.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (widget.sex != null) ...[
                          const SizedBox(width: 4),
                          Icon(
                            widget.sex == true ? Icons.male : Icons.female,
                            size: 18,
                            color: widget.sex == true
                                ? ThemeColor.maleIconColor
                                : ThemeColor.femaleIconColor,
                          ),
                        ],
                      ],
                    ),
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
                    if (Strings.isNotEmpty(widget.signature)) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.signature ?? '',
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: _knockScale.value,
                    child: KeyedSubtree(
                      key: _knockButtonKey,
                      child: _PillButton(
                        label: '敲一下',
                        background: ThemeColor.doingListKnockBgColor,
                        foreground: ThemeColor.themeGreenColor,
                        onTap: _onKnockTap,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTogetherButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTogetherButton() {
    switch (widget.togetherStatus) {
      case TogetherButtonStatus.disabled:
        return _PillButton(
          label: '一起做',
          background: ThemeColor.white15Color,
          foreground: ThemeColor.white6Color,
          onTap: widget.onTogetherTap,
        );
      case TogetherButtonStatus.connected:
        return _PillButton(
          label: '取消',
          background: ThemeColor.bloodRedColor,
          foreground: Colors.white,
          onTap: widget.onTogetherTap,
        );
      case TogetherButtonStatus.available:
      default:
        return _PillButton(
          label: '一起做',
          background: ThemeColor.white15Color,
          foreground: Colors.white,
          onTap: widget.onTogetherTap,
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
