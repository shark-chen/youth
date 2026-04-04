// import 'package:gd_sphere/impl/sphere_impl.dart';
import 'dart:ui';

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
      backgroundColor: ThemeColor.themeColor,
      body: Stack(
        children: [
          /// 背景图
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1538370965046-79c0d6907d47',
              fit: BoxFit.cover,
            ),
          ),

          /// 渐变遮罩（关键）
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          /// 内容
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 顶部
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "正在",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 46),
                    ],
                  ),
                ),


                Spacer(),
                /// 标题
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "选择你正在做的事",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "找到同频的人～",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// 按钮区域
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.5,
                      children: const [
                        TagItem("🍚", "干饭"),
                        TagItem("📖", "看书"),
                        TagItem("🎬", "看电影"),
                        TagItem("🎮", "打游戏"),
                        TagItem("🏃", "运动"),
                        TagItem("☕", "喝咖啡"),
                        TagItem("🎆", "听演唱会"),
                        TagItem("❓", "发呆"),
                        TagItem("👶", "带娃"),
                        TagItem("💼", "工作"),
                      ],
                    ),
                  ),
                ),

                InputAiWidget(hint: '输入你正在做的事…'),
                SizedBox(height: 12)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 胶囊按钮
class TagItem extends StatelessWidget {
  final String icon;
  final String text;

  const TagItem(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}