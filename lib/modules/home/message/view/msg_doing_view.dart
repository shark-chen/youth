import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: msg_doing_view
///
/// @Author 谌文
/// @Date 2026/3/10 23:46
///
/// @Description 消息列表-正在做的任务
class MsgDoingWidget extends BaseStatelessWidget {
  const MsgDoingWidget({
    Key? key,
    this.doing,
    this.whoName,
  }) : super(key: key);

  /// 正在做的事情
  final String? doing;

  /// 正在做与谁
  final String? whoName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF635CFD).withOpacity(0.1),
            Color(0xFF8B63EB).withOpacity(0.1),
          ],
        ),
      ),
      margin: EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 连接 + 一起做
          Row(
            children: [
              Text(
                '一起做',
                style: TextStyles(
                  fontSize: 18,
                  color: ThemeColor.whiteColor.withOpacity(0.1),
                ),
              )
            ],
          ),

          SizedBox(height: 7),

          /// 与谁 一起做的啥
          Text(
            '与' + (whoName ?? '') + (doing ?? ''),
            style: TextStyles(
              fontSize: 18,
              color: ThemeColor.whiteColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
