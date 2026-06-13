import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'package:kellychat/modules/user/user_center/user_center.dart';
import 'package:kellychat/tripartite_library/pull_to_refresh/refresher_header.dart';
import 'package:kellychat/modules/home/message/view/message_doing_header_view.dart';
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
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: ImageLookWidget(
                    imgUrl: UserCenter().user?.avatar ?? '',
                    height: 32,
                    width: 32,
                    enlargeLook: false,
                    borderColor: Colors.transparent,
                    imgBorderRadius: BorderRadius.circular(999),
                    heroTag:
                        '${UserCenter().user?.avatar ?? ''}_message_page_avatar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            enablePullUp: controller.vm.value.haveDoingPerson,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            header: RefresherHeader.build(),
            footer: ClassicFooter(
              loadingText: '加载中',
              noDataText: '没有更多了',
              height: 80.0,
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: _buildSlivers(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSlivers() {
    final v = controller.vm.value;
    final myDoing = MyDoing().doing;

    return [
      SliverToBoxAdapter(
        child: _DoingListHeaderSection(
          controller: controller,
          vm: v,
          myDoing: myDoing,
        ),
      ),
      if (!v.haveDoingPerson)
        const SliverToBoxAdapter(
          child: _HotTagsSectionTitle(),
        ),
      SliverPadding(
        padding: const EdgeInsets.only(top: 6, bottom: 24),
        sliver: v.haveDoingPerson
            ? SliverList.separated(
                itemCount: controller.rows.length,
                itemBuilder: (context, index) {
                  final item = controller.rows[index];
                  return DoingListCell(
                    headerIcon: item.avatar,
                    name: item.nickname,
                    sex: _sexFromGender(item.gender),
                    age: item.age != null ? '${item.age}' : null,
                    address: item.city,
                    signature: item.signature,
                    isOnline: false,
                    togetherStatus: controller.togetherButtonStatusFor(item),
                    onKnockTap: (center) async => controller.clickKnock(
                      item,
                      knockButtonCenter: center,
                    ),
                    onTogetherTap: () async => controller.clickJoinTogether(
                      item,
                      controller.togetherButtonStatusFor(item),
                    ),
                    onTap: () async => controller.clickLookUserInfo(item),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              )
            : SliverList.separated(
                itemCount: controller.hotRows.length,
                itemBuilder: (context, index) {
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
    ];
  }
}

class _HotTagsSectionTitle extends StatelessWidget {
  const _HotTagsSectionTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            '部分热门的「正在做」',
            style: TextStyles(
              color: ThemeColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            '点击即可设为我自己的状态',
            style: TextStyles(
              color: ThemeColor.whiteColor,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}

class _DoingListHeaderSection extends StatelessWidget {
  const _DoingListHeaderSection({
    required this.controller,
    required this.vm,
    this.myDoing,
  });

  final DoingListController controller;
  final DoingListVM vm;

  /// 我正在做的事
  final PublishDoingEntity? myDoing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        if (myDoing?.togetherPartner != null)
          MessageDoingHeaderView(
            tagName: myDoing?.tagName,
            partnerName: myDoing?.togetherPartner?.nickname,
            onCancelTap: controller.clickCancelTogetherDoing,
          )
        else
          DoingListHeaderWidget(
            title: myDoing?.tagName ?? '--',
            inviteTap: controller.clickInvitationFriend,
            closeTap: controller.clickDeleteStatusDoing,
          ),
        Visibility(
          visible: vm.samePeopleCount > 0,
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
                    text:
                        DoingListVM.formatHotTagPeopleCount(vm.samePeopleCount),
                    style: const TextStyle(
                      color: ThemeColor.themeGreenColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' 人也在「${vm.activityTitle}」'),
                ],
              ),
            ),
          ),
        ),
        if (!vm.haveDoingPerson) ...[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  const SizedBox(height: 85),
                  Image.asset(
                    'assets/image/common/have_no_doing@3x.png',
                    fit: BoxFit.fill,
                    width: 128,
                    height: 87,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '当前暂时没有其他人在「${myDoing?.tagName ?? '--'}」～',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.45),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
