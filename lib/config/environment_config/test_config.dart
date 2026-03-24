import 'config.dart';
import 'config_model.dart';

class TestConfig extends Config {
  TestConfig({this.configModel}) {
    configModel ??= ConfigModel(
      serverHost: "https://alpha.bigseller.pro",
      clientHost: "https://alpha-m-web.bigseller.pro",
      blogHost: "https://alpha.bigseller.pro",
    );
  }

  @override
  ConfigModel? configModel;

  @override
  Environment env() {
    return Environment.alpha;
  }

  @override
  String systemMessageUrl() {
    return "/web/info/system.htm";
  }

  @override
  String systemSettingUrl() {
    return "/web/sendImg/systemSet.htm";
  }

  String clientPort() {
    return "";
  }

  String serverPort() {
    return "";
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
