import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/modules/home/doing/model/doing_hot_tags_entity.dart';
import 'package:kellychat/modules/user/user_center/user_center.dart';
import 'package:kellychat/tripartite_library/pull_to_refresh/refresher_header.dart';
import 'package:kellychat/tripartite_library/tripartite_library.dart';
import 'package:kellychat/widget/bottom_alert/bottom_alert.dart';
import 'doing_list_controller.dart';
import 'view_model/doing_list_vm.dart';
import 'view/doing_activity_stat_cell.dart';
import 'view/doing_list_cell.dart';
import 'view/doing_list_header_view.dart';

/// FileName: doing_list_page
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-页面-page
class DoingListPage extends BasePage<DoingListController> {
  const DoingListPage({Key? key}) : super(key: key);

  /// 与 [SexSelectController] 一致：1 男 · 2 女
  static bool? _sexFromGender(int? gender) {
    if (gender == 1) return true;
    if (gender == 2) return false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    /// 刷新数据
    controller.refreshData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        controller.title ?? '我正在',
        leading: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              SizedBox(width: 14),
              GestureDetector(
                onTap: controller.pushUserInfoPage,
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeColor.whiteColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: ImageLookWidget(
                    imgUrl: UserCenter().user?.avatar ?? '',
                    width: 32,
                    height: 23,
                    enlargeLook: false,
                    imgBorderRadius: BorderRadius.circular(32),
                    heroTag: '${UserCenter().user?.avatar ?? ''}_doing_list',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12),

              /// 我的正在做的活动
              DoingListHeaderWidget(
                title: controller.vm.value.myDoing?.tagName ?? '--',
                inviteTap: controller.clickInvitationFriend,
                closeTap: controller.clickDeleteStatusDoing,
              ),

              /// 有几个人正在做这个事情

              Visibility(
                visible: controller.vm.value.samePeopleCount > 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 14,
                        height: 1.35,
                      ),
                      children: [
                        const TextSpan(text: '有 '),
                        TextSpan(
                          text: '${controller.vm.value.samePeopleCount}',
                          style: const TextStyle(
                            color: ThemeColor.themeGreenColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                            text: ' 人也在「${controller.vm.value.activityTitle}」'),
                      ],
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: !controller.vm.value.haveDoingPerson,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 85),
                      Image.asset(
                        'assets/image/common/have_no_doing@3x.png',
                        fit: BoxFit.fill,
                        width: 128,
                        height: 87,
                      ),
                      SizedBox(height: 18),
                      Text(
                        '当前暂时没有其他人在「${controller.vm.value.myDoing?.tagName ?? '--'}」～',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.45),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: !controller.vm.value.haveDoingPerson,
                child: Spacer(),
              ),

              Visibility(
                visible: !controller.vm.value.haveDoingPerson,
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    '部分热门的「正在做」',
                    style: TextStyles(
                      color: ThemeColor.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: !controller.vm.value.haveDoingPerson,
                child: SizedBox(height: 4),
              ),
              Visibility(
                visible: !controller.vm.value.haveDoingPerson,
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    '点击即可设为我自己的状态',
                    style: TextStyles(
                      color: ThemeColor.whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !controller.vm.value.haveDoingPerson,
                child: SizedBox(height: 6),
              ),

              /// 列表
              Expanded(
                flex: 5,
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  onRefresh: controller.onRefresh,
                  header: RefresherHeader.build(),
                  footer: ClassicFooter(
                    loadingText: LocaleKeys.Loading.tr,
                    noDataText: LocaleKeys.NoMore.tr,
                    height: 80.0,
                    loadStyle: LoadStyle.ShowWhenLoading,
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 6, bottom: 24),
                    itemCount: controller.itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      final v = controller.vm.value;
                      if (v.haveDoingPerson) {
                        final item = controller.rows[index];
                        return DoingListCell(
                          headerIcon: item.avatar,
                          name: item.nickname,
                          sex: _sexFromGender(item.gender),
                          age: item.age != null ? '${item.age}' : null,
                          address: item.city,
                          signature: item.signature,
                          isOnline: false,
                          onKnockTap: () async => controller.clickKnock(item),
                          onTogetherTap: () async =>
                              controller.clickJoinTogether(item),
                          onTap: () async => controller.clickLookUserInfo(item),
                        );
                      }
                      final hot = controller.hotRows[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DoingActivityStatCell(
                          activityName: hot.tagName ?? '--',
                          peopleCountLabel: hot.peopleCountDisplay ??
                              DoingListVM.formatHotTagPeopleCount(
                                  hot.userCount ?? 0),
                          onAddTap: () =>
                              controller.requestPublishDoingFromHotTag(hot),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
