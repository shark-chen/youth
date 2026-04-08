import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:youth/app.dart';
import 'package:youth/utils/utils/language/language_utils.dart';
import 'base/base_stateless_widget.dart';
import 'config/environment_config/app_config.dart';
import 'network/reporter/report_util.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initSystem();
      PlatformDispatcher.instance.onError = (error, stackTrace) {
        return true;
      };

      /// 捕获在 Flutter 上下文之外发生的错误
      Isolate.current
          .addErrorListener(RawReceivePort((pair) async {}).sendPort);

      /// 存储语种
      /// 存储类
      try {
        /// 获取APP的语言
        Locale? locale = await LanguageUtils.appLocale;
        var app = App(locale: locale);
        runApp(app);
        WidgetsBinding.instance.addObserver(app);
      } catch (e) {
        ReportUtil().record('Stores.initDeviceLat()$e');
      }
    },
    (error, stackTrace) {},
  );
}

/// 启动项
initSystem() {
  /// 环境配置
  AppConfig.init();
}
