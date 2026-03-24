import 'dart:ui';
import '../../../../generated/locales.g.dart';
import 'package:get/get.dart';
import '../../../../utils/extension/strings/strings.dart';

/// FileName pick_state_service
///
/// @Author 谌文
/// @Date 2024/3/18 20:44
///
/// @Description 获取订单状态及子状态
class PickStateModel {
  /// 父状态
  final String? pick;

  /// 父状态的翻译
  final String? pickName;

  /// 子状态
  final String? pickState;

  /// 子状态的翻译
  final String? pickStateName;

  PickStateModel({
    this.pick,
    this.pickName,
    this.pickState,
    this.pickStateName,
  });
}

/// 订单父状态模型类
class StateModel {
  final StateEnum? state;

  /// 父状态的翻译
  final String? stateName;

  /// 状态展示时的背景色
  final Color? bgColor;

  /// 状态展示时的字体颜色
  final Color? fontColor;

  StateModel({
    this.state,
    this.stateName,
    this.bgColor,
    this.fontColor,
  });
}

enum StateEnum {
  newState, // 待处理  - new
  processing, // 待打单 - processing
  pickup, // 待揽收  - pickup
  shipped, // 已交运   - shipped
  completed, // 已完成   - completed
  voided, // 已搁置  - voided
  inCancel, // 申请取消中
  canceled, // 已取消
}

abstract class PickStateAbstract extends Object {
  /// new,processing,shipped,completed,ignored,void,canceled 获取到对应的订单父状态的翻译
  StateModel orderState(String state);

  PickStateModel orderPickState(int packState);
}

/// 订单状态模型
Map<String, StateModel> stateMap = {
  // 待处理  - new
  'new': StateModel(
    state: StateEnum.newState,
    stateName: LocaleKeys.NewOrder.tr,
    bgColor: Color(0xFFFBE6E5),
    fontColor: Color(0xFFE51515),
  ),
  // 待打单 - processing
  'processing': StateModel(
    state: StateEnum.processing,
    stateName: LocaleKeys.ProcessOrder.tr,
    bgColor: Color(0xFFFBE6E5),
    fontColor: Color(0xFFE51515),
  ),
  // 待打单 - to ship
  'to ship': StateModel(
    state: StateEnum.processing,
    stateName: LocaleKeys.ProcessOrder.tr,
    bgColor: Color(0xFFFFF3C5),
    fontColor: Color(0xFFB84C00),
  ),
  // 待揽收  - pickup
  'pickup': StateModel(
    state: StateEnum.pickup,
    stateName: LocaleKeys.PickUpOrder.tr,
    bgColor: Color(0xFFFFF3C5),
    fontColor: Color(0xFFB84C00),
  ),
  // 待揽收  - pickup
  'to pickup': StateModel(
    state: StateEnum.pickup,
    stateName: LocaleKeys.PickUpOrder.tr,
    bgColor: Color(0xFFFFF3C5),
    fontColor: Color(0xFFB84C00),
  ),
  // 已交运   - shipped
  'shipped': StateModel(
    state: StateEnum.shipped,
    stateName: LocaleKeys.Delivered.tr,
    bgColor: Color(0xFFDBEAFE),
    fontColor: Color(0xFF1941B8),
  ),
  // 已完成   - completed
  'completed': StateModel(
    state: StateEnum.completed,
    stateName: LocaleKeys.orderCompleted.tr,
    bgColor: Color(0xFFD9F7EB),
    fontColor: Color(0xFF006754),
  ),
  // 已搁置  - voided
  'voided': StateModel(
    state: StateEnum.voided,
    stateName: LocaleKeys.voided.tr,
    bgColor: Color(0xFF919098),
    fontColor: Color(0xFFFFFFFF),
  ),
  // 取消申请
  'in cancel': StateModel(
    state: StateEnum.inCancel,
    stateName: LocaleKeys.cancelRequest.tr,
    bgColor: Color(0xFFF0F0F0),
    fontColor: Color(0xFF616065),
  ),
  // 已经取消
  'canceled': StateModel(
    state: StateEnum.canceled,
    stateName: LocaleKeys.canceled.tr,
    bgColor: Color(0xFFF0F0F0),
    fontColor: Color(0xFF616065),
  ),
};

Map platformMap() => {
      'manual': LocaleKeys.ManualOrders.tr,
      'chat': LocaleKeys.ChatOrder.tr,
      'offline': 'POS'
    };

/// 平台转换
String platformConvert(String platform) {
  var result = platformMap()[platform.toLowerCase()];
  return Strings.isEmpty(result) ? platform : result;
}

mixin PickStateMixin implements PickStateAbstract {
  @override
  StateModel orderState(String state) {
    return stateMap[state.toLowerCase()] ?? StateModel();
  }

  @override
  PickStateModel orderPickState(int packState) {
    /// new,processing,shipped,completed,ignored,void,canceled
    /// packState子状态: 待安排-0 安排中1 安排失败2 缺货4   待打印3  刷新中4 获取面单5  交运成功6 交运失败7
    // Map<String, Map> map = {
    //   'new': {
    //     '待处理': {0: '待安排', 1: '安排中', 2: '安排失败'}
    //   },
    //   'pickup': {
    //     '待安排': {3: '安排中', 4: '刷新中', 5: '获取面单'}
    //   },
    //   'processing': {'待揽收': {}},
    //   'dasd': {
    //     '已交运': {6: '交运成功', 7: '交运失败'}
    //   },
    // };
    return PickStateModel();
  }
}
