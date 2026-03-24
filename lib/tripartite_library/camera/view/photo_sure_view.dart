import 'package:flutter/material.dart';
import '../../../utils/utils/click_utils.dart';
import '../../../utils/marco/marco.dart';

/// FileName photo_sure_view
///
/// @Author 谌文
/// @Date 2023/12/6 16:52
///
/// @Description 图片确认View
class PhotoSureWidget extends StatelessWidget {
  const PhotoSureWidget({
    Key? key,
    this.backTap,
    this.sureTap,
  }) : super(key: key);

  /// 点击返回
  final VoidCallback? backTap;

  /// 点击确定
  final VoidCallback? sureTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 45 + bottomPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: ClickUtils.debounce(backTap),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: const Color(0x76000000)),
                padding: const EdgeInsets.all(9),
                child: Image.asset('assets/image/common/back@3x.png',
                    width: 32, height: 32),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: ClickUtils.debounce(sureTap),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: const Color(0x76000000)),
                padding: const EdgeInsets.all(9),
                child: Image.asset('assets/image/common/done@3x.png',
                    width: 32, height: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
