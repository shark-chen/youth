import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: input_search_view
///
/// @Author 谌文
/// @Date 2026/3/30 19:21
///
/// @Description 搜索输入框
// class InputSearchWidget extends BaseStatelessWidget {
//   const InputSearchWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 36,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min, // ⭐关键：包住内容
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.search,
//             size: 18,
//             color: Colors.white.withOpacity(0.6),
//           ),
//           const SizedBox(width: 6),
//           const Text(
//             '搜索',
//             style: TextStyle(
//               color: Colors.white54,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
          if (!isFocus && isEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search,
                  size: 18,
                  color: ThemeColor.theme7FColor,
                ),
                const SizedBox(width: 6),
                Text(
                  '搜索',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              ],
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
              hintText: isFocus ? '搜索' : '',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              prefixIcon: isFocus
                  ? Padding(
                      padding: EdgeInsets.only(left: 12, right: 2),
                      child: Icon(Icons.search, color: Colors.white.withOpacity(0.6)))
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 20, minHeight: 20),
              suffixIcon: (!isEmpty)
                  ? IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.white.withOpacity(0.6)),
                      onPressed: () {
                        _controller.clear();
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
