import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: user_header_info_view
///
/// @Author 谌文
/// @Date 2026/3/16 23:05
///
/// @Description 用户信息头像信息- view
class UserHeaderInfoWidget extends BaseStatelessWidget {
  const UserHeaderInfoWidget({
    Key? key,
    this.headPortraitUrl,
    this.userName,
    this.age,
    this.address,
    this.province,
    this.gender,
    this.showEdit,
    this.editTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 用户名称
  final String? userName;

  /// 年纪（如 `32岁`）
  final String? age;

  /// 地区等副文案
  final String? address;

  /// 地区等副文案
  final String? province;

  /// 1 男 · 2 女（与资料接口一致）
  final int? gender;

  /// 展示编辑
  final bool? showEdit;

  /// 编辑点击
  final VoidCallback? editTap;

  static const double _genderIconSize = 18;
  static const double _genderIconGap = 4;

  TextStyle get _nicknameStyle => TextStyle(
        color: ThemeColor.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  Widget? _buildGenderIcon() {
    if (gender == null) return null;
    return Icon(
      1 == gender ? Icons.male : Icons.female,
      size: _genderIconSize,
      color: 1 == gender
          ? ThemeColor.maleIconColor
          : ThemeColor.femaleIconColor,
    );
  }

  /// 性别图标紧贴昵称；昵称换行时图标仍在第一行末尾
  Widget _buildNicknameWithGender(BuildContext context, double maxWidth) {
    final name = userName ?? '';
    final genderIcon = _buildGenderIcon();
    if (name.isEmpty) {
      return genderIcon ?? const SizedBox.shrink();
    }
    if (genderIcon == null) {
      return Text(name, style: _nicknameStyle);
    }

    final firstLineMaxWidth = maxWidth - _genderIconSize - _genderIconGap;
    if (firstLineMaxWidth <= 0) {
      return Text(name, style: _nicknameStyle);
    }

    final textDirection = Directionality.of(context);
    final singleLinePainter = TextPainter(
      text: TextSpan(text: name, style: _nicknameStyle),
      textDirection: textDirection,
      maxLines: 1,
    )..layout(maxWidth: firstLineMaxWidth);

    if (!singleLinePainter.didExceedMaxLines) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              name,
              style: _nicknameStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: _genderIconGap),
          genderIcon,
        ],
      );
    }

    var splitIndex = name.length;
    for (var i = name.length; i > 0; i--) {
      final probe = TextPainter(
        text: TextSpan(text: name.substring(0, i), style: _nicknameStyle),
        textDirection: textDirection,
        maxLines: 1,
      )..layout(maxWidth: firstLineMaxWidth);
      if (!probe.didExceedMaxLines) {
        splitIndex = i;
        break;
      }
    }

    final firstLine = name.substring(0, splitIndex);
    final rest = name.substring(splitIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                firstLine,
                style: _nicknameStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: _genderIconGap),
            genderIcon,
          ],
        ),
        if (rest.isNotEmpty) Text(rest, style: _nicknameStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          /// 头像
          ImageLookWidget(
            height: 64,
            width: 64,
            imgUrl: headPortraitUrl ?? '',
            heroTag: '${headPortraitUrl ?? ''}_${userName}_user_header_info_view',
            imgBorderRadius: BorderRadius.circular(32),
          ),
          SizedBox(width: 12),

          /// 用户名称，性别，年龄 地址
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return _buildNicknameWithGender(
                      context,
                      constraints.maxWidth,
                    );
                  },
                ),
                Text(
                  '${age ?? ''}·${address ?? ''}   IP:${province ?? ''}',
                  softWrap: true,
                  style: TextStyles(
                    color: ThemeColor.whiteColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          /// 编辑按钮
          Visibility(
            visible: true == showEdit,
            child: GestureDetector(
              onTap: editTap,
              child: Container(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                decoration: BoxDecoration(
                  color: ThemeColor.themeGreenColor.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: ThemeColor.themeGreenColor,
                      size: 12,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '编辑',
                      style: TextStyles(
                        color: ThemeColor.themeGreenColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
