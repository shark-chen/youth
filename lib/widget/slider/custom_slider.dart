import 'package:flutter/material.dart';
import '../../utils/extension/text_styles.dart';
import '../../utils/utils/theme_color.dart';

/// FileName custom_slider
///
/// @Author 谌文
/// @Date 2025/6/26 10:32
///
/// @Description 滚动取值组件
// ignore: must_be_immutable
class CustomSlider extends StatefulWidget {
  CustomSlider({
    required this.sliderValue,
    required this.sliderMin,
    required this.sliderMax,
    required this.divisions,
    required this.decimalPlaces,
    required this.labels,
    this.valueCall,
  });

  /// 滑动值，默认值
  double sliderValue = 5.0;

  /// 滑动值，最小值
  double sliderMin = 0.0;

  /// 滑动值，最大值
  double sliderMax = 10.0;

  /// 间隔值
  int divisions = 10;

  /// 小数点位数
  int decimalPlaces = 0;

  /// 底部卡标内容
  List<String> labels;

  /// 选择值回调
  ValueChanged<double>? valueCall;

  @override
  _CustomSliderState createState() => _CustomSliderState(
        sliderValue,
        sliderMin,
        sliderMax,
        divisions,
        decimalPlaces,
        labels,
        valueCall,
      );
}

class _CustomSliderState extends State<CustomSlider> {
  _CustomSliderState(
    this._sliderValue,
    this._sliderMin,
    this._sliderMax,
    this._divisions,
    this._decimalPlaces,
    this._labels,
    this._valueCall,
  );

  /// 滑动值，默认值
  double _sliderValue = 5.0;

  /// 滑动值，最小值
  double _sliderMin = 0.0;

  /// 滑动值，最大值
  double _sliderMax = 10.0;

  /// 间隔值
  int _divisions = 10;

  /// 底部卡标内容
  List<String> _labels;

  /// 选择值回调
  ValueChanged<double>? _valueCall;

  /// 小数点位数
  int _decimalPlaces = 0;

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// 当外部的 sliderValue 发生变化时，更新内部状态
    if (widget.sliderValue != oldWidget.sliderValue) {
      setState(() {
        _sliderValue = widget.sliderValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Slider(
          value: _sliderValue,
          min: _sliderMin,
          max: _sliderMax,
          divisions: _divisions,
          label: '${_sliderValue.toStringAsFixed(_decimalPlaces)}s',
          onChanged: (double value) {
            _valueCall?.call(value);
            setState(() {
              _sliderValue = value;
            });
          },
          activeColor: ThemeColor.blueBtnColor,
          inactiveColor: ThemeColor.gradeFiveGreyColor,
          thumbColor: ThemeColor.whiteColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 32),
          child: Transform.scale(
            scale: 0.89,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_labels.length, (index) {
                return Text(
                  _labels[index],
                  style: TextStyles(color: ThemeColor.secondaryTextColor),
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}
