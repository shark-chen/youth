import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/user/user_center/user_center.dart';
import '../hall/view/input_ai_view.dart';
import 'doing_controller.dart';
import 'view/hot_tag_cell.dart';

/// FileName: doing_page
///
/// @Author 谌文
/// @Date 2026/3/9 14:11
///
/// @Description 选择你正在做的事情-页面-page
class DoingPage extends BasePage<DoingController> {
  const DoingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomSafe = MediaQuery.of(context).viewPadding.bottom;
    final y = (bottomInset - kBottomNavigationBarHeight - bottomSafe);
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                top: 260,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ThemeColor.themeColor.withOpacity(0.0),
                        ThemeColor.themeColor,
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
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ThemeColor.whiteColor,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: ImageLookWidget(
                                imgUrl: controller.vm.value.userInfo?.avatar ?? '',
                                height: 32,
                                width: 32,
                                enlargeLook: false,
                                borderColor: Colors.transparent,
                                imgBorderRadius: BorderRadius.circular(999),
                                heroTag:
                                    '${UserCenter().user?.avatar ?? ''}_doing_page',
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
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 60),
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
                              children: controller.vm.value.hotTags.map(
                                (e) {
                                  final tag =
                                      '${e.icon ?? ''} ${e.tagName ?? ''}';
                                  return HotTagCell(
                                    text: tag,
                                    animationSeed: e.tagId ?? tag.hashCode,
                                    onTap: () async {
                                      /// push-正在做的清单-页面
                                      await controller
                                          .clickSelectPublishDoing(e);
                                    },
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 输入框悬浮层：随键盘抬起，贴在键盘上方
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.only(
                      bottom: y > 0 ? (y > 0 ? y : bottomInset) : bottomInset),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: bottomInset > 60 ? 0 : (bottomSafe + 12),
                    ),
                    child: Container(
                      padding: bottomInset > 60
                          ? EdgeInsets.only(top: 8)
                          : EdgeInsets.zero,
                      color: bottomInset > 60
                          ? ThemeColor.textBlackColor.withOpacity(0.5)
                          : Colors.transparent,
                      child: InputAiWidget(
                        hint: '输入你正在做的事…',
                        controller: controller.editingController,
                        maxLength: 30,
                        focusNode: controller.focusNode,
                        onSubmittedTap: (content) async {
                          /// 点击发布正在做的事
                          controller.clickPublishDoing(content);
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
