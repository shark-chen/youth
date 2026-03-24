import 'dart:ui';
import 'package:get/get.dart';
import 'package:youth/generated/locales.g.dart';
import 'package:youth/tripartite_library/pull_to_refresh/refresher_header.dart';

/// FileName: refresher_footer
///
/// @Author 谌文
/// @Date 2025/12/10 14:44
///
/// @Description 刷新请求尾
class RefresherFooter {
  static ClassicFooter build({Color? iconColor}) {
    return ClassicFooter(
      loadingText: LocaleKeys.Loading.tr,
      noDataText: LocaleKeys.NoMore.tr,
      idleText: '下拉刷新',
      failedText: '刷新失败',
      canLoadingText: ' ',
      height: 80.0,
      loadStyle: LoadStyle.ShowWhenLoading,
    );
  }
}
