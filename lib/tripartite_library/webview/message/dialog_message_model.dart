import 'package:youth/base/base_controller.dart';

class DialogMessageModel {
  DialogMessageModel({
    this.title = "",
    this.contentBackground = Colors.transparent,
    this.contentColor = "#303336",
    this.contentList,
    this.titleFontSize = 16,
    this.titleFontWeight = FontWeight.w600,
    this.contentFontSize = 14,
    this.contentMargin = 4,
    this.type = "normal",
    this.dismissTime = 0,
    this.actions,
    this.contentAlign = "left",
    this.cupertinoDialog = true,
    this.customWidget,
  });

  DialogMessageModel.fromJson(dynamic json) {
    title = json['title'];
    contentMargin = json['contentMargin']??4;
    contentAlign = json['contentAlign']??"left";
    contentList =
        json['contentList'] != null ? json['contentList'].cast<String>() : [];
    titleFontSize = json['titleFontSize'];
    contentColor = json['contentColor'];
    // background = json['background'];
    contentBackground = hexToColor(json['contentBackground']);
    contentFontSize = json['contentFontSize'];
    dismissTime = json["dismissTime"]??0;
    type = json['type'];
    if (json['actions'] != null) {
      actions = [];
      json['actions'].forEach((v) {
        actions!.add(DialogAction.fromJson(v));
      });
    }
  }

  String? title;

  /// 自定义标题view
  Widget? customWidget;

  //String? background;
  List<String?>? contentList;
  num? titleFontSize;
  FontWeight? titleFontWeight;
  num? contentFontSize;
  Color? contentBackground;
  String? contentColor;
  String? type;
  int? dismissTime;
  List<DialogAction>? actions;
  num? contentMargin;
  String? contentAlign;
  bool? cupertinoDialog;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['contentMargin'] = contentMargin;
    map['contentAlign'] = contentAlign;
    map['contentList'] = contentList;
    map['titleFontSize'] = titleFontSize;
    map['contentFontSize'] = contentFontSize;
    map['contentColor'] = contentColor;
    map['contentBackground'] = contentBackground;
    //map['background'] = background;
    map['type'] = type;
    map['dismissTime'] = dismissTime;
    if (actions != null) {
      map['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
