import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:pull_to_refresh/pull_to_refresh.dart';

/// FileName refresher_header
///
/// @Author 谌文
/// @Date 2023/5/15 15:05
///
/// @Description 刷新请求头
class RefresherHeader {
  static ClassicHeader build({Color? iconColor}) {
    return ClassicHeader(
      refreshStyle: RefreshStyle.Follow,
      idleText: "",
      refreshingText: "",
      releaseText: '',
      completeText: '',
      releaseIcon: Icon(Icons.refresh, color: (iconColor ?? Color(0xFF919099))),
      idleIcon:
          Icon(Icons.arrow_downward, color: (iconColor ?? Color(0xFF919099))),
      completeIcon: Icon(Icons.done, color: (iconColor ?? Color(0xFF919099))),
    );
  }
}
