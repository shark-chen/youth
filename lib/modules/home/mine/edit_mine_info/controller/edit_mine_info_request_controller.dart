import 'package:dio/dio.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/network/net/net.dart';
import 'package:youth/network/net/net_result.dart';
import '../edit_mine_info_controller.dart';

/// FileName: edit_mine_info_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 16:20
///
/// @Description
extension EditMineInfoReuestController on EditMineInfoController {
  /// 上传图片 · POST /api/user/photo（multipart 字段 `file`）
  Future<NetResult<dynamic>> requestUploadPhoto({
    required String filePath,
    String? filename,
  }) async {
    final response = await Net.value<User>().requestUploadPhoto<dynamic>(
      filePath: filePath,
      filename: filename,
    );
    return response;
  }
}
