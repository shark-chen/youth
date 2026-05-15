import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: message_doing_header_view
///
/// @Author 谌文
/// @Date 2026/5/15
///
/// @Description 消息页-正在做的事-头部卡片
class MessageDoingHeaderView extends BaseStatelessWidget {
  const MessageDoingHeaderView({
    Key? key,
    this.tagName,
    this.partnerName,
    this.onCancelTap,
  }) : super(key: key);

  /// 正在做的事名称
  final String? tagName;

  /// 伙伴昵称
  final String? partnerName;

  /// 取消点击
  final VoidCallback? onCancelTap;

  static const Color _mint = Color(0xFFB8F5D0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ThemeColor.themeGreenColor,
            _mint,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 顶部音频波形
            const _AudioWaveform(),

            /// 内容区
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  /// 图标 + 正在做的事
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tagName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ThemeColor.blackColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  /// 与[伙伴]一起
                  if (partnerName?.isNotEmpty == true)
                    Expanded(
                      child: Text(
                        '与[$partnerName]一起',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: ThemeColor.blackColor.withOpacity(0.5),
                        ),
                      ),
                    )
                  else
                    const Spacer(),

                  const SizedBox(width: 8),

                  /// 取消按钮
                  GestureDetector(
                    onTap: onCancelTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xE6000000),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Text(
                        '取消',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 音频波形动画
class _AudioWaveform extends StatefulWidget {
  const _AudioWaveform();

  @override
  State<_AudioWaveform> createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<_AudioWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<double> _heights;
  static const int _barCount = 40;

  @override
  void initState() {
    super.initState();
    _heights = List.generate(_barCount, (_) => _random.nextDouble());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )
      ..addListener(() {
        if (mounted) {
          setState(() {
            _heights = List.generate(
              _barCount,
              (index) {
                final base = 0.3 + (index / _barCount) * 0.5;
                final wave = sin(_controller.value * 2 * pi * 2 + index * 0.5);
                return (base + wave * 0.3).clamp(0.1, 1.0);
              },
            );
          });
        }
      })
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_barCount, (index) {
          final heightFactor = _heights[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 2,
            height: 6 + heightFactor * 20,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A).withOpacity(0.15),
              borderRadius: BorderRadius.circular(1),
            ),
          );
        }),
      ),
    );
  }
}
