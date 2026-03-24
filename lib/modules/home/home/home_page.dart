import '../../../base/base_page.dart';
import 'home_controller.dart';

/// FileName home_page
///
/// @Author 谌文
/// @Date 2023/12/18 15:37
///
/// @Description APP-home页
class HomePage extends BasePage<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller.vm.value.screenshotKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQueryData.fromView(View.of(context)).padding.top),
          child: const SafeArea(top: true, child: Offstage()),
        ),
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: controller.pages,
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Obx(
            () => BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ThemeColor.darkBlueColor,
              unselectedItemColor: ThemeColor.otherTextColor,
              selectedFontSize: 10.0,
              unselectedFontSize: 10.0,
              items: controller.vm.value.buildBarItems,
              currentIndex: controller.vm.value.currentTab.index,
              onTap: (index) => controller.switchTab(index),
            ),
          ),
        ),
      ),
    );
  }
}
