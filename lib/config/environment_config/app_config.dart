import 'config.dart';
export 'config.dart';
import 'dev_config.dart';
import 'prod_config.dart';
import 'test_config.dart';

class AppConfig {
  static Config config = ProdConfig();

  static init() {
    switch (environment) {
      case Environment.prod:
        config = ProdConfig();
        break;
      case Environment.alpha:
        config = TestConfig();
        break;
      case Environment.dev:
        config = DevConfig();
        break;
    }
  }

  static Environment get env {
    return config.env();
  }

  static String get apiHost {
    return config.apiHost().trim();
  }

  static String get clientHost {
    return config.clientHost().trim();
  }

  static String get blogHost {
    return config.blogHost().trim();
  }

  static String get getAppNewVersion {
    return "/api/v1/plugIn/getWebNewVersion.json?fileType=bigSeller-app";
  }

  static String get getUpdateVersionInfoUrl {
    return "/api/v1/app/getUpdateVersionInfo.json";
  }

  static String get getSystemNoticeCount {
    return "/api/v1/app/notice/getSystemNoticeCount.json";
  }

  static String get requestAlertNotice {
    return "/api/v1/app/notice/getAlertNoticeCount.json";
  }

  static String get isAuthDuoke {
    return "/api/v1/app/scanAndScreen/isAuthDuoke.json";
  }

  static String get isVipAndMaster {
    return "/api/v1/app/isVipAndMaster.json";
  }

  static String get systemMessageUrl {
    return "$clientHost${config.systemMessageUrl()}";
  }

  static String get systemSetting {
    return "$clientHost${config.systemSettingUrl()}";
  }

  static String get blogUrl {
    return "$blogHost${config.blogUrl()}";
  }

  static String get aboutUrl {
    return "$clientHost${config.aboutUrl()}";
  }

  static String get aboutBigSellerUrl {
    return "$clientHost${config.aboutBigSellerUrl()}";
  }

  static String getUrl(String url) {
    return config.getUrl(url);
  }

  /// 后端健康
  static String get getaActuatorHealthUrl {
    return "/actuator/health";
  }

  static String get checkLogin {
    return "/api/v1/isLogin.json";
  }

  static String get changeLang {
    return "/api/v1/lang/changeLang.json";
  }

  static String get loginOut {
    return "/api/v1/user/logout.json";
  }

  static String get registerMessage {
    return "/api/v1/app/registerMessage.json";
  }

  static String get loginMessage {
    return "/api/v1/app/loginMessage.json";
  }

  static String get getUserInfo {
    return "/api/v1/app/getUserInfo.json";
  }

  static String get getSendErrorUrl {
    return "/api/v1/app/reportError.json";
  }

  static String get getUpdateUserSettingUrl {
    return "/api/v1/app/updateUserSetting.json";
  }

  static String get getAddQuickCountTaskUrl {
    return "/api/v1/app/stockCount/addQuickCountTask.json";
  }

  static String get getInventoryProofreadUrl {
    return "/api/v1/app/stockCount/getTaskDetail.json";
  }

  static String get getFinishInventoryUrl {
    return "/api/v1/app/stockCount/finishStockCount.json";
  }

  static String get getWarehouseListUrl {
    return "/api/v1/warehouse/getWarehouseInfoVoList.json";
  }

  static String get getReturnInfoUrl {
    return "/api/v1/app/scanAndRefund/getReturnInfo.json";
  }

  static String get getScanAndRefundUrl {
    return "/api/v1/app/scanAndRefund/returnWarehousing.json";
  }

  static String get getCommoditySKUSelectUrl {
    return "/api/v1/app/scanAndRefund/mappingRelation/skuSearch.json";
  }

  static String get getShelfBySkuIdAndWarehouseIdUrl {
    return "/api/v1/inventory/shelf/getShelfBySkuIdAndWarehouseId.json";
  }

  static String get getInventorySettingUrl {
    return "/api/v1/inventorySetting/list.json";
  }

  static String get getRequestSupplierListUrl {
    return "/api/v1/app/scan/receipt/supplierList.json";
  }

  static String get getScanReceiptPageListUrl {
    return "/api/v1/app/scan/receipt/pageList.json";
  }

  static String get getPurchaseReceivingDetailListUrl {
    return "/api/v1/app/scan/receipt/purchaseReceivingDetailList.json";
  }

  static String get getTransferReceiveDetailListUrl {
    return "/api/v1/app/scan/receipt/transferReceiveDetailList.json";
  }

  static String getMenuList(String module, String appVersion) {
    return "/api/v1/app/getMenuList/$module/$appVersion.json";
  }

  static String getMenuV2List(String module, String appVersion) {
    return "/api/v1/app/getMenuListV2/$module/$appVersion.json";
  }

  static String getMenuListVersion(String module, String appVersion) {
    return "/api/v1/app/getMenuListVersion/$module/$appVersion.json";
  }

  static String get getSalesDataUrl {
    return "/api/v1/app/statistic/getSaleDataNew.json";
  }

  static String get getScanSkuUrl {
    return "/api/v1/app/inventory/scanSku.json";
  }

  static String get getScanCodeWithExtraInfoUrl {
    return "/api/v1/app/inventory/scanCodeWithExtraInfo.json";
  }

  static String get getInOutInventorySkuUrl {
    return "/api/v1/app/inventory/inOut.json";
  }

  /// 获取商品sku或者货架位信息
  static String get getScanSkuAndShelfUrl {
    return '/api/v1/app/inventory/scanSkuAndShelf.json';
  }

  /// 获取当前币种
  static String get getCurrencyUrl {
    return "/api/v1/currency.json";
  }

  /// 获取用户站点
  static String get getSiteUrl {
    return "/api/v1/getSite.json";
  }

  /// 获取销售市场列表
  static String get getSaleMarketUrl {
    return "/api/v1/getSaleMarket.json";
  }

  /// 设置销售市场
  static String get getSetSaleMarketUrl {
    return "/api/v1/changeTimezone.json";
  }

  /// 获取店铺列表
  static String get getShopListUrl {
    return "/api/v1/app/shop/list.json";
  }

  /// lazada 授权地址
  static String get getLazadaMarketplaceUrl {
    return "/api/v1/app/shop/lazadaMarketplace.json";
  }

  /// 店铺统计接口
  static String get getShopCountUrl {
    return "/api/v1/app/shop/count.json";
  }

  /// 删除店铺授权接口
  static String get getDeleteShopUrl {
    return "/api/v1/shop/delete.json";
  }

  /// 获取授权链接
  static String getAuthUrl(String platform) {
    return "/api/v1/app/getAuthUrl/$platform.json";
  }

  /// 校验授权店铺信息
  static String get getShopCheckAuthUrl {
    return "/api/v1/app/shop/checkAuth.json";
  }

  /// 批量更新店铺名字接口-shopee 平台店铺授权
  static String get getBatchUpdateNameUrl {
    return "/api/v1/app/shop/batchUpdateName.json";
  }

  /// 获取对应业务当前剩余量:授权店铺、facebook 主页、子账号数量
  static String get getPaidGoodsNumUrl {
    return "/api/v1/app/account/getPaidGoodsNum.json";
  }

  /// 获取对应业务当前剩余量
  static String get getPaidGoodsUrl {
    return "/api/v1/goods/getPaidGoodsNum.json";
  }

  /// 用户权限接口
  static String get getUserRightsUrl {
    return '/api/v2/app/auth/userRights.json';
  }

  /// 获取账号vip 信息
  static String get getAccountVipInfoUrl {
    return "/api/v1/app/account/getVipInfo.json";
  }

  /// 查询用户是否存在授权店铺
  static String get getAccountQueryInfoUrl {
    return "/api/v1/app/account/queryInfo.json";
  }

  /// 刷新账号状态refresh session
  static String get getAccountRefreshUrl {
    return "/api/v1/app/account/refresh.json";
  }

  /// 降为免费版套餐
  static String get getAccountUpdateFreePlanUrl {
    return "/api/v1/app/account/updateFreePlan.json";
  }

  /// 获取订单列表
  static String get getOrderListUrl {
    return "/api/v1/app/getOrderInfo/getOrderPage.json";
  }

  /// 带筛选的订单列表
  static String get getOrderPageListUrl {
    return "/api/v1/app/getOrderInfo/pageList.json";
  }

  /// 获取批量打印列表面单
  static String get getPrintShopLogistics {
    return "/api/v1/app/getOrderInfo/getPrintShopLogisticsV2.json";
  }

  /// 打印之前的检验API接口
  static String get getCheckPrintInfoUrl {
    return "/api/v1/print/print/checkPrintInfo.json";
  }

  /// 打印之前的检验API接口
  static String get getSelfLabelManyUrl {
    return "/api/v1/print/print/selfLabel/many.json";
  }

  /// 打印面单 - 自定义面单打印
  static String get getLabelManyUrl {
    return "/api/v1/print/print/label/many.json";
  }

  /// 打印进度条
  static String get getOrderPrintProgressUrl {
    return "/api/v1/print/print/getOrderPrintProgress.json";
  }

  /// 打印预览标记
  static String get getAddLogPrintPreviewUrl {
    return "/api/v1/printAuto/addLogPrintPreview.json";
  }

  /// 标记已经打印的订单
  static String get getConfirmLabelPrintUrl {
    return "/api/v1/order/confirmLabelPrint.json";
  }

  /// 批量重新获取运单号
  static String get getBatchRefreshTrackNoUrl {
    return "/api/v1/order/batchRefreshTrackNo.json";
  }

  /// 获取商品/产品详情数据
  static String get getOrderDetailUrl {
    return "/api/v1/app/scanAndGetOrderDetail/getOrderDetail.json";
  }

  /// 获取商品/产品详情数据仓库商品
  static String get getMerchantDetailUrl {
    return "/api/v1/app/scanAndGetOrderDetail/getMerchantDetail.json";
  }

  /// 请求发货
  static String get getDeliverOrderUrl {
    return "/api/v1/app/scanAndShipping/ship.json";
  }

  /// 获取是否订单推送
  static String get getOrderPushUrl {
    return "/api/v1/app/subject/isOrderPush.json";
  }

  /// 设置订单推送开关
  static String get getOrderPushSetUrl {
    return "/api/v1/app/subject/orderPush.json";
  }

  /// 获取用户订单超限天数，未超限返回0
  static String get getOrderOutLimitDaysUrl {
    return "/api/v1/goods/getOrderOutLimitDays.json";
  }

  /// 获取库存预警开关
  static String get getInventoryAlertUrl {
    return "/api/v1/app/subject/inventoryAlert.json";
  }

  /// 设置订单推送开关
  static String get getIsInventoryAlertUrl {
    return "/api/v1/app/subject/isInventoryAlert.json";
  }

  /// 获取用户信息接口
  static String get getUserInfoUrl {
    return "/api/v1/index.json";
  }

  /// 获取波次发货功能-状态(开启或关闭)
  static String get getWaveSippedUsedStateUrl {
    return "/api/v1/order/wave/getWaveSippedUsedState.json";
  }

  /// 批量安排订单列表页V2
  static String get getBatchPackOrderPageUrl {
    return "/api/v1/app/getOrderInfo/batchPackOrderPageV2.json";
  }

  /// 单个安排订单
  static String get getPackOrderUrl {
    return "/api/v1/app/orderHandler/singlePackOrder.json";
  }

  /// 获取订单的pickup信息
  /// 地址列表
  static String get getPickupAddressListUrl {
    return "/api/v1/order/getPickupAddressList.json";
  }

  /// 订单 - 订单修改pick up 信息
  static String get getUpdatePickupInfoUrl {
    return "/api/v1/order/updatePickupInfo.json";
  }

  /// 批量安排订单
  static String get getBatchPackOrderUrl {
    return "/api/v4/app/orderHandler/batchPackOrder.json";
  }

  /// 获取取件信息
  static String get getPickupInfoUrl {
    return "/api/v3/app/orderHandler/pickupInfo.json";
  }

  /// 保存取件信息并安排订单
  static String get getBatchPickupPackOrderUrl {
    return "/api/v2/app/orderHandler/batchPickupPackOrder.json";
  }

  /// 消息数据统计接口
  static String get getMarkMessageUrl {
    return '/api/v1/app/notice/markMessage.json';
  }

  /// 搜索SKU
  static String get getSkuListUrl {
    return '/api/v1/app/sku/getSkuList.json';
  }

  ///注册api
  static String get registerApiUrl {
    return "/api/v1/app/auth/register.json";
  }

  /// 检查手机号码
  static String get phoneCodeAreaRegexUrl {
    return "/api/v1/app/auth/phoneCodeAreaRegex.json";
  }

  /// 获取手机区号
  static String get getPhoneCodeAreaAndRegexUrl {
    return "/api/v1/app/auth/getPhoneCodeAreaAndRegex.json";
  }

  ///发送邮箱验证码api
  static String get sendVerifyCodeApiUrl {
    return "/api/v2/email/sendVerifyCode.json";
  }

  ///生成验证码api
  static String get genVerifyCodeApiUrl {
    return "/api/v2/genVerifyCode.json";
  }

  /// 获取到已经发货的包裹数url
  static String get getScanAndShippingCountUrl {
    return "/api/v1/app/scanAndShipping/getCount.json";
  }

  /// app获取用户设置值url
  static String get getAppUserSettingValueUrl {
    return "/api/v1/app/getAppUserSettingValue.json";
  }

  /// 获取发货记录列表
  static String get getShippingRecordUrl {
    return "/api/v1/app/scanAndShipping/getPageList.json";
  }

  /// app获取用户设置(发货设置)
  static String get getShippingSettingUrl {
    return "/api/v1/app/getAppUserSetting.json";
  }

  /// app获取物流列表
  static String get getLogisticsUrl {
    return "/api/v1/orderSettings/other/index.json";
  }

  /// 扫描发货获取订单列表
  static String get getScanShippingOrderListUrl {
    return "/api/v1/app/scanAndShipping/scanGetOrderList.json";
  }

  /// 扫描发货
  static String get getScanToShipUrl {
    return "/api/v1/app/scanAndShipping/scanToShip.json";
  }

  /// 扫描发货 - 待后端自动签单逻辑
  static String get getScanToShipV2Url {
    return "/api/v1/app/scanAndShipping/v2/scanToShip.json";
  }

  /// 扫描发货 - 请求后端自动签单
  static String get getCreateOrderSignUrl {
    return "/api/v1/app/sign/create.json";
  }

  /// 生成快递签单
  /// grepId 物流组id
  /// orderIds 订单id列表
  static String get getGenerateExpressSignUrl {
    return "/api/v2/app/orderHandler/generateExpressSign.json";
  }

  /// 上报日志
  static String get getUploadLogUrl {
    return "/api/v1/app/uploadLog.json";
  }

  /// 获取用户上传标记 是否开始上传日志
  static String get getUploadFlagUrl {
    return "/api/v1/app/getUploadFlag.json";
  }

  /// 获取订单筛选列表项
  static String get orderSearchTabUrl {
    return "/api/v1/app/getOrderInfo/orderSearchTab.json";
  }

  /// 获取订单数量
  static String get orderCountUrl {
    return "/api/v1/app/getOrderInfo/appOrderCount.json";
  }

  /// MARK - 波次发货
  /// 获取波次发货列表
  static String get waveShipmentListUrl {
    return '/api/v1/app/order/wave/getPickWaveList.json';
  }

  /// MARK - 校验波次是否已分配
  /// 校验波次是否已分配
  static String get checkWaveIsAssignUrl {
    return '/api/v1/app/order/wave/checkWaveIsAssign.json';
  }

  /// 是否有正在波次拣货的单
  static String get waveInPickingUrl {
    return '/api/v1/app/order/wave/waveInPicking.json';
  }

  /// 绑定拣货车接口
  static String get bindPickupTruckUrl {
    return '/api/v1/app/order/wave/bindPickupTruck.json';
  }

  /// 获取波次拣货类型
  static String get getWavePickTypeUrl {
    return '/api/v1/app/order/wave/getMultiplePackagePickType.json';
  }

  /// 获取拣货顺序的SKU列表
  static String get sortSkuListUrl {
    return '/api/v1/app/order/wave/getSortSkuList.json';
  }

  /// 获取拣货详情
  static String get getPickingDetailsListUrl {
    return '/api/v1/app/order/wave/getPickingDetailsList.json';
  }

  /// 获取分拣列表
  static String get getPickingSeparateListUrl {
    return '/api/v1/app/order/wave/getBeforePickingDetailsList.json';
  }

  /// 查询SKU拣货
  static String get skuPickUrl {
    return "/api/v1/order/wave/pda/skuPick.json";
  }

  /// 查询SKUs拣货 批量拣货
  static String get skuBatchPicksUrl {
    return "/api/v1/order/wave/pda/v2/skuPicks.json";
  }

  /// 标记缺货接口
  static String get getMarkOutOfStockUrl {
    return "/api/v1/app/order/wave/markOutOfStock.json";
  }

  /// 清空重置接口
  static String get getClearResetWaveUrl {
    return "/api/v1/app/order/wave/clearReset.json";
  }

  /// 结束拣货接口
  static String get getEndPickingUrl {
    return "/api/v1/app/order/wave/endPicking.json";
  }

  /// 获取该波次下缺货的所有商品sku信息列表接口
  static String get getOutOfStockSkuIdUrl {
    return "/api/v1/app/order/wave/getOutOfStockSkuId.json";
  }

  /// 取消缺货标记接口
  static String get getCancelMarkOutOfStockUrl {
    return "/api/v1/app/order/wave/cancelMarkOutOfStock.json";
  }

  /// 获取商品库存信息
  static String get getInventoryListUrl {
    return "/api/v1/app/inventory/pageList.json";
  }

  /// 获取商品库存信息
  static String get getInventoryV2ListUrl {
    return "/api/v1/app/inventory/v2/pageList.json";
  }

  static String get getInventoryV3ListUrl {
    return "/api/v1/app/inventory/v3/pageList.json";
  }

  /// 获取商品分类
  static String get getMerchantSKUCategoryUrl {
    return "/api/v1/app/inventory/classifyList.json";
  }

  /// 扫描发图获取订单信息
  static String get getScanPhotoOrderUrl {
    return '/api/v2/app/scanAndScreen/getOrder.json';
  }

  /// 请求信息模板列表
  static String get getListTemplate {
    return '/api/v1/app/scanAndScreen/getListTemplate.json';
  }

  /// 删除信息模板
  static String get getDeleteInfoItemUrl {
    return '/api/v1/app/scanAndScreen/deleteTemplate.json';
  }

  /// 编辑信息模板
  static String get getEditTemplateUrl {
    return '/api/v1/app/scanAndScreen/editTemplate.json';
  }

  /// 获取默认的信息模版
  static String get getDefaultTemplateUrl {
    return '/api/v1/app/scanAndScreen/getDefaultTemplate.json';
  }

  /// 扫描发图 - 发送消息接口
  static String get getSendPhotoMessageUrl {
    return '/api/v1/app/scanAndScreen/sendMessage.json';
  }

  ///- 订单店铺是否授权多客
  static String get getCheckDuokeAuthUrl {
    return '/api/v1/app/checkDuokeAuth.json';
  }

  ///- 获取用户仓库列表
  static String get getWarehouseListsUrl {
    return '/api/v1/app/getWarehouseInfo/settingList.json';
  }

  ///- 解绑拣货车
  static String get getUnBindPickupTruckUrl {
    return '/api/v1/app/order/wave/unBindPickupTruck.json';
  }

  ///- APP检测到本账号已在盘点，是否跳转到正在盘点的任务
  static String get getCountingTaskUrl {
    return '/api/v1/app/stockCount/getAppCountingTask.json';
  }

  ///- APP获取盘点任务详情列表
  static String get getManualTaskDetailUrl {
    return '/api/v1/app/stockCount/getAppManualTaskDetail.json';
  }

  ///- APP盘点跳过货架位/SKU
  static String get getSkipShelfOrSkuUrl {
    return '/api/v1/app/stockCount/skipShelfOrSku.json';
  }

  ///-  临时保存App随意盘点前置校验
  static String get getPreAppStockCountingSaveCheckUrl {
    return '/api/v1/app/stockCount/preAppStockCountingSaveCheck.json';
  }

  ///- 临时保存App随意盘点
  static String get getStockCountingSaveUrl {
    return '/api/v1/app/stockCount/appStockCountingSave.json';
  }

  ///- 保存并结束App随意盘点
  static String get getCasualnessFinishStockCountUrl {
    return '/api/v1/app/stockCount/appCasualnessFinishStockCount.json';
  }

  ///- App结束盘点进度接口
  static String get getGetFinishStockCountProgressUrl {
    return '/api/v1/app/stockCount/appGetFinishStockCountProgress.json';
  }

  ///- 生成盘点单
  static String get getCountingTaskCreateUrl {
    return '/api/v1/app/stockCount/appCountingTaskCreate.json';
  }

  ///- 获取货架位列表
  static String get getShelfListUrl {
    return '/api/v1/app/scanAndRefund/getShelfBySkuIdAndWarehouseId.json';
  }

  /// APP日活接口
  static String get getDailyActiveUrl {
    return '/api/v1/au/app/report.json';
  }

  /// 上下架获取商品信息
  static String get getPutPullShelfGoodsInfoUrl {
    return '/api/v1/app/putPullShelf/getGoodsInfo.json';
  }

  /// APP扫描上架获取订单信息
  static String get getCheckPutShelfGoodsUrl {
    return '/api/v1/app/inventory/move/checkPutShelfGoods.json';
  }

  /// APP扫描下架获取订单信息
  static String get getCheckPullShelfGoodsUrl {
    return '/api/v1/app/inventory/move/checkPullShelfGoods.json';
  }

  /// APP-上下架
  static String get getDownOrUpSubmitUrl {
    return '/api/v1/app/inventory/move/downOrUpSubmit.json';
  }

  /// 可用货架位列表接口
  static String get getShelfAvailableListUrl {
    return '/api/v1/app/inventory/shelf/availableList.json';
  }

  /// 设置货架位接口
  static String get getSetShelfUrl {
    return '/api/v1/app/inventory/shelf/setShelf.json';
  }

  /// 商品销售排行
  static String get getSkuSaleStatUrl {
    return '/api/v1/app/statistic/skuSaleStatNew.json';
  }

  ///  扫描运单号或者运单获取订单信息
  static String get getScanTrackingNoUrl {
    return '/api/v1/app/examineGoods/scanTrackingNoNew.json';
  }

  /// 进入扫描发货页面接口 --获取物流列表
  static String get getScanShipLogisticsUrl {
    return '/api/v1/app/examineGoods/shipLogistics.json';
  }

  /// 扫描发货设置
  static String get getSaveScanInspectionSettingUrl {
    return '/api/v1/app/examineGoods/saveScanInspectionSetting.json';
  }

  /// 获取用户配置- 验货发货相关
  static String get getOrderSingPrintTrackingNoUrl {
    return '/api/v1/scanConfig/getOrderSingPrintTrackingNo.json';
  }

  /// 订单 - 扫描验货成功接口
  static String get getScanVerifySuccessUrl {
    return '/api/v1/app/examineGoods/scanVerifySuccess.json';
  }

  /// 获取用户订单相关的配置
  static String get getOrderConfigUrl {
    return '/api/v1/app/getOrderConfig.json';
  }

  /// 注册登录： 和旧接口/api/v1/app/auth/register.json保持一致
  static String get getRegisterOneStepValidateUrl {
    return '/api/v1/app/auth/registerOneStepValidate.json';
  }

  /// 获取店铺列表URL
  static String get getShopListsUrl {
    return '/api/v1/app/pos/index.json';
  }

  /// 获取客户列表URL
  static String get getCustomerListUrl {
    return '/api/v1/app/customer/pageList.json';
  }

  /// 获取客户地址URL
  static String get getRecipientAddressListUrl {
    return '/api/v1/app/customer/getRecipientAddressList.json';
  }

  /// 生成结算订单url
  static String get getGenerateSettleUrl {
    return '/api/v1/app/pos/add.json';
  }

  /// 获取POS订单的店铺的费率等信息URL
  static String get getPosShopTaxSettingDetailUrl {
    return '/api/v1/app/pos/getPosShopTaxSettingDetail.json';
  }

  /// 保存POS设置的信息
  static String get updatePosShopTaxSettingUrl {
    return '/api/v1/app/pos/updatePosShopTaxSetting.json';
  }

  /// 获取地区URL
  static String get getSiteAreaByPid {
    return '/api/v1/app/area/leaf.json';
  }

  /// 获取保存客户接口URL
  static String get getPosSaveClientUrl {
    return '/api/v1/app/customer/save.json';
  }

  /// POS扫描获取商品信息
  static String get getPosGoodInfoUrl {
    return '/api/v1/app/pos/scanSku.json';
  }

  /// POS取商品列表信息
  static String get getSelectSkuUrl {
    return '/api/v1/app/pos/selectSku.json';
  }

  /// 获取POS订单小票
  static String get getPrintPosReceiptUrl {
    return '/api/v1/print/app/receipt/printPosReceipt.json';
  }

  /// 获取POS订单小票数据
  static String get getPrintPosReceiptDataUrl {
    return '/api/v1/app/receipt/print/selfReceipt.json';
  }

  /// 获取用户已授权平台及店铺接口
  static String get getShopsAndPlatformsUrl {
    return '/api/v1/shopsAndPlatforms.json';
  }

  /// 波次仓库列表
  static String get getWaveWarehouseListUrl {
    return "/api/v1/warehouse/waveWarehouseList.json";
  }

  /// 获取统计列表数据 店铺分析、订单分析
  static String get getListStatsDataUrl {
    return '/api/app/dataReports/listStatsData.json';
  }

  /// 店铺概览
  static String get getStoreTotalDataUrl {
    return '/api/app/dataReports/getStoreTotalData.json';
  }

  /// 销售报告数据URL
  static String get getSaleDataUrl {
    return '/api/app/dataReports/stats/statsValidCount.json';
  }

  /// 销售报告数据报告URL
  static String get getSaleDataReportUrl {
    return '/api/app/dataReports/items/getItemCount.json';
  }

  /// 销售报告SKU数据报告URL
  static String get getSaleReportSKUUrl {
    return '/api/app/dataReports/items/pageList.json';
  }

  ///  店铺分析--汇总明细URL
  static String get getStoreAnalysisDetailUrl {
    return '/api/app/dataReports/getStoreAnalysisDetail.json';
  }

  /// 获取申请取消订单url
  static String get getHandleApplyCancelOrderUrl {
    return "/api/v1/app/getOrderInfo/reverse/order.json";
  }

  /// 获取是否取消订单申请推送
  static String get getCancelOrderPushUrl {
    return "/api/v1/app/subject/isCancelOrderPush.json";
  }

  /// 设置取消订单申请推送开关
  static String get getCancelOrderPushSetUrl {
    return "/api/v1/app/subject/cancelOrderPush.json";
  }

  /// 编辑订单备注
  static String get editOrderRemark {
    return "/api/v1/app/order/sign/edit/remark.json";
  }

  /// 获取订单标记列表
  static String get getOrderLabelList {
    return "/api/v1/app/order/sign/getLables.json";
  }

  /// 编辑订单标记标签
  static String get editOrderLabels {
    return "/api/v1/app/order/sign/simpleAddOrDeleteLabel.json";
  }

  /// 测试订单推送
  static String get getOrderTestPushUrl {
    return "/api/v1/app/getOrderInfo/push.json";
  }

  /// 获取是否存在 新订单订阅通知数据 || 取消订单通知订阅数据 没有则存一条，并设置成默认开启
  static String get getNotificationUrl {
    return "/api/v1/app/subject/notification.json";
  }

  /// 获取商品库库存清单 统计
  static String get getInventoryStatisticsUrl {
    return "/api/v1/app/inventory/statistics.json";
  }

  /// 查询SKU的货架位- 一货多位
  static String get getSkuMultiShelfUrl {
    return "/api/v1/app/inventory/skuMultiShelf.json";
  }

  /// 查询库存的批次明细
  static String get getInventoryBatchDetails {
    return "/api/v1/app/inventory/getInventoryBatchDetails.json";
  }

  /// 查询SKU的货架位- 一货多位 数量
  static String get getSkuMultiShelfNumUrl {
    return "/api/v1/app/inventory/skuMultiShelfNum.json";
  }

  /// 查询SKU信息
  static String get getSkuUrl {
    return "/api/v1/app/inventory/sku.json";
  }

  /// 查询SKU信息详情
  static String get getSkuDetailUrl {
    return "/api/v1/app/inventory/detail.json";
  }

  /// 存图URL
  static String get addSaveImageUrl {
    return "/api/v1/app/scanAndScreen/addSaveImage.json";
  }

  /// 存图列表URL
  static String get saveImageListUrl {
    return "/api/v1/app/scanAndScreen/saveImageList.json";
  }

  /// 删除存图列表中的图片URL
  static String get delSaveImageUrl {
    return "/api/v1/app/scanAndScreen/delSaveImage.json";
  }

  /// 扫描发图发消息URl
  static String get sendPhotoMessageUrl {
    return "/api/v2/app/scanAndScreen/sendMessage.json";
  }

  /// 采购收货详情（单个采购单）
  static String get getPurchaseReceiveDetailUrl {
    return "/api/v1/app/scan/receipt/purchaseReceiveDetail.json";
  }

  /// 调拨收货详情接口（单个采购单）
  static String get getTransferReceiveDetailUrl {
    return "/api/v1/app/scan/receipt/receiveDetail.json";
  }

  /// 获取货架位上可用SKU数量
  static String get getAvailableByShelfIdUrl {
    return "/api/v1/app/inventory/getAvailableByShelfId.json";
  }

  /// 获取快速订单通知开关
  static String get getFastOrderPushUrl {
    return "/api/v1/app/subject/isQuickOrderPush.json";
  }

  /// 设置快速订单通知开关
  static String get getFastOrderPushSetUrl {
    return "/api/v1/app/subject/quickOrderPush.json";
  }

  /// 获取手机发送验证码接口
  static String get getSendRegPhoneCodeUrl {
    return '/api/v2/app/auth/sendRegPhoneCode.json';
  }

  /// 注册接口
  static String get getRegisterUrl {
    return '/api/v2/app/auth/register.json';
  }

  /// 登录api
  static String get loginApiUrl {
    return "/api/v2/app/auth/login.json";
  }

  /// 采购收货
  static String get getPurchaseReceiveUrl {
    return "/api/v1/app/scan/receipt/batchReceiving.json";
  }

  /// 采购收货进度查询
  static String get getPurchaseReceiveProcessUrl {
    return "/api/v1/app/scan/receipt/batchReceivingProcess.json";
  }

  /// 调拨收货
  static String get getTransferReceiveUrl {
    return "/api/v1/app/scan/receipt/batchTransferReceiving.json";
  }

  /// 调拨收货进度查询
  static String get getTransferReceiveProcessUrl {
    return "/api/v1/app/scan/receipt/batchTransferReceivingProcess.json";
  }

  /// POS订单获取支付渠道
  static String get payChannelUrl {
    return '/api/v1/app/pos/payChannel.json';
  }

  /// 获取用户的店铺组
  static String get getShopGroupUrl {
    return '/api/v1/app/shopGroup/page.json';
  }

  /// 获取平台排行数据
  static String get getShopOrPlatformSaleStatUrl {
    return '/api/v1/app/statistic/shopOrPlatformSaleStat.json';
  }

  /// 热卖产品 top - 100
  static String get getHotSaleStatUrl {
    return '/api/v1/app/statistic/hotSaleStat.json';
  }

  /// 平类排行
  static String get getHotCategorySaleStatUrl {
    return '/api/v1/app/statistic/hotCategorySaleStat.json';
  }

  /// 获取今日昨日销售曲线图数据
  static String get getOrderSaleTrendUrl {
    return "/api/v1/app/statistic/orderSaleStatNew.json";
  }

  /// 获取今日仓发情况
  static String get getOrderShippedStatUrl {
    return "/api/v1/app/statistic/orderShippedStatNew.json";
  }

  /// 手动入库出库
  static String get getInOutInventoryUrl {
    return "/api/v1/app/inventory/list/inOut.json";
  }

  /// 出入库单 删除SKU
  static String get getDelWarrantSkuUrl {
    return "/api/v1/app/warrant/delDetails.json";
  }

  /// 判断扫描的码是否是出入库单
  static String get getIsWarehouseWarrantUrl {
    return "/api/v1/app/warrant/isWarehouseWarrant.json";
  }

  /// 判断扫描的码是否是出入库单 并返回数据
  static String get getWarehouseWarrantUrl {
    return "/api/v1/app/warrant/warehouseInoutList.json";
  }

  /// 获取出入库单数据详情
  static String get getInoutListDetailsUrl {
    return "/api/v1/app/warrant/inoutListDetails.json";
  }

  /// 出入库获取明细接口
  static String get getWarrantInoutEdDetailsUrl {
    return "/api/v1/app/warrant/inoutEdDetails.json";
  }

  /// 编辑添加添加库存SKU出入单接口
  static String get getWarrantEditAddUrl {
    return "/api/v1/app/warrant/editAdd.json";
  }

  /// 编辑添加添加库存SKU出入单接口
  static String get getWarrantQtyEditUrl {
    return "/api/v1/app/warrant/qtyEdit.json";
  }

  /// 入库单效期时间编辑接口
  static String get getExpiryDateEditUrl {
    return "/api/v1/app/warrant/expiryDateEdit.json";
  }

  /// 出入库单批量删除SKU
  static String get getWarrantBatchDeleteSkuUrl {
    return "/api/v1/app/warrant/batchDeleteSku.json";
  }

  /// 出入库单货架位编辑接口
  static String get getWarrantShelfEditUrl {
    return "/api/v1/app/warrant/shelfEdit.json";
  }

  /// 执行出入库单SKU出入库操作接口
  static String get getWarrantInoutStockUrl {
    return "/api/v1/app/warrant/exeSkuInoutStock.json";
  }

  /// 扫描获取SKU信息
  static String get getWarrantSkuInfoUrl {
    return "/api/v1/app/warrant/merchant/code.json";
  }

  /// 获取波次展示 包裹数量等 配置
  static String get getWaveColumnConfigUrl {
    return '/api/v1/app/order/wave/getColumnConfig.json';
  }

  /// 获取仓库下所有的库区
  static String get getWarehouseZoneListUrl {
    return '/api/v1/app/warehouseZone/getWarehouseZoneList.json';
  }

  /// 获取  更新用户设置的 选择等配置 URL
  static String get getUpdateUserChooseConfigUrl {
    return '/api/v1/setting/config/updateUserChooseConfig.json';
  }

  /// 获取 用户设置的 选择等配置 URL
  static String get getUserChooseConfigUrl {
    return '/api/v1/setting/config/getUserChooseConfigs.json';
  }

  /// 移货

  /// 获取挪货 分页列表
  static String get getMovingGoodsPageListUrl {
    return '/api/v1/app/inventory/movingPlan/pageList.json';
  }

  /// 根据筛选条件获取各个状态的单据数量
  static String get getMoveStockCountUrl {
    return '/api/v1/app/inventory/movingPlan/stateCount.json';
  }

  /// 根据 任务数量=待拣货中PC端对应移动端默认管理仓库下的待拣货全量+待认领状态中取操作员为该UID的默认管理仓库下的单据数量
  static String get getMoveStockTaskCountUrl {
    return '/api/v1/app/inventory/movingPlan/count.json';
  }

  /// 挪货认领 任务
  static String get getMoveGoodsClaimTaskUrl {
    return '/api/v1/app/inventory/movingPlan/claim.json';
  }

  /// 挪货取消认领 任务
  static String get getMoveGoodsUnClaimTaskUrl {
    return '/api/v1/app/inventory/movingPlan/cancelClaim.json';
  }

  /// 验证 移货单-是否存有未结束的任务
  static String get getMoveGoodsUnfinishedTasksUrl {
    return '/api/v1/app/inventory/movingPlan/getActivePlan.json';
  }

  /// 开始 移货单-拣货
  static String get getStartMovePickingUrl {
    return '/api/v1/app/inventory/movingPlan/startPickingVerify.json';
  }

  /// 获取 移货单 SKU列表
  static String get getMovePickSkuListUrl {
    return '/api/v1/app/inventory/movingPlan/startPicking.json';
  }

  /// 开始 移货单 拣货
  static String get getMoveSavePickUrl {
    return '/api/v1/app/inventory/movingPlan/savePicking.json';
  }

  /// 获取 移货单 上架 SKU列表
  static String get getMoveShelvesSkuListUrl {
    return '/api/v1/app/inventory/movingPlan/startShelves.json';
  }

  /// 获取 移货单 上架 按货架位保存
  static String get getMoveShelvesSaveShelfSkuUrl {
    return '/api/v1/app/inventory/movingPlan/saveShelves.json';
  }

  /// 获取 移货单 上架 按SKU保存
  static String get getMoveShelvesSaveSkuUrl {
    return '/api/v1/app/inventory/movingPlan/saveShelvesBySku.json';
  }

  /// 获取 获取拣货/上架进度，type=1=拣货，2=上架
  static String get getMovePickProgressUrl {
    return '/api/v1/app/inventory/movingPlan/getProgress.json';
  }

  /// 获取 移货 终止任务校验
  static String get getMoveTerminateTaskCheckUrl {
    return '/api/v1/app/inventory/movingPlan/moveTerminateBeforeCheck.json';
  }

  /// 获取 终止任务/结束拣货
  static String get getTerminateTaskUrl {
    return '/api/v1/app/inventory/movingPlan/terminate.json';
  }

  /// 获取 移货 补货，上架过程中是否可以修改货架位
  static String get getColumnConfigUrl {
    return '/api/v1/app/order/wave/getColumnConfig.json';
  }

  /// 获取 移货 获取货架位可用库存
  static String get getShelfInfoUrl {
    return '/api/v1/app/inventory/shelf/getShelfInfo.json';
  }

  /// 补货
  ///
  /// 获取补货 分页列表
  static String get getRepleteGoodsPageListUrl {
    return '/api/v1/app/inventory/repletePlain/pageList.json';
  }

  /// 补货 根据筛选条件获取各个状态的单据数量
  static String get getRepleteStockCountUrl {
    return '/api/v1/app/inventory/repletePlain/stateCount.json';
  }

  /// 补货认领 OR 取消认领 任务
  static String get getRepleteGoodsClaimUnClaimTaskUrl {
    return '/api/v1/app/inventory/repletePlain/setClaim.json';
  }

  /// 验证补货单-是否存有未结束的任务
  static String get getRepleteGoodsUnfinishedTasksUrl {
    return '/api/v1/app/inventory/repletePlain/verifyUnfinishedTasks.json';
  }

  /// 开始 补货单-拣货
  static String get getStartRepletePickingUrl {
    return '/api/v1/app/inventory/repletePlain/pickingInfo.json';
  }

  /// 获取 补货单 SKU列表
  static String get getRepletePickSkuListUrl {
    return '/api/v1/app/inventory/repletePlain/pickingInfo.json';
  }

  /// 开始 补货单 拣货
  static String get getRepleteStartPickUrl {
    return '/api/v1/app/inventory/movingPlan/savePicking.json';
  }

  /// 联系我们列表
  static String get getContactUsListUrl {
    return '/api/v1/app/customerServices.json';
  }

  /// 检测货架位是否可以设置
  static String get getCheckShelfUrl {
    return '/api/v1/app/inventory/shelf/checkShelf.json';
  }

  /// 开始 补货 拣货接口 SKU、货架位
  static String get getRepletePickSkuOreShelfUrl {
    return '/api/v1/app/inventory/repletePlain/skuOrShelfPicking.json';
  }

  /// 补货，上架SKU列表
  static String get getShelvingSkuListUrl {
    return '/api/v1/app/inventory/repletePlain/shelvingInfo.json';
  }

  /// 开始 补货 上架接口 SKU、货架位
  static String get getRepleteShelveSkuOreShelfUrl {
    return '/api/v1/app/inventory/repletePlain/skuOrShelfShelving.json';
  }

  /// 获取 终止任务
  static String get getRepleteTerminateTaskUrl {
    return '/api/v1/app/inventory/repletePlain/stateChangeCompleted.json';
  }

  /// 获取 补货终止任务前校验
  static String get getRepleteTerminateTaskCheckUrl {
    return '/api/v1/app/inventory/repletePlain/repleteTerminateBeforeCheck.json';
  }

  /// 获取 结束拣货
  static String get getRepleteEndTaskUrl {
    return '/api/v1/app/inventory/repletePlain/shelvingEnd.json';
  }

  /// 获取SKU优先的货架位
  static String get getPriorityShelfUrl {
    return "/api/v1/inventory/shelf/getPriorityShelfBySkuIdAndWarehouseId.json";
  }

  /// 退货备注编辑URl
  static String get editRefundRemarkUrl {
    return "/api/v1/app/scanAndRefund/saveInWarehouseRemark.json";
  }

  /// 上下架验证
  static String get downUpVerifyUrl {
    return "/api/v1/app/inventory/move/downUpVerify.json";
  }

  /// APP-上下架
  static String get getDownUpSubmitUrl {
    return '/api/v1/app/inventory/move/downUp.json';
  }

  /// 批量获取SKU信息
  static String get getListWarehouseSkuUrl {
    return '/api/v1/app/inventory/move/listWarehouseSku.json';
  }

  /// 出入库单修改备注
  static String get warrantEditNoteUrl {
    return "/api/v1/app/warrant/noteEdit.json";
  }

  /// 获取生成波次订单列表url
  static String get wavePreviewListUrl {
    return '/api/v1/app/order/wave/wavePreview.json';
  }

  /// 获取波次物流组
  static String get shipProviderGroupListUrl {
    return "/api/v1/app/order/wave/shipProviderGroupList.json";
  }

  /// 波次发货-订单筛选汇总-订单范围
  static String get generateWaveOrderSummaryUrl {
    return "/api/v1/app/order/wave/getGenerateWaveOrderSummary.json";
  }

  /// 校验是否存在异常订单
  static String get verifyExistExceptionOrderUrl {
    return "/api/v1/app/order/wave/verifyExistExceptionOrder.json";
  }

  /// 波次列表页 --- 店铺，平台，物流订单的数量
  static String get waveOrderCountUrl {
    return "/api/v1/app/order/wave/getWaveOrderCount.json";
  }

  /// 获取开启的物流信息接口，添加物流分组使用
  static String get openShipProviderListUrl {
    return "/api/v1/app/order/wave/openShipProviderList.json";
  }

  /// 待生成波次物流 - 获取待生成波次物流信息
  static String get generateWaveShipProviderUrl {
    return "/api/v1/app/order/wave/getGenerateWaveShipProvider.json";
  }

  /// 波次生成
  static String get generateWaveUrl {
    return "/api/v1/app/order/wave/generateWave.json";
  }

  /// 获取波次类型
  static String get waveWaveTypeListUrl {
    return "/api/v1/app/order/wave/waveTypeList.json";
  }

  /// 获取规则分组
  static String get ruleGroupsListUrl {
    return "/api/v1/app/order/wave/rule/dropDownList.json";
  }

  /// 获取生成波次订单列表url 分页查询，可以按筛选条件筛选 前需要调用此接口
  static String get wavePreviewInsertUrl {
    return "/api/v1/app/order/wave/wavePreview/insert.json";
  }

  /// 获取生成波次订单列表url 分页查询，可以按筛选条件筛选
  static String get wavePreviewQueryListUrl {
    return "/api/v1/app/order/wave/wavePreview/queryList.json";
  }

  /// 搜索货架位信息
  static String get getShelfListByShelfNameUrl {
    return '/api/v1/app/inventory/shelf/getShelfListByShelfName.json';
  }

  /// APP调整货架位获取sku/货架位信息
  static String get moveShelfVerifyUrl {
    return '/api/v1/app/inventory/move/moveShelfVerify.json';
  }

  /// APP调整货架位
  static String get moveShelfUrl {
    return '/api/v1/app/inventory/move/moveShelf.json';
  }

  /// 获取 各个库区的波次数据
  static String get waveZoneWaveNumUrl {
    return "/api/v1/app/warehouseZone/getWaveZoneStats.json";
  }

  /// MARK - shopee广告-活动数据
  ///
  /// 获取 shopee广告活动数据总览
  static String get queryShopeeActivityCampaignTotalDataUrl {
    return '/api/app/shopee/ad/queryShopeeAdsCampaignTotalData.json';
  }

  /// 获取 shopee广告活动统计列表数据 + 走势图
  static String get queryActivityCampaignDailyStatsDataUrl {
    return '/api/app/shopee/ad/queryCampaignDailyStatsData.json';
  }

  /// 获取 shopee广告活动统计列表数据 + 走势图 （单个小时图）
  static String get queryActivityCampaignDailyHourStatsDataUrl {
    return '/api/app/shopee/ad/queryCampaignDailyHourStatsDataNew.json';
  }

  /// 获取 广告活动明细 - excel表格图
  static String get queryActivityAdCampaignShopInfoUrl {
    return '/api/app/shopee/ad/queryAdCampaignShopInfoPage.json';
  }

  /// MARK - shopee广告-店铺报告数据
  ///
  /// 获取 shopee广告 店铺 数据总览
  static String get queryShopeeShopCampaignTotalDataUrl {
    return '/api/app/shopee/ad/queryShopeeAdsTotalDataNew.json';
  }

  /// 获取 shopee广告 店铺 统计列表数据 + 走势图
  static String get queryShopCampaignDailyStatsDataUrl {
    return '/api/app/shopee/ad/queryDailyStatsData.json';
  }

  /// 获取 shopee广告 店铺 统计列表数据 + 走势图 （单个小时图）
  static String get queryShopCampaignDailyHourStatsDataUrl {
    return '/api/app/shopee/ad/queryDailyHourStatsDataNew.json';
  }

  /// 获取 广告 店铺 明细 - excel表格图
  static String get queryShopAdCampaignShopInfoUrl {
    return '/api/app/shopee/ad/queryAdShopInfoPageNew.json';
  }

  /// 获取 某个平台授权的店铺
  static String get authShopUrl {
    return '/api/app/shopee/ad/authShop/list.json';
  }

  /// 获取 SKU的未上架数量
  static String get wareHouseSkuUnShelfUrl {
    return "/api/v1/app/inventory/movingPlan/getWareHouseSkuUnShelf.json";
  }

  /// MARK - 输入框联想
  ///
  /// 联想搜索 上下架 默认页
  static String get moveDefaultPageAssociateUrl {
    return '/api/v1/app/inventory/move/defaultPage/associate.json';
  }

  /// 联想搜索 上下架 操作页
  static String get moveOperationPageAssociateUrl {
    return '/api/v1/app/inventory/move/operationPage/associate.json';
  }

  /// 联想搜索 货位调整 操作页
  static String get moveShelfOperationPageAssociateUrl {
    return '/api/v1/app/inventory/move/moveShelf/operationPage/associate.json';
  }

  /// 联想搜索 货位调整 默认页
  static String get moveShelfDefaultPageAssociateUrl {
    return '/api/v1/app/inventory/move/moveShelf/defaultPage/associate.json';
  }

  /// 联想搜索 一货多位 默认页
  static String get moveShelfMultiDefaultPageAssociateUrl {
    return '/api/v1/app/inventory/move/moveShelf/multi/defaultPage/associate.json';
  }

  /// 联想搜索 一货多位 操作页
  static String get moveShelfMultiOperationPageAssociateUrl {
    return '/api/v1/app/inventory/move/moveShelf/multi/operationPage/associate.json';
  }

  /// 联想搜索 移货
  static String get movingPlanAssociateUrl {
    return '/api/v1/app/inventory/movingPlan/associate.json';
  }

  /// 联想搜索 补货
  static String get repletePlainAssociateUrl {
    return '/api/v1/app/inventory/repletePlain/associate.json';
  }

  /// 联想搜索 盘点
  static String get stockCountAssociateUrl {
    return '/api/v1/app/stockCount/associate.json';
  }

  /// 联想搜索 手动出入库单
  static String get inOutAssociateUrl {
    return '/api/v1/app/inventory/inOut/associate.json';
  }

  /// APP库存页联想查询接口
  static String get inventoryAssociateUrl {
    return '/api/v1/app/inventory/associate.json';
  }

  /// 简易盘点的联想接口
  static String get stockCountSimpleAssociateUrl {
    return '/api/v1/app/stockCount/simple/associate.json';
  }

  /// 获取 发图记录列表
  static String get sendRecordListUrl {
    return '/api/v1/app/duoke/getMessageList.json';
  }

  /// 重新发送图片
  static String get reSendPhotoMessageUrl {
    return '/api/v1/app/duoke/sendMessage.json';
  }

  /// 获取POS账单详情
  static String get posOrderBussBillDetailUrl {
    return '/api/v1/app/pos/getPosOrderBussBillDetail.json';
  }

  /// POS关账
  static String get closeBussBillUrl {
    return '/api/v1/app/pos/closeBussBill.json';
  }

  /// 获取POS账单-获取关账记录-分页
  static String get posBillRecordUrl {
    return '/api/v1/app/pos/getPosOrderBussBillPage.json';
  }

  /// pos零售营销报表设置接口
  static String get posBillSetUrl {
    return '/api/v1/app/pos/updatePosBussBillConfig.json';
  }

  /// 获取pos零售营销设置接口
  static String get posBillSetConfigUrl {
    return '/api/v1/app/pos/getPosBussBillConfig.json';
  }

  /// 获取pos零售营销设置接口
  static String get printPosBillUrl {
    return '/api/v1/print/app/pos/printPosBussBill.json';
  }

  /// 同步店铺数据信息
  static String get syncShopAdInfoUrl {
    return '/api/app/shopee/ad/syncShopAdInfo.json';
  }

  /// 查询shopee广告数据 进度
  static String get syncShopeeDataProcessUrl {
    return '/api/v1/process/checkProcess.json';
  }

  /// 同步店铺数据信息 时间
  static String get syncShopAdITimeUrl {
    return '/api/app/shopee/ad/getRefreshTime.json';
  }

  /// 波次二次分拣列表接口
  static String get waveTwicePickListUrl {
    return '/api/v1/app/order/wave/getSortPickWaveList.json';
  }

  /// 波次二次分拣列表接口 数量接口
  static String get sortPickWaveListCountUrl {
    return '/api/v1/app/order/wave/getSortPickWaveListCount.json';
  }

  /// 二次分拣列表搜索后端提示报错接口
  static String get searchValidSortPickWaveUrl {
    return '/api/v1/app/order/wave/validSortPickWave.json';
  }

  /// 波次二次分拣 开始接口
  static String get scanSortPickWaveUrl {
    return '/api/v1/app/order/wave/scanSortPickWave.json';
  }

  /// 波次二次分拣 无表模式
  static String get getSortingNoLabelUrl {
    return '/api/v1/app/order/wave/openSortingNoLabel.json';
  }

  /// 波次二次分拣 完成无标模式下，当前框号的所有SKU拣货
  static String get getFinishNoLabelSortingUrl {
    return '/api/v1/order/wave/finishNoLabelSorting.json';
  }

  /// 波次二次分拣 -取消认领二次分拣波次任务
  static String get getCancelClaimSortPickWaveUrl {
    return '/api/v1/app/order/wave/unclaimSortPickWave.json';
  }

  /// 获取波次拣货方式
  static String get getPickTypeUrl {
    return '/api/v1/app/order/wave/getPickType.json';
  }

  /// APP端查询当前用户是否存在进行中的二次分拣波次
  static String get getWaveTwicePickingUrl {
    return '/api/v1/app/order/wave/existSortPickWave.json';
  }

  /// 扫描分拣商品
  static String get getWaveScanSortPickSkuUrl {
    return '/api/v1/app/order/wave/v2/waveScanSortPickSku.json';
  }

  /// 查看分拣详情（右上角按钮）
  static String get getViewSortingDetailUrl {
    return '/api/v1/app/order/wave/viewSortingDetail.json';
  }

  /// APP端校验能否进行二次分拣
  static String get getValidScanSortPickWaveUrl {
    return '/api/v1/app/order/wave/validScanSortPickWave.json';
  }

  /// APP二次分拣 - 清空重置分拣波次
  static String get getClearSortPickWaveDataUrl {
    return '/api/v1/app/order/wave/clearSortPickWaveData.json';
  }

  /// APP 二次分拣 - 结束分拣波次
  static String get getFinishSortPickWaveUrl {
    return '/api/v1/app/order/wave/finishSortPickWave.json';
  }

  /// APP - 三方仓订单-撤回
  static String get getThirdWareOrderRevokeUrl {
    return '/api/v1/app/order/thirdWareOrderRevoke.json';
  }

  /// APP - 三方仓订单-批量撤回
  static String get getThirdWareOrderBatchRevokeUrl {
    return '/api/v1/app/order/thirdWareOrderBatchRevoke.json';
  }

  /// APP - 三方仓订单-推送
  static String get getThirdWareOrderPushUrl {
    return '/api/v1/app/order/thirdWareOrderPush.json';
  }

  /// APP - 三方仓订单-批量-推送
  static String get getThirdWareOrderBatchPushUrl {
    return '/api/v1/app/order/thirdWareOrderBatchPush.json';
  }

  /// APP - 三方仓订单-刷新
  static String get getThirdWareOrderStateRefreshUrl {
    return '/api/v1/app/order/thirdWareOrderStateRefresh.json';
  }

  /// 三方仓订单-单个移除
  static String get getThirdWareOrderRemoveUrl {
    return '/api/v1/app/order/thirdWareOrderRemove.json';
  }

  /// APP - 三方仓订单-批量-移除
  static String get getThirdWareOrderBatchRemoveUrl {
    return '/api/v1/app/order/thirdWareOrderBatchRemove.json';
  }

  /// APP二次分拣 - 结束分拣波次
  static String get getWavePickCountUrl {
    return '/api/v1/app/order/wave/count.json';
  }

  /// 订单列表，检测Shopee提示需要去PC端处理
  static String get getCheckShopeestatusTipUrl {
    return '/api/v1/order/checkShopeestatusTip.json';
  }

  /// POS订单 - 商品列表数据
  static String get getNoGroupSkuPageListUrl {
    return '/api/v1/app/pos/noGroupSkuPageList.json';
  }

  /// POS订单 - 添加散客
  static String get getFitCustomerUrl {
    return '/api/v1/app/customer/getFitCustomer.json';
  }

  /// POS订单 - 搜索SKU
  static String get getOfflineScanSkuUrl {
    return '/api/v1/app/pos/scanSku.json';
  }

  /// POS订单 - 搜索联想SKU
  static String get getSearchPosWarehouseSkuUrl {
    return '/api/v1/inventory/order/searchPosWarehouseSku.json';
  }

  /// 获取 pos售后订单列表查询
  static String get getPosSaleAfterOrderListUrl {
    return '/api/v1/app/pos/saleAfter/listSaleAfterOrder.json';
  }

  /// 获取 pos售后订单详情
  static String get getPosSaleAfterOrderDetailUrl {
    return '/api/v1/app/pos/saleAfter/saleAfterDetail.json';
  }

  /// 获取订单支持操作的售后按钮列表
  static String get getPosEnableButtonListUrl {
    return '/api/v1/app/pos/saleAfter/listAppPosEnableButtonList.json';
  }

  /// 售后埋点
  static String get getAddAppSaleAfterBuriedPointUrl {
    return '/api/v1/app/pos/saleAfter/addAppSaleAfterBuriedPoint.json';
  }

  /// 查询pos退货订单详细
  static String get getOrigOrderDetailPosUrl {
    return '/api/v1/app/pos/saleAfter/getOrigOrderDetail.json';
  }

  /// 查询pos退货订单详细
  static String get getCanReturnAmountUrl {
    return '/api/v1/app/pos/saleAfter/culCanReturnAmount.json';
  }

  /// 提交售后信息
  static String get getSubmitSaleAfterUrl {
    return '/api/v1/app/pos/saleAfter/submitSaleAfter.json';
  }

  /// 提交售后信息
  static String get getSaleAfterCreateResultUrl {
    return '/api/v1/app/pos/saleAfter/getSaleAfterCreateResult.json';
  }

  /// 创建促销活动接口
  static String get getEnablePromotionsUrl {
    return '/api/v1/app/pos/promotion/getEnablePromotions.json';
  }

  /// 查询促销活动是否可用接口
  static String get queryPromotionIsEnableUrl {
    return '/api/v1/app/pos/promotion/enable.json';
  }

  /// 查询单店铺信息
  static String get queryShopDetailUrl {
    return '/api/v1/order/offline/app/shopDetail.json';
  }

  /// 店铺超限+订单量超限拦截
  static String get queryQuotaDetectionUrl {
    return '/api/v1/app/quotaDetection.json';
  }

  /// 我的账户信息
  static String get myAccountUrl {
    return '/api/v1/app/myAccount.json';
  }

  /// 切换账号token,后端校验Token，并刷新获取最新Token
  static String get switchUserCheckLoginUrl {
    return '/api/v1/app/switchUserCheckLogin.json';
  }
}
