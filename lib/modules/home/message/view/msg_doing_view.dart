import 'package:youth/base/base_stateless_widget.dart';

/// FileName: msg_doing_view
///
/// @Author 谌文
/// @Date 2026/3/10 23:46
///
/// @Description 消息列表-正在做的任务
class MsgDoingWidget extends BaseStatelessWidget {
  const MsgDoingWidget({
    Key? key,
    this.doingIcon,
    this.doing,
    this.whoName,
  }) : super(key: key);

  /// 图表
  final String? doingIcon;

  /// 正在做的事情
  final String? doing;

  /// 正在做与谁
  final String? whoName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.blueColor, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      padding: EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 连接 + 一起做
          Row(
            children: [
              Icon(
                Icons.link,
                color: ThemeColor.blueColor,
              ),
              Text(
                '一起做',
                style: TextStyles(
                  color: ThemeColor.blueColor,
                ),
              )
            ],
          ),



          /// 与谁 一起做的啥
          Row(
            children: [
              Icon(Icons.movie),
              SizedBox(width: 12),

              Text(
                (doing ?? '') + '\n与' + (whoName ?? ''),
                style: TextStyles(
                  color: ThemeColor.whiteColor,
                ),
              ),

              Expanded(child: Container()),
              Icon(Icons.close),
            ],
          ),

        ],
      ),
    );
  }
}
