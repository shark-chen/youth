import 'package:youth/modules/modules.dart';
import '../../../base/base_page.dart';

/// FileName splash_page
///
/// @Author 谌文
/// @Date 2023/9/20 09:35
///
/// @Description 启动页页面
class LaunchPage extends BasePage<LaunchController> {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColor.themeColor,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 300, left: 12, right: 12),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  LocaleKeys.StartTips.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeColor.defaultBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
