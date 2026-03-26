import 'package:youth/base/base_page.dart';

import 'city_select_controller.dart';

/// FileName: city_select_page
///
/// @Author 谌文
/// @Date 2026/3/26 18:30
///
/// @Description
class CitySelectPage extends BasePage<CitySelectController> {
    const CitySelectPage({Key? key}) : super(key: key);

    @override
     Widget build(BuildContext context) {
       return Scaffold(resizeToAvoidBottomInset: false,
           backgroundColor: ThemeColor.themeColor, appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
           body: Container(child: const Text("CitySelect"),),
       );
    }
}