import 'package:youth/modules/user/user_center/user_center.dart';
import 'package:youth/tripartite_library/camera/view/scan_animation.dart';
import 'package:youth/utils/extension/ints/ints.dart';
import 'package:youth/utils/extension/lists/lists.dart';
import 'package:youth/utils/extension/strings/strings.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import '../model/barcode_model.dart';
import 'camera_vm.dart';

/// FileName: camera_scan_vm
///
/// @Author 谌文
/// @Date 2026/1/14 09:55
///
/// @Description 相机扫描 -vm
extension CameraScanVM on CameraVM {
  /// 处理扫描冷却逻辑
  bool handleScanCool(List<Barcode>? barcodes, ScanAnimation scanAnimation) {
    if (UserCenter().scanTimeInterval <= 0) return false;

    /// 获取
    var barcodeList = <String>[];
    for (Barcode? barcode in (barcodes ?? [])) {
      if (Strings.isNotEmpty(barcode?.rawValue)) {
        barcodeList.add(barcode?.rawValue ?? '');
      }
    }

    /// 停止冷却
    void stopScanCooling() {
      /// 扫了新的码，不冷却了
      if (scanCooling == true) {
        scanAnimation.animationController?.reset();
        cameraType?.refresh();
      }
      scanCooling = false;
    }

    /// 开始冷却
    void startScanCooling() {
      /// 扫了新的码，不冷却了
      if (scanCooling == false) {
        scanAnimation.animationController?.stop();
        cameraType?.refresh();
      }
      scanCooling = true;
    }

    /// 若扫描到相同条码：检查当前时间与上次时间的差值，小于设定间隔则忽略，大于等于间隔则生效
    /// 已经记录过上次扫描的码
    if (Lists.isNotEmpty(lastScanResultList)) {
      final barcode = lastScanResultList.first;
      final interval =
      (DateTime.now().millisecondsSinceEpoch - (barcode.timestamp ?? 0));

      /// 还在冷却时间类内，需要判断这次扫描的条码是否跟当前的一致，一致+当前扫码内容为空也 一直继续冷却，一是一致，立即开启输出扫描内容
      if (interval < UserCenter().scanTimeInterval * 1000) {
        /// 两次扫描相同，继续冷却 || 当前啥都没扫到也是继续冷却
        if (Lists.isNotEmpty(barcodeList) &&
            barcode.barcode == barcodeList.first) {
          /// 开始冷却
          startScanCooling();
        } else {
          /// 扫了新的码，- 停止冷却
          stopScanCooling();
        }
      } else {
        /// 已过冷却时间 - 停止冷却
        stopScanCooling();
      }
    }

    /// 继续最新的扫描内容
    if (Lists.isNotEmpty(barcodeList) && !scanCooling) {
      lastScanResultList = barcodeList
          .map((element) => BarcodeModel()
        ..barcode = element
        ..timestamp = DateTime.now().millisecondsSinceEpoch)
          .toList();
    }
    return scanCooling;
  }

  /// 获取倒数间隔时间
  int get scanTimeInterval {
    var result = (UserCenter().scanTimeInterval * 1000).toInt();
    if (Lists.isNotEmpty(lastScanResultList)) {
      final barcode = lastScanResultList.first;
      final interval =
          (DateTime.now().millisecondsSinceEpoch - (barcode.timestamp ?? 0));
      result = result - interval.floorTo(500);
    }
    return result;
  }
}
