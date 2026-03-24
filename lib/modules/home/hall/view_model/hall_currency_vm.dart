import 'package:youth/base/base_controller.dart';
import 'hall_vm.dart';

/// FileName hall_currency_vm
///
/// @Author 谌文
/// @Date 2024/12/9 11:05
///
/// @Description 首页存储VM
extension HallCurrencyVM on HallVM {
  /// 创建币种选项列表数据
  void buildCurrencyList() {
    currencyList = [
      BubbleModel(title: 'IDR'),
      BubbleModel(title: 'MYR'),
      BubbleModel(title: 'PHP'),
      BubbleModel(title: 'SGD'),
      BubbleModel(title: 'THB'),
      BubbleModel(title: 'VND'),
      BubbleModel(title: 'TWD'),
      BubbleModel(title: 'CNY'),
      BubbleModel(title: 'USD'),
    ];
  }

  /// 列表选中币种
  void selectCurrency(String? currency) {
    if (Strings.isEmpty(currency)) return;
    this.currency = currency ?? '';
    currencyList.forEach((element) => element.selected = false);
    currencyList.forEach((element) => element.selected =
        element.title.toLowerCase() == currency?.toLowerCase());
  }

  /// 获取列表币种
  String getCurrencyByIndex(int? index) {
    if ((index ?? 0) > currencyList.length) return '';
    return currencyList[index ?? 0].title;
  }
}
