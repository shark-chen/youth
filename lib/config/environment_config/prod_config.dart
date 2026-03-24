import 'package:youth/config/environment_config/config.dart';
import 'config_model.dart';

class ProdConfig extends Config {
  ProdConfig({this.configModel}) {
    configModel ??= ConfigModel(
      serverHost: "https://www.bigseller.pro",
      clientHost: "https://m-web.bigseller.pro",
      blogHost: "https://blog.tongpaidang.com",
    );
  }

  @override
  ConfigModel? configModel;

  @override
  Environment env() {
    return Environment.prod;
  }

  @override
  String systemMessageUrl() {
    return "/web/info/system.htm";
  }

  @override
  String systemSettingUrl() {
    return "/web/sendImg/systemSet.htm";
  }

  @override
  String aboutUrl() {
    return "/web/sendImg/about.htm?type=2";
  }

  @override
  String aboutBigSellerUrl() {
    return "/web/sendImg/about.htm?type=1";
  }

  @override
  String blogUrl() {
    return "/blog/index.htm";
  }

  @override
  String getUrl(String url) {
    if (url.startsWith('/')) {
      url = url.replaceFirst('/', '');
    }
    return url.contains("http") ? url : "${clientHost()}/$url";
  }
}
