// import 'package:gd_sphere/impl/sphere_impl.dart';
import 'dart:math';

import 'package:kellychat/base/base_page.dart';
import '../hall/view/input_ai_view.dart';
import 'doing_controller.dart';
import 'view/hot_tag_cell.dart';

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
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        backgroundColor: ThemeColor.themeColor,
        body: Stack(
          children: [
            /// 背景图
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/image/common/kelly_chat_bg@3x.png',
                fit: BoxFit.fitWidth,
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
                        GestureDetector(
                          onTap: controller.pushUserInfoPage,
                          child: Container(
                            color: Colors.transparent,
                            child: ImageLookWidget(
                              enlargeLook: false,
                              imgUrl:
                                  controller.vm.value.userInfo?.avatar ?? '',
                              width: 32,
                              height: 32,
                              imgBorderRadius: BorderRadius.circular(32),
                            ),
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

                  /// 热门标签（数据源：DoingVM.hotTags）
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(
                        () {
                          final tags = controller.vm.value.hotTags;
                          if (tags.isEmpty) {
                            return const Center(
                              child: Text(
                                '暂无热门标签',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }
                          return GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 12,
                            childAspectRatio: 2.5,
                            children: tags
                                .map(
                                  (e) {
                                    final tag = e.tagName ?? '';
                                    final dy = (tag.hashCode.abs() % 10)
                                        .toDouble(); // 0~6，稳定不跳动
                                    return Transform.translate(
                                      offset: Offset(0, dy),
                                      child: HotTagCell(
                                        text: tag,
                                        onTap: () async {
                                          /// push-正在做的清单-页面
                                          await controller
                                              .clickSelectPublishDoing(e);
                                        },
                                      ),
                                    );
                                  },
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  InputAiWidget(
                    hint: '输入你正在做的事…',
                    controller: controller.editingController,
                    focusNode: controller.focusNode,
                    onSubmittedTap: (content) async {
                      /// 点击发布正在做的事
                      controller.clickPublishDoing(content);
                    },
                  ),
                  SizedBox(height: 12)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
