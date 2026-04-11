import 'config.dart';
import 'config_model.dart';

class DevConfig extends Config {
  DevConfig({this.configModel}) {
    configModel ??= ConfigModel(
      serverHost: "https://api.onemayy.com",
      // serverHost: "http://localhost:8080",
      // serverHost: 'https://bs8-priv-www.meiyunji.net',
      clientHost:'https://bs8-priv-www.meiyunji.net',
      blogHost: 'https://bs8-priv-www.meiyunji.net',
    );
  }

  @override
  ConfigModel? configModel;

  @override
  Environment env() {
    return Environment.dev;
  }

  @override
  String systemMessageUrl() {
    return "/#/web/info/system.htm";
  }

  @override
  String systemSettingUrl() {
    return "/#/web/sendImg/systemSet.htm";
  }

  @override
  String aboutUrl() {
    return "/#/web/sendImg/about.htm?type=2";
  }

  @override
  String aboutBigSellerUrl() {
    return "/#/web/sendImg/about.htm?type=1";
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
