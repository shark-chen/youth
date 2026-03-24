import 'dart:async';
import 'package:youth/base/base_service.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../../utils/marco/frame.dart';
import '../../../../utils/marco/marco.dart';
import '../model/associate_entity.dart';
export 'package:get/get.dart';

/// FileName search_associate_service
///
/// @Author 谌文
/// @Date 2025/7/15 20:11
///
/// @Description 搜索联想基础服务类
class SearchAssociateService extends BaseService {
  /// 展示的SKU搜索气泡
  Frame? frame = Frame();
  RxBool showBubble = false.obs;
  final RxList<AssociateEntity> searchResults = <AssociateEntity>[].obs;
  bool excludeSearch = false;

  /// 刷新
  VoidCallback? keyboardRefresh;

  /// 设置键盘隐藏展示方法
  ValueChanged<bool>? hiddenKeyboardMethod;

  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
    editingController = TextEditingController();
    textFormKey = GlobalKey();
    editSelection(select: true);

    /// 添加键盘输入监控
    addKeyboardListener();

    /// 添加键盘显示隐藏监控
    addKeyboardVisibilityListen();
  }

  /// 选择搜索的SKU
  AssociateEntity? selectSKU(int index) {
    if (index < 0 || index >= searchResults.length) return null;
    setShowBubble(true);
    editingController?.text = searchResults[index].original ?? '';
    editingController?.selection = TextSelection(
        baseOffset: 0, extentOffset: editingController?.text.length ?? 0);
    setShowBubble(false);
    return searchResults[index];
  }

  /// 气泡高度
  double get bubbleHeight {
    if (searchResults.length < 5) {
      return searchResults.length * 42;
    }
    return 42 * 4.5;
  }

  /// 设置是否展示
  void setShowBubble(bool value) {
    if (showBubble.value == value) return;
    showBubble.value = value;
  }

  /// 添加键盘显示隐藏监控
  StreamSubscription? _keyboardSubscription;

  void addKeyboardVisibilityListen() {
    _keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((bool visible) {
      print(visible);
      if (visible == false) {
        setShowBubble(false);
        hiddenKeyboardMethod?.call(true);
        showBubble.refresh();
        searchResults.clear();
      }
    });
  }

  /// 添加键盘聚焦监控
  void addKeyboardListener() {
    /// 针对PDA模式扫描不触发
    editingController?.addListener(() async {
      /// 输入字符>=3个
      if (excludeSearch) return;

      /// 输入框问题大于等于3并且是键盘输入的
      RenderObject? renderBox = textFormKey?.currentContext?.findRenderObject();
      if ((editingController?.text.length ?? 0) >= 3 &&
          KeyboardVisibilityController().isVisible &&
          renderBox != null &&
          renderBox is RenderBox) {
        final Offset offset = renderBox.localToGlobal(Offset.zero);

        /// 44 导航头高，20输入框的高度的一半 + 4 间距
        frame = Frame(
            offset: Offset(offset.dx, offset.dy - topPadding - 44 + 24),
            size: renderBox.size);
        await requestSearchAssociate();
        searchResults.refresh();
      } else {
        setShowBubble(false);
        searchResults.clear();
      }
    });
  }

  /// Request - 请求联想
  Future requestSearchAssociate() {
    setShowBubble(KeyboardVisibilityController().isVisible &&
        searchResults.isNotEmpty &&
        (editingController?.text.length ?? 0) >= 3);
    return Future(() => null);
  }

  void dispose() {
    try {
      _keyboardSubscription?.cancel();
      _keyboardSubscription = null;
    } catch (_) {}
  }
}
