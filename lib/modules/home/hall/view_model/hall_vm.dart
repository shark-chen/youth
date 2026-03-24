import 'package:youth/base/base_vm.dart';
import '../model/hall_entity.dart';
import '../model/hall_item_entity.dart';
import '../model/hall_mark_model.dart';
import 'hall_currency_vm.dart';
export 'hall_store_vm.dart';
export 'hall_msg_vm.dart';
import 'hall_store_vm.dart';
import 'hall_msg_vm.dart';

/// FileName hall_vm
///
/// @Author 谌文
/// @Date 2024/6/26 18:54
///
/// @Description 首页vm
class HallVM extends BaseVM {
  HallVM({TickerProvider? mixin}) {


    /// 创建币种选项列表数据
    buildCurrencyList();
    if (mixin == null) return;
  }

  /// 未读消息数量
  String messageCount = "";

  /// 币种选择数据模型
  List<BubbleModel> currencyList = [];

  /// 币种
  String currency = '';

  /// 有权限是肯定展示今日销量的
  /// 是否有查看销售数据的权限
  var salesAuthority = true;

  /// 首页销售数据没有权限时候关闭View, 关闭过这个值为true
  bool salesFiguresClosed = false;

  /// MARK - 首页列表
  ///
  /// 首页数据类型
  List<HallEntity>? rows;

  /// 移货角标 + 补货角标 + 波次拣货角标
  List<HallMarkModel> marks = [];

  /// 语音包是否下载过
  bool voicesDownloaded = false;

  /// 配置首页数据
  void configHalls(List<HallEntity>? halls) {
    this.rows = halls;

    /// 更新首页各个图标的角标数量
    updateHallMark();
    refresh?.call();

    /// 预加载语音包： num:数量
    preDownloadVoices();
  }

  /// 获取列表数量
  int itemCount() => (rows?.length ?? 0) ;

  /// 获取元素数据
  HallEntity getItem(int index) {
    return rows?[index] ?? HallEntity();
  }

  /// 点击列表item校验
  bool clickItemVerify(HallItemEntity? data) {
    if (data == null) return false;
    return true;
  }

  /// 是否存在某个图标
  bool? existPageName(String pageName) {
    if (Lists.isEmpty(rows)) return null;
    for (HallEntity value in (rows ?? [])) {
      for (HallItemEntity item in (value.items ?? [])) {
        if (item.pageName == pageName) return true;
      }
    }
    return false;
  }
}
