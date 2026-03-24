import 'package:flutter/cupertino.dart';
import '../utils/extension/strings/strings.dart';
export 'package:flutter/cupertino.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:get/get.dart';
export '../../../../../../generated/locales.g.dart';

/// FileName base_service
///
/// @Author 谌文
/// @Date 2023/11/16 20:32
///
/// @Description 基础服务
abstract class BaseService {
  BaseService() {
    onInit();
  }

  /// MARK - 键盘相关
  /// 键盘监控
  TextEditingController? editingController;
  GlobalKey? textFormKey;
  FocusNode focusNode = FocusNode();

  /// 是否正在请求中
  bool requesting = false;

  void onInit() {}

  void initialize() {}

  /// 编辑框选中内容
  void editSelection({bool? select = false}) {
    focusNode.addListener(() {
      if (focusNode.hasFocus || select == true) {
        if(Strings.isNotEmpty(editingController?.text)) {
          editingController?.selection = TextSelection(
              baseOffset: 0, extentOffset: editingController?.text.length ?? 0);
        }
      }
    });
  }
}
