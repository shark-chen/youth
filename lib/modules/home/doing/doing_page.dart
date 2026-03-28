// import 'package:gd_sphere/impl/sphere_impl.dart';
import 'package:youth/base/base_page.dart';
import 'package:youth/widget/input/sure_input/input_sure.dart';
import '../hall/view/input_ai_view.dart';
import 'doing_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// FileName: doing_page
///
/// @Author 谌文
/// @Date 2026/3/9 14:11
///
/// @Description
class DoingPage extends BasePage<DoingController> {
  const DoingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        backgroundColor: ThemeColor.themeColor,
        textColor: ThemeColor.whiteColor,
        leading: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ThemeColor.whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '头像',
            style: TextStyles(),
          ),
        ),
        '正在',
        elevation: 0.2,
      ),
      body: GestureDetector(
        onTap: controller.pushDoingListPage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// info
            Text(
              '选择你正在做的事，找到同频的人',
              style: TextStyles(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ThemeColor.whiteColor,
              ),
            ),


            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('UI')),
              ],
            ),


            /// 底部输入框
            InputAiWidget(hint: '输入你正在做的事…'),

            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

// class AdvancedRandomBubbleWall extends StatefulWidget {
//   @override
//   _AdvancedRandomBubbleWallState createState() =>
//       _AdvancedRandomBubbleWallState();
// }
//
// class _AdvancedRandomBubbleWallState extends State<AdvancedRandomBubbleWall>
//     with TickerProviderStateMixin {
//   late List<AnimationController> _controllers;
//   late List<Animation<double>> _yAnimations;
//   late List<Animation<double>> _xAnimations;
//   late List<BubblePosition> _positions;
//   final Random _random = Random();
//
//   List<BubbleData> bubbles = [
//     BubbleData(icon: Icons.music_note, text: '听音乐', color: Colors.pink.shade50),
//     BubbleData(icon: Icons.movie, text: '看电影', color: Colors.blue.shade50),
//     BubbleData(icon: Icons.menu_book, text: '看书', color: Colors.green.shade50),
//     BubbleData(
//         icon: Icons.sports_soccer, text: '运动', color: Colors.orange.shade50),
//     BubbleData(
//         icon: Icons.sports_esports, text: '打游戏', color: Colors.purple.shade50),
//     BubbleData(icon: Icons.restaurant, text: '干饭', color: Colors.red.shade50),
//     BubbleData(
//         icon: Icons.photo_camera, text: '拍照', color: Colors.teal.shade50),
//     BubbleData(
//         icon: Icons.local_cafe, text: '喝咖啡', color: Colors.brown.shade50),
//     BubbleData(icon: Icons.work, text: '工作', color: Colors.grey.shade200),
//     BubbleData(icon: Icons.mic, text: '听演唱会', color: Colors.indigo.shade50),
//     BubbleData(
//         icon: Icons.child_care, text: '带娃', color: Colors.yellow.shade100),
//     BubbleData(
//         icon: Icons.emoji_emotions, text: '发呆', color: Colors.cyan.shade50),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // 初始化随机位置 - 确保分布均匀但有重叠
//     _positions = List.generate(bubbles.length, (index) {
//       return BubblePosition(
//         left: _random.nextDouble() * 0.85,
//         top: _random.nextDouble() * 0.85,
//         scale: 0.8 + _random.nextDouble() * 0.7,
//         xOffset: _random.nextDouble() * 2 - 1,
//         // -1 到 1
//         yOffset: _random.nextDouble() * 2 - 1,
//         rotation: _random.nextDouble() * 0.1 - 0.05, // -0.05 到 0.05 弧度
//       );
//     });
//
//     // 初始化动画控制器 - 每个气泡有独立的动画参数
//     _controllers = List.generate(bubbles.length, (index) {
//       return AnimationController(
//         duration: Duration(milliseconds: 2000 + _random.nextInt(2000)),
//         vsync: this,
//       )..repeat(reverse: true);
//     });
//
//     // Y轴浮动动画
//     _yAnimations = List.generate(bubbles.length, (index) {
//       return Tween<double>(begin: -8.0, end: 8.0).animate(
//         CurvedAnimation(
//           parent: _controllers[index],
//           curve: Curves.easeInOut,
//         ),
//       );
//     });
//
//     // X轴微摆动动画
//     _xAnimations = List.generate(bubbles.length, (index) {
//       return Tween<double>(begin: -3.0, end: 3.0).animate(
//         CurvedAnimation(
//           parent: _controllers[index],
//           curve: Curves.easeInOutSine,
//         ),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '选择你正在做的事，',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   Text(
//                     '找到同频的人',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '15',
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 child: Stack(
//                   children: List.generate(bubbles.length, (index) {
//                     return AnimatedBuilder(
//                       animation: _controllers[index],
//                       builder: (context, child) {
//                         return Positioned(
//                           left: size.width * _positions[index].left +
//                               _xAnimations[index].value *
//                                   _positions[index].xOffset,
//                           top: (size.height * 0.6 - 100) *
//                                   _positions[index].top +
//                               _yAnimations[index].value *
//                                   _positions[index].yOffset,
//                           child: Transform.rotate(
//                             angle: _positions[index].rotation,
//                             child: Transform.scale(
//                               scale: _positions[index].scale,
//                               child: child,
//                             ),
//                           ),
//                         );
//                       },
//                       child: _buildBubble(bubbles[index]),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBubble(BubbleData data) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: data.color ?? Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             data.icon,
//             size: 18,
//             color: Colors.black87,
//           ),
//           SizedBox(width: 6),
//           Text(
//             data.text,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BubbleData {
//   final IconData icon;
//   final String text;
//   final Color? color;
//
//   BubbleData({required this.icon, required this.text, this.color});
// }
//
// class BubblePosition {
//   final double left;
//   final double top;
//   final double scale;
//   final double xOffset;
//   final double yOffset;
//   final double rotation;
//
//   BubblePosition({
//     required this.left,
//     required this.top,
//     required this.scale,
//     this.xOffset = 1.0,
//     this.yOffset = 1.0,
//     this.rotation = 0.0,
//   });
// }
