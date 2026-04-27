import 'package:get/get.dart';
export 'package:get/get.dart';
import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export '../utils/utils/theme_color.dart';
export '../../../../../generated/locales.g.dart';
export '../../../../widget/appbar/appbar_kit.dart';
export '../utils/marco/marco.dart';
export '../../../../../tripartite_library/tripartite_library.dart';
export '../../../../../widget/widgets.dart';
export 'package:kellychat/utils/extension/text_styles.dart';
export 'package:kellychat/widget/space_widget/default_space_view.dart';
export 'package:kellychat/widget/button/icon_button/icon_button.dart';
export 'package:kellychat/widget/line_view/line_view.dart';

/// FileName base_page
///
/// @Author 谌文
/// @Date 2023/5/11 10:12
///
/// @Description 基础page类
typedef RouterCallback = Widget Function();

/// 路由类型
enum RouteType { didPopNext, didPush, didPop, didPushNext }

abstract class BasePage<T> extends GetView<T>  with WidgetsBindingObserver {
  const BasePage({super.key});
}