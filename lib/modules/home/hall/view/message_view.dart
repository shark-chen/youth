import 'package:youth/tripartite_library/tripartite_library.dart';
import 'package:youth/utils/extension/strings/strings.dart';
import 'package:youth/utils/utils/theme_color.dart';
import '../../../../utils/extension/text_styles.dart';

/// FileName message_view
///
/// @Author 谌文
/// @Date 2023/8/25 09:12
///
/// @Description 首页消息view
class MessageView extends StatelessWidget {
  const MessageView({
    Key? key,
    this.messageCount,
    this.onTap,
  }) : super(key: key);

  final String? messageCount;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(bottom: 4, right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 48,
          height: 40,
          child: Stack(
            children: [
              Container(
                width: 48,
                height: 40,
                padding: EdgeInsets.only(left: 9, right: 9, top: 4, bottom: 4),
                child: Image.asset('assets/image/hall/massage@3x.png'),
              ),
              Visibility(
                visible: Strings.isNotEmpty(messageCount),
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: ThemeColor.brightRedColor,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      textAlign: TextAlign.center,
                      messageCount ?? '',
                      style: TextStyles(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
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
