class ViewChangeMessageModel {
  ViewChangeMessageModel({
      this.showBottom,
      this.showTop,
      this.bottom,
      this.top,});

  ViewChangeMessageModel.fromJson(dynamic json) {
    showBottom = json['showBottom']??false;
    showTop = json['showTop']??false;
    bottom = json['bottom']??108;
    top = json['top']??120;
  }
  bool? showBottom;
  bool? showTop;
  num? bottom;
  num? top;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['showBottom'] = showBottom;
    map['showTop'] = showTop;
    map['bottom'] = bottom;
    map['top'] = top;
    return map;
  }

}