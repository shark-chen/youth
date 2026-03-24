import 'package:flutter/services.dart';
import '../../../../base/base_controller.dart';
import '../model/network_model.dart';

/// FileName network_cell
///
/// @Author 谌文
/// @Date 2023/10/8 19:53
///
/// @Description 网络数据cell
class NetworkCell extends StatelessWidget {
  const NetworkCell({
    Key? key,
    this.model,
    this.onTap,
    this.longTap,
    this.sendTap,
  }) : super(key: key);

  /// 数据源
  final NetworkModel? model;

  /// 点击展开式收起
  final VoidCallback? onTap;

  /// 长按
  final VoidCallback? longTap;

  /// 发送数据
  final VoidCallback? sendTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "接口名称 ${model?.title}",
            style: TextStyle(
                color: (model?.succeed == true) ? Colors.green : Colors.red),
          ),
          const SizedBox(height: 3),
          Text(
            "时间 ${model?.time}",
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 3),
          Text(
            maxLines: 500,
            "请求参数 ${model?.requestParameters}",
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 3),
          Text(
            maxLines: model?.unfold == false ? 5 : 500,
            overflow: TextOverflow.ellipsis,
            "响应数据 ${model?.responseParameters},\nOther: ${model?.other}",
            style: const TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              Expanded(child: Container()),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  model?.unfold == false ? "展开" : "收起",
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  EasyLoading.showToast("复制成功");
                  Clipboard.setData(ClipboardData(
                      text:
                          "${model?.title}\n${model?.requestParameters}\n${model?.responseParameters}"));
                },
                child: const Text(
                  "复制",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: sendTap,
                child: Text(
                  '发到群聊',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
