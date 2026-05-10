import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// FileName easy_refresh_header
///
/// @Author 谌文
/// @Date 2024/12/27 16:10
///
/// @Description easy_refresh 下拉刷新头部view
class EasyRefreshHeader {
  static ClassicHeader build({
    IndicatorPosition? position,
    Color? color,
    bool? clamping = true,
  }) {
    if (position != null) {
      return ClassicHeader(
        position: position,
        clamping: clamping ?? true,
        mainAxisAlignment: MainAxisAlignment.end,
        dragText: "",
        armedText: "",
        readyText: "",
        processingText: "",
        processedText: "",
        noMoreText: "",
        failedText: "",
        messageText: "",
        succeededIcon: Icon(Icons.done, color: (color ?? Color(0xFF919099))),
        iconTheme: IconThemeData(color: color ?? Color(0xFF919099)),
      );
    }
    return ClassicHeader(
      clamping: clamping ?? true,
      mainAxisAlignment: MainAxisAlignment.end,
      dragText: "",
      armedText: "",
      readyText: "",
      processingText: "",
      processedText: "",
      noMoreText: "",
      failedText: "",
      messageText: "",
      succeededIcon: Icon(Icons.done, color: (color ?? Color(0xFF919099))),
      iconTheme: IconThemeData(color: color ?? Color(0xFF919099)),
    );
  }
}
