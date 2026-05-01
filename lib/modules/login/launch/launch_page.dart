import 'package:kellychat/modules/modules.dart';
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
        color: ThemeColor.themeColor,
        child: Column(
          children: [
            const SizedBox(height: 256),
            Image.asset(
              "assets/image/common/launch_screen@3x.png",
              width: screenWidth,
              height: 68,
            ),
            Expanded(child: Container()),

            /// 背景图
            Image.asset(
              "assets/image/common/login_bg@3x.png",
              width: screenWidth,
              height: 141,
            ),
          ],
        ),
      ),
    );
  }
}
