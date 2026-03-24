import 'package:flutter/material.dart';
import 'search_appbar_view.dart';

/// 搜索AppBar
class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  const AppBarSearch({
    Key? key,
    this.borderRadius = 10,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.height = 44,
    this.value,
    this.leading,
    this.backgroundColor,
    this.suffix,
    this.actions = const [],
    this.hintText,
    this.onTap,
    this.onClear,
    this.onCancel,
    this.onChanged,
    this.onSearch,
    this.onSearchIng,
    this.onRightTap,
    this.backCall,
  }) : super(key: key);
  final double? borderRadius;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  /// 输入框高度 默认40
  final double height;

  /// 默认值
  final String? value;

  /// 最前面的组件
  final Widget? leading;

  /// 背景色
  final Color? backgroundColor;

  /// 搜索框内部后缀组件
  final Widget? suffix;

  /// 搜索框右侧组件
  final List<Widget> actions;

  /// 输入框提示文字
  final String? hintText;

  /// 输入框点击回调
  final VoidCallback? onTap;

  /// 清除输入框内容回调
  final VoidCallback? onClear;

  /// 清除输入框内容并取消输入
  final VoidCallback? onCancel;

  /// 点击返回按钮
  final VoidCallback? backCall;

  /// 输入框内容改变
  final ValueChanged<String>? onChanged;

  /// 点击键盘搜索
  final ValueChanged<String>? onSearch;

  /// 键盘搜索中
  final ValueChanged<String>? onSearchIng;

  /// 点击右边widget
  final VoidCallback? onRightTap;

  @override

  /// ignore: library_private_types_in_public_api
  _AppBarSearchState createState() => _AppBarSearchState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppBarSearchState extends State<AppBarSearch> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  bool get isFocus => _focusNode?.hasFocus ?? false; //是否获取焦点

  bool get isTextEmpty => _controller?.text.isEmpty ?? false; //输入框是否为空

  bool get isActionEmpty => widget.actions.isEmpty; // 右边布局是否为空

  bool isShowCancel = false;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.value != null) _controller?.text = widget.value ?? "";
    // 焦点获取失去监听
    _focusNode?.addListener(() => setState(() {}));
    // 文本输入监听
    _controller?.addListener(() {
      setState(() {});
      widget.onSearchIng?.call(_controller?.text ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      surfaceTintColor: widget.backgroundColor,
      titleSpacing: 0,
      leadingWidth: 0,
      toolbarHeight: 44,
      title: SearchAppBarWidget(
        hintText: widget.hintText,
        clickSearchCall: widget.onSearch,
        backCall: widget.backCall,
        onSearch: widget.onSearch,
        focusNode: _focusNode,
        editingController: _controller,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }
}
