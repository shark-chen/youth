/// FileName permissions_enum
///
/// @Author 谌文
/// @Date 2023/9/20 19:48
///
/// @Description 权限枚举
enum UserRightsEnum {
  /// 销售数据权限
  salesRights,

  /// 发货的权限
  scanAndShipping,

  /// 上架权限
  putShelf,

  /// 下架权限
  pullShelf,

  /// 扫描验货
  examineGoods,

  /// 创建POS订单
  createPOSOrder,

  /// 创建POS单添加折扣权限 - 价格编辑权限
  orderPriceEdit,

  /// 库存管理 扫描收货
  scanReceiptPage,

  /// 店铺报告
  shopReports,

  /// 订单报告
  orderReports,

  /// 销售报告
  sellReports,

  /// 移货权限
  moveGoods,

  /// 补货权限
  repleteGoods,

  /// 移货 认领权限
  moveGoodsClaim,

  /// 补货认领权限
  repleteGoodsClaim,

  /// 创建波次权限
  createWave,

  /// 波次拣货
  wavePick,

  /// 二次分拣
  waveSortPick,

  /// 货位调整
  shelfAdjust,

  /// 商品成本价-查看权限
  inventoryLookPrice,

  /// 商品成本价-编辑权限
  inventoryEditPrice,

  /// 商品参考价-查看权限
  viewReference,

  /// 商品参考价- 编辑权限
  editReference,

  /// 虾皮广告
  shopeeAds,

  /// POS账单
  posBill,

  /// 店铺管理基础权限
  shopManageBase,

  /// 店铺管理是否新增店铺授权，重新授权权限
  shopManageAuth,

  /// 店铺管理是否可以删除店铺
  shopManageDelete,

  /// 新订单处理权限
  newOrderHandle,

  /// POS的售后
  posSaleAfter,

  /// 发图留证，发送失败的记录 是否可以重新发送
  recordResendPhoto,
}

Map<UserRightsEnum, String> userRightsMap = {
  UserRightsEnum.salesRights: 'app:statisticData',
  UserRightsEnum.scanAndShipping: 'app:scanAndShipping',
  UserRightsEnum.putShelf: 'app:ShelfUp',
  UserRightsEnum.pullShelf: 'app:ShelfDown',
  UserRightsEnum.examineGoods: 'app:scanExamineGoods',
  UserRightsEnum.createPOSOrder: 'app:posOrder',
  UserRightsEnum.orderPriceEdit: 'data:orderPriceEdit',
  UserRightsEnum.scanReceiptPage: 'app:scanReceipt',
  UserRightsEnum.shopReports: 'app:shopReports',
  UserRightsEnum.orderReports: 'app:orderReports',
  UserRightsEnum.sellReports: 'app:sellReports',
  UserRightsEnum.moveGoods: 'app:moveGoods',
  UserRightsEnum.repleteGoods: 'app:repleteGoods',
  UserRightsEnum.moveGoodsClaim: 'app:moveGoods:claim',
  UserRightsEnum.repleteGoodsClaim: 'app:repleteGoods:claim',
  UserRightsEnum.createWave: 'app.generateWave:claim',
  UserRightsEnum.wavePick: 'wave:pda',
  UserRightsEnum.waveSortPick: 'app:waveSortPick',
  UserRightsEnum.shelfAdjust: 'app:shelfAdjust',
  UserRightsEnum.inventoryLookPrice: 'inventory:viewCost',
  UserRightsEnum.inventoryEditPrice: 'inventory:editCost',
  UserRightsEnum.viewReference: 'inventory:viewReference',
  UserRightsEnum.editReference: 'inventory:reference',
  UserRightsEnum.shopeeAds: 'app:shopeeAds:add',
  UserRightsEnum.posBill: 'order:posBussinessBill',
  UserRightsEnum.shopManageBase: 'app:shopManage:base',
  UserRightsEnum.shopManageAuth: 'app:shopManage:auth',
  UserRightsEnum.shopManageDelete: 'app:shopManage:del',
  UserRightsEnum.newOrderHandle: 'order:newOrder',
  UserRightsEnum.posSaleAfter: 'order:saleAfter:appPos',
  UserRightsEnum.recordResendPhoto: 'app:orderManage:captureProof:resend',
};

/// 用户权限改变
class UserRightsChange {
  /// 用户拥有的权限
  List<String>? userRights = <String>[];

  /// 用户权限是否改变
  bool? changed;

  UserRightsChange({this.userRights, this.changed});
}
