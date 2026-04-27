// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:kellychat/modules/routes/app_pages.dart';
import '../../../utils/utils/model_utils.dart';

class GoPageMessageModel {
  //路由跳转地址
  String? pageName;

  //是否删除之前的路由
  bool? deleteOtherRoutes;

  /// 消息类型
  String? actionType;

  //路由携带参数
  Map<String, String>? params;

  GoPageMessageModel({
    this.pageName = Routes.homePage,
    this.deleteOtherRoutes = false,
    this.params,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pageName': pageName,
      'deleteOtherRoutes': deleteOtherRoutes,
      'params': params,
    };
  }

  GoPageMessageModel.fromMap(dynamic map) {
    pageName = map['pageName'] ?? Routes.homePage;
    if(pageName == 'main') {
      pageName = Routes.homePage;
    }
    deleteOtherRoutes = map['deleteOtherRoutes'] ?? false;
    actionType = ModelUtils.convert<String>(map['actionType']) ?? '';
    Map<String, String> res = {};
    (map['params'] as Map).forEach((key, value) {
      if (value != null) {
        res.putIfAbsent(key, () => value.toString());
      }
    });
    params = res;
  }

  String toJson() => json.encode(toMap());

  factory GoPageMessageModel.fromJson(String source) {
    return GoPageMessageModel.fromMap(json.decode(source));
  }
}
