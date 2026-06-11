import 'package:flutter/cupertino.dart';
import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName profile_setup_tags_area_view
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description 地区与标签 - widget
class ProfileSetupTagsAreaWidget extends BaseStatelessWidget {
  const ProfileSetupTagsAreaWidget({
    super.key,
    this.area,
    this.areaTap,
    this.addCustomTagTap,
    this.customTags,
    this.customTagsDeleteTap,
    this.optionTags,
    this.optionTagsTap,
  });

  /// 地区
  final String? area;

  /// 地区 选择点击
  final VoidCallback? areaTap;

  /// 添加自定义标签点击
  final VoidCallback? addCustomTagTap;

  /// 自定义标签
  final List<String>? customTags;

  /// 自定义标签 删除点击
  final ValueChanged<String>? customTagsDeleteTap;

  /// 可选择的标签
  final List<BubbleModel>? optionTags;

  /// 可选标签选择点击
  final ValueChanged<BubbleModel>? optionTagsTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '你在哪里？你喜欢什么？',
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 44),
          buildTitleWidget('设置地区'),
          const SizedBox(height: 12),

          /// 选择所在地区
          GestureDetector(
            onTap: areaTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: ThemeColor.inputBgColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      Strings.isEmpty(area) ? '选择所在地区' : (area ?? ''),
                      style: TextStyle(
                        color: Strings.isEmpty(area)
                            ? ThemeColor.whiteColor.withOpacity(0.35)
                            : ThemeColor.whiteColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ThemeColor.whiteColor.withOpacity(0.45),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          buildTitleWidget('设置标签（最多10个）'),
          const SizedBox(height: 12),

          /// 自定义标签
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: ThemeColor.whiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: ButtonIcon(
                  onTap: addCustomTagTap,
                  title: '自定义标签',
                  style: TextStyles(
                    color: ThemeColor.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  path: 'assets/image/common/add@3x.png',
                  iconSize: Size(16, 16),
                ),
              ),
            ],
          ),

          /// 自定义标签
          Wrap(
            spacing: 12.0,
            runSpacing: 16.0,
            children: customTags
                    ?.map(
                      (title) => GestureDetector(
                        onTap: () => customTagsDeleteTap?.call(title),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColor.themeGreenColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: ThemeColor.themeGreenColor,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: TextStyles(
                                  color: ThemeColor.whiteColor,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.close,
                                size: 14,
                                color: ThemeColor.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),

          Visibility(
            visible: Lists.isNotEmpty(customTags),
            child: SizedBox(height: 16),
          ),

          /// 选择标签
          Wrap(
              spacing: 12.0,
              runSpacing: 16.0,
              children: optionTags
                      ?.map(
                        (tag) => GestureDetector(
                          onTap: () => optionTagsTap?.call(tag),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: tag.selected == true
                                  ? ThemeColor.themeGreenColor.withOpacity(0.05)
                                  : ThemeColor.whiteColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: tag.selected == true
                                    ? ThemeColor.themeGreenColor
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tag.title,
                              style: TextStyles(
                                color: ThemeColor.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList() ??
                  []),
        ],
      ),
    );
  }

  /// 标题
  Widget buildTitleWidget(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: Text(
        text,
        style: TextStyle(
          color: ThemeColor.whiteColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
