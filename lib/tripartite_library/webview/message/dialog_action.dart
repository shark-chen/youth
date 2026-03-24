import 'package:flutter/cupertino.dart';

enum ActionType {
  /// 确定类型
  done,
  /// 取消类型
  cancel
}

class DialogAction {
  DialogAction({
    this.text,
    this.color,
    this.script,
    this.onPressed,
    this.fontSize = 14,
    this.actionType,
  });

  DialogAction.fromJson(dynamic json) {
    text = json["text"];
    color = json['color'];
    script = json['script'];
    fontSize = json['fontSize'];
  }

  String? text;
  String? color;
  String? script;
  num? fontSize;
  VoidCallback? onPressed;

  ActionType? actionType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = color;
    map['script'] = script;
    map['fontSize'] = fontSize;
    return map;
  }
}
