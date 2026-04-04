import 'config_model.dart';

enum Environment {
  /// 正式环境
  prod,

  /// 测试环境
  dev,

  /// alpha环境
  alpha,
}

/// 环境配置
Environment environment = Environment.dev;

abstract class Config {
  abstract ConfigModel? configModel;

  Environment env();

  String apiHost() {
    return configModel?.serverHost ?? "";
  }

  String clientHost() {
    return configModel?.clientHost ?? "";
  }

  String blogHost() {
    if (environment == Environment.prod) {
      return configModel?.blogHost ?? "";
    }
    return configModel?.clientHost ?? "";
  }

  String systemMessageUrl();

  String systemSettingUrl();

  String aboutUrl();

  String aboutBigSellerUrl();

  String blogUrl();

  String getUrl(String url);
}
