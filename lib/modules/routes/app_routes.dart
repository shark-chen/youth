part of 'app_pages.dart';

/// 路由来源方式- 主要是机型的哈，不可加业务哈
enum RouteFrom {
  /// 手机
  iPhone,

  /// iPad
  iPad,
}

abstract class Routes {
  static const splash = '/';
  static const login = "/login";
  static const register = "/register";
  static const homePage = "/homePage";
  static const cameraWebView = "/cameraWebView";
  static const webView = "/webview";
  static const backCameraWebView = "/backCameraWebView";
  static const backWebView = "/backWebview";
  static const readMePage = "/readMePage";
  static const settingList = "/settingList";
  static const settings = "/Settings";
  static const scanInventory = "/ScanInventory";
  static const proofreadQuantity = "/ProofreadQuantity";
  static const cameraScanPage = "/cameraScanPage";
  static const enterWarehouse = "/enterWarehouse";
  static const enterCommodityList = "/enterCommodityList";
  static const scanEnterWarehouse = "/scanEnterWarehouse";
  static const commoditySelect = "/commoditySelect";
  static const manuallyExitStorage = "/manuallyExitStorage";
  static const manuallyEnterStorage = "/manuallyEnterStorage";
  static const shopAuth = "/shopAuthorize";
  static const lazadaAuth = '/LAZADAAUTH';
  static const msgSetting = "/MSG_SETTING";
  static const orderList = "/orderList";
  static const orderArrange = "/orderArrange";
  static const bulkPrint = "/bulkPrint";
  static const orderDetails = "/orderDetails";
  static const scanOrder = "/scanOrder";
  static const pdaScanOrder = "/pdaScanOrder";
  static const scanShipments = "/scanShipments";
  static const shipmentsRecord = "/shipmentsRecord";
  static const shipmentsSet = "/shipmentsSet";
  static const logisticsSelect = "/logisticsSelect";
  static const promptlyShipments = "/promptlyShipments";
  static const padPromptlyShipments = "/padPromptlyShipments";
  static const scanOrderPreview = "/scanOrderPreview";
  static const scanSetting = "/scanSetting";
  static const networkLookPage = "/networkLookPage";
  static const salesFiguresPage = "/salesFiguresPage";
  static const orderFiltratePage = "/orderFiltratePage";
  static const waveShipmentPage = "/wavePick";
  static const wavePickPage = "/wavePickPage";
  static const wavePickListPage = "/wavePickListPage";
  static const wavePickDetailPage = "/wavePickDetailPage";
  static const commodityInfoPage = "/commodityInfoPage";
  static const commodityInfoDetailPage = '/commodityInfoDetailPage';
  static const scanSendPhoto = '/scanSendPhoto';
  static const scanPhotoEdit = '/scanPhotoEdit';
  static const templateList = '/templateList';
  static const editTemplate = '/editTemplate';
  static const scanOrderSendPhoto = '/scanOrderSendPhoto';
  static const pdaHandExitWarehouse = "/pdaHandExitWarehouse";
  static const easyInventory = "/easyInventory";
  static const libertyInventory = "/libertyInventory";
  static const libertyInventoryAffirm = "/libertyInventoryAffirm";
  static const putShelvesPage = "/putShelvesPage";
  static const pullShelvesPage = "/pullShelvesPage";
  static const shelfSetPage = "/shelfSetPage";
  static const examineGoodsPage = "/scanExamineGoodsPage";
  static const examineGoodsRecordPage = "/examineGoodsRecordPage";
  static const phoneVerifyPage = "/phoneVerifyPage";
  static const posOrderPage = "/posOrderPage";
  static const clientListPage = "/clientListPage";
  static const landscapeClientListPage = "/landscapeClientListPage";
  static const clientSavePage = "/clientSavePage";
  static const landscapeClientSavePage = "/landscapeClientSavePage";
  static const scanReceiptPage = "/scanReceiptPage";
  static const scanReceiptDetailPage = "/scanReceiptDetailPage";
  static const shopReportsPage = "/shopReportsPage";
  static const orderReportsPage = "/orderReportsPage";
  static const sellReportsPage = "/sellReportsPage";
  static const shopTableReportsPage = "/shopTableReportsPage";
  static const orderTableReportsPage = "/orderTableReportsPage";
  static const salesTableReportsPage = "/salesTableReportsPage";
  static const serviceAlterPage = "/serviceAlterPage";
  static const orderPushTestPage = "/orderPushTestPage";
  static const commodityDetailPage = '/commodityDetailPage';
  static const requestTestPage = "/requestTestPage";
  static const selectImagePage = "/selectImagePage";
  static const blueSetPage = "/blueSetPage";
  static const enterWarrantPage = "/enterWarrantPage";
  static const exitWarrantPage = "/exitWarrantPage";
  static const moveGoodsPage = "/moveGoodsPage";
  static const repleteGoodsPage = "/repleteGoodsPage";
  static const moveGoodsPickSkuPage = "/moveGoodsPickSkuPage";
  static const moveGoodsPickShelfPage = "/moveGoodsPickShelfPage";
  static const moveGoodsPickProgressPage = "/moveGoodsPickProgressPage";
  static const moveGoodsShelvesShelfPage = "/moveGoodsShelvesShelfPage";
  static const moveGoodsShelvesSkuPage = "/moveGoodsShelvesSkuPage";
  static const contactWayPage = "/contactWayPage";
  static const createWavePage = "/createWavePage";
  static const shelfAdjustPage = "/shelfAdjustPage";
  static const advertDataPage = "/advertDataPage";
  static const shopeeAdvertActivityTablePage = "/shopeeAdvertActivityTablePage";
  static const shopeeAdvertShopTablePage = "/shopeeAdvertShopTablePage";
  static const sendPhotoRecordPage = "/sendPhotoRecordPage";
  static const webPlugPrintPage = "/webPlugPrintPage";
  static const posBillPage = "/posBillPage";
  static const posMoreSetPage = "/posMoreSetPage";
  static const posTransactionPage = "/posTransactionPage";
  static const posAfterSalesPage = '/posAfterSalesPage';
  static const landscapePosAfterSalesPage = '/landscapePosAfterSalesPage';
  static const posAfterSalesReplaceGoodsPage = '/posAfterSalesReplaceGoodsPage';
  static const posLandscapeAfterSalesReplaceGoodsPage =
      '/posLandscapeAfterSalesReplaceGoodsPage';
  static const posAfterSalesDetailsPage = '/posAfterSalesDetailsPage';
  static const ReturnAndRefundPage = '/returnAndRefundPage';
  static const payMethodPage = '/payMethodPage';
  static const landscapePayMethodPage = '/landscapePayMethodPage';
  static const PosAfterSalesResultPage = '/posAfterSalesResultPage';
  static const landscapePosAfterSalesResultPage =
      '/landscapePosAfterSalesResultPage';
  static const posBillRecordPage = '/PosBillRecordPage';
  static const posBillGoodsCategoryPage = '/posBillGoodsCategoryPage';
  static const posOrderSetPage = '/posOrderSetPage';
  static const hardwareManagementPage = '/hardwareManagementPage';
  static const landscapeHardwareManagementPage =
      '/landscapeHardwareManagementPage';
  static const bluetoothConnectPage = '/bluetoothConnectPage';
  static const landscapeBluetoothConnectPage = '/landscapeBluetoothConnectPage';
  static const waveTwicePickHomePage = "/waveTwicePickHomePage";
  static const waveTwicePickPage = "/waveTwicePickPage";
  static const waveTwicePickDetailPage = "/waveTwicePickDetailPage";
  static const waveTwicePickOverAffirmPage = "/waveTwicePickOverAffirmPage";
  static const waveTwicePickSkuDetailPage = "/WaveTwicePickSkuDetailPage";
  static const posLandscapeOrderPage = "/posLandscapeOrderPage";
  static const posAddIndividualClientPage = '/posAddIndividualClientPage';
  static const landScapePosAddIndividualClientPage =
      '/landScapePosAddIndividualClientPage';
  static const payChannelsPage = '/payChannelsPage';
  static const landscapePayChannelsPage = '/landscapePayChannelsPage';
  static const landscapePosCashEditPage = '/landscapePosCashEditPage';
  static const languagePage = '/languagePage';
  static const accountPage = '/accountPage';
  static const pingPage = '/pingPage';
  static const accountSwitchPage = '/accountSwitchPage';
  static const wavePickSetPage = '/wavePickSetPage';
  static const accountSelectPage = '/accountSelectPage';

  static const sexInfoPage = '/sexInfoPage';
  static const brithInfoPage = '/brithInfoPage';
  static const regionInfoPage = '/regionInfoPage';
  static const doingListPage = '/doingListPage';
  static const inviteRecordPage = '/inviteRecordPage';
  static const userInfoPage = '/userInfoPage';
  static const beatRecordPage = '/beatRecordPage';
  static const chatPage = '/chatPage';
  static const sexSelectPage = '/sexSelectPage';
  static const birthdaySelectPage = '/birthdaySelectPage';
  static const citySelectPage = '/citySelectPage';
  static const citySetPage = '/citySetPage';



}
