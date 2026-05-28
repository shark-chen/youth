import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/tripartite_library/tripartite_library.dart';
import 'package:kellychat/widget/bottom_dialog/bottom_dialog.dart';

/// FileName: input_search_view
///
/// @Author 谌文
/// @Date 2026/3/30 19:21
///
/// @Description 搜索输入框
class InputSearchWidget extends StatefulWidget {
  const InputSearchWidget({super.key});

  @override
  State<InputSearchWidget> createState() => _InputSearchWidgetState();
}

class _InputSearchWidgetState extends State<InputSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool isFocus = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        isFocus = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = _controller.text.isEmpty;
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// ⭐ 居中占位（未输入 & 未focus）
          Visibility(
            visible: (!isFocus && isEmpty),
            child: Padding(
              padding: EdgeInsets.only(right: 60),
              child: Image.asset(
                'assets/image/common/search_icon@3x.png',
                width: 20,
                height: 20,
              ),
            ),
          ),

          /// ⭐ 真正输入框
          TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: _controller,
            focusNode: _focusNode,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign:
                (!isFocus && isEmpty) ? TextAlign.center : TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '搜索',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
              ),
              prefixIcon: isFocus || !isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: 12, right: 2),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          'assets/image/common/search_icon@3x.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 20, minHeight: 20),
              contentPadding: const EdgeInsets.only(top: 6, bottom: 12),
            ),
          ),
        ],
      ),
    );
  }
}
