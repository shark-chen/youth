import 'package:kellychat/base/base_stateless_widget.dart';

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
          Image.asset(
            'assets/image/common/search_icon@3x.png',
            width: 24,
            height: 24,
            color: ThemeColor.redColor,
          ),

          /// ⭐ 真正输入框
          TextField(
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
              ),
              prefixIcon: isFocus
                  ? Padding(
                      padding: EdgeInsets.only(left: 12, right: 2),
                      child: Icon(Icons.search,
                          color: Colors.white.withOpacity(0.6)))
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 20, minHeight: 20),
              // suffixIcon: (!isEmpty)
              //     ? IconButton(
              //         icon: Icon(Icons.close,
              //             color: Colors.white.withOpacity(0.6)),
              //         onPressed: () {
              //           _controller.clear();
              //         },
              //       )
              //     : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
