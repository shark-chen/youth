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
       return Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: ThemeColor.themeColor,
         body: SafeArea(
           child: Column(
             children: [
               const SizedBox(height: 28),
               Text(
                 '选择地区',
                 style: const TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.w700,
                   color: Colors.white,
                 ),
               ),
               const SizedBox(height: 10),
               Text(
                 '只在中国地区选择，最小到区/县级市',
                 style: TextStyle(
                   fontSize: 14,
                   color: Colors.white.withOpacity(0.6),
                 ),
               ),
               const SizedBox(height: 24),

               /// 顶部步骤条
               Obx(
                 () {
                   final p = controller.province.value?.name ?? '选择省';
                   final c = controller.city.value?.name ?? '选择市';
                   final a =
                       controller.area.value?.name ?? '选择区/县级市';

                   final level = controller.currentLevel;
                   final isProvince = level == 0;
                   final isCity = level == 1;
                   final isArea = level == 2;

                   Color activeColor = ThemeColor.themeGreenColor;
                   Color inactiveColor = ThemeColor.themeA2Color;

                   TextStyle tabStyle(bool active) => TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                         color: active ? activeColor : inactiveColor,
                       );

                   Widget tab(String text, bool active) => Expanded(
                         child: Container(
                           alignment: Alignment.center,
                           padding: const EdgeInsets.symmetric(vertical: 10),
                           decoration: BoxDecoration(
                             border: Border(
                               bottom: BorderSide(
                                 color: active ? activeColor : Colors.transparent,
                                 width: 2,
                               ),
                             ),
                           ),
                           child: Text(text, style: tabStyle(active)),
                         ),
                       );

                   return Row(
                     children: [
                       tab(p, isProvince),
                       tab(c, isCity),
                       tab(a, isArea),
                     ],
                   );
                 },
               ),

               const SizedBox(height: 10),

               Expanded(
                 child: Obx(
                   () {
                     if (controller.requesting.value) {
                       return const Center(
                         child: CircularProgressIndicator(
                           color: ThemeColor.themeGreenColor,
                         ),
                       );
                     }

                     if (controller.loadFailed.value) {
                       return Center(
                         child: Text(
                           controller.loadErrorMsg.value,
                           style: const TextStyle(
                             color: Colors.white,
                             fontSize: 14,
                           ),
                         ),
                       );
                     }

                     final list = controller.options;
                     return ListView.separated(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       itemCount: list.length,
                       separatorBuilder: (_, __) => const Divider(
                         height: 1,
                         color: Colors.white12,
                       ),
                       itemBuilder: (context, index) {
                         final item = list[index];

                        final bool selected = controller.currentLevel == 0
                            ? controller.province.value?.id == item.id
                            : controller.currentLevel == 1
                                ? controller.city.value?.id == item.id
                                : controller.area.value?.id == item.id;

                         return InkWell(
                           onTap: () {
                             if (controller.currentLevel == 0) {
                               controller.onTapProvince(item);
                               return;
                             }
                             if (controller.currentLevel == 1) {
                               controller.onTapCity(item);
                               return;
                             }
                             controller.onTapArea(item);
                           },
                           child: Container(
                             padding: const EdgeInsets.symmetric(vertical: 14),
                             child: Row(
                               children: [
                                 Expanded(
                                   child: Text(
                                     item.name,
                                     style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w600,
                                       color: selected
                                           ? ThemeColor.themeGreenColor
                                           : Colors.white.withOpacity(0.92),
                                     ),
                                   ),
                                 ),
                                 if (selected)
                                   Icon(
                                     Icons.check,
                                     color: ThemeColor.themeGreenColor,
                                   ),
                               ],
                             ),
                           ),
                         );
                       },
                     );
                   },
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                 child: Row(
                   children: [
                     Expanded(
                       child: SizedBox(
                         height: 48,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             backgroundColor:
                                 Colors.white.withOpacity(0.12),
                             foregroundColor: Colors.white,
                             elevation: 0,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24),
                             ),
                           ),
                           onPressed: controller.onTapBack,
                           child: const Text(
                             '上一个',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w600,
                             ),
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(width: 14),
                     Expanded(
                       child: SizedBox(
                         height: 48,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             backgroundColor: ThemeColor.themeGreenColor,
                             foregroundColor: Colors.black,
                             elevation: 0,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24),
                             ),
                           ),
                           onPressed: controller.selectedRegionText == null
                               ? null
                               : controller.onTapComplete,
                           child: const Text(
                             '完成',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       );
    }
}