import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// 重置私密密码确认（居中弹框）
///
/// 文案：重置密码将清空全部私密信息；取消 / 确定重置
class DialogAlertWidget extends StatefulWidget {
  const DialogAlertWidget({
    super.key,
    this.content,
    this.leftTitle,
    this.leftTitleColor,
    this.leftTitleBgColor,
    this.rightTitle,
    this.rightTitleColor,
    this.rightTitleBgColor,
    this.customContentWidget,
    this.leftTap,
    this.rightTap,
    this.rightCountdownSeconds,
  });

  /// 内容
  final String? content;

  /// 左侧按钮标题
  final String? leftTitle;

  /// 左边侧按钮标题颜色
  final Color? leftTitleColor;

  /// 左边侧按钮背景颜色
  final Color? leftTitleBgColor;

  /// 右侧按钮标题
  final String? rightTitle;

  /// 右侧侧按钮标题颜色
  final Color? rightTitleColor;

  /// 右侧按钮背景颜色
  final Color? rightTitleBgColor;

  /// 自定义内容widget
  final Widget? customContentWidget;

  /// 左边点击事件
  final VoidCallback? leftTap;

  /// 右边点击事件
  final VoidCallback? rightTap;

  /// 右侧按钮倒计时秒数；大于 0 时倒计时结束前不可点击且文案为 `rightTitle(剩余s)`
  final int? rightCountdownSeconds;

  @override
  State<DialogAlertWidget> createState() => _DialogAlertWidgetState();
}

class _DialogAlertWidgetState extends State<DialogAlertWidget> {
  Timer? _countdownTimer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    final total = widget.rightCountdownSeconds ?? 0;
    _remainingSeconds = total > 0 ? total : 0;
    if (_remainingSeconds > 0) {
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        if (_remainingSeconds <= 1) {
          _countdownTimer?.cancel();
          setState(() => _remainingSeconds = 0);
        } else {
          setState(() => _remainingSeconds--);
        }
      });
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  bool get _rightButtonEnabled => _remainingSeconds <= 0;

  String get _rightButtonLabel {
    final base = widget.rightTitle ?? '确定重置';
    if (_remainingSeconds > 0) {
      return '$base(${_remainingSeconds}s)';
    }
    return base;
  }

  Color get _rightBgColor {
    final base = widget.rightTitleBgColor ?? ThemeColor.dialogRedConfirmBgColor;
    return _rightButtonEnabled ? base : base.withOpacity(0.45);
  }

  Color get _rightTextColor {
    final base = widget.rightTitleColor ?? ThemeColor.whiteColor;
    return _rightButtonEnabled ? base : base.withOpacity(0.55);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            decoration: BoxDecoration(
              color: ThemeColor.dialogGraynessBgColor,
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '提示',
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                widget.customContentWidget ??
                    Text(
                      widget.content ?? '重置密码将清空你输入的全部私密信息。确定重置吗？',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColor.whiteColor.withOpacity(0.92),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Visibility(
                      visible: Strings.isNotEmpty(widget.leftTitle),
                      child: Expanded(
                        child: _PillButton(
                          label: widget.leftTitle ?? '取消',
                          backgroundColor: widget.leftTitleBgColor ??
                              ThemeColor.doingListTogetherBgColor,
                          textColor:
                              widget.leftTitleColor ?? ThemeColor.whiteColor,
                          onTap: widget.leftTap,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Strings.isNotEmpty(widget.leftTitle),
                      child: const SizedBox(width: 12),
                    ),
                    Expanded(
                      child: _PillButton(
                        label: _rightButtonLabel,
                        backgroundColor: _rightBgColor,
                        textColor: _rightTextColor,
                        enabled: _rightButtonEnabled,
                        onTap: widget.rightTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.enabled = true,
    this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          height: 46,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
