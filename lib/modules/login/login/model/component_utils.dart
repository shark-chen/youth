import 'package:youth/utils/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../../widget/button/bottom_button/bottom_button.dart';

class ComponentUtils {
  static Future<bool> showPrivacyAgreementModal(VoidCallback? callback) async {
    bool agree = false;
    await showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: ThemeColor.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            width: MediaQuery.of(context).size.width,
            height: 238,
            constraints: const BoxConstraints(minHeight: 238),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ThemeColor.whiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                    onPressed: Get.back,
                    child: const Icon(Icons.close,
                        size: 24, color: ThemeColor.thickBlackColor),
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.topCenter,
                  child: RichText(
                      text: TextSpan(
                          text: LocaleKeys.PleaseReadAndAgree.tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: ThemeColor.defaultBlack,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                        TextSpan(
                          text: " ${LocaleKeys.PrivacyAgreement.tr}",
                          style: const TextStyle(
                              fontSize: 16, color: ThemeColor.blueColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                              callback?.call();
                            },
                        ),
                      ])),
                )),
                BottomButton(
                  buttonSpace: 13,
                  width: Get.width - 30,
                  leftTitle:  LocaleKeys.disagree.tr,
                  leftTap: Get.back,
                  rightTitle: LocaleKeys.agreement.tr,
                  rightTap: () {
                    agree = true;
                    Get.back();
                  },
                  showLine: false,
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        });
    return agree;
  }

  static Future showTextDialog({String? msg}) async {
    await showCupertinoDialog(
      context: Get.context!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(msg ?? LocaleKeys.Failed.tr),
          actions: [
            CupertinoDialogAction(
              textStyle: ThemeColor.black16Text,
              onPressed: () {
                Get.back();
              },
              isDestructiveAction: true,
              child: Text(LocaleKeys.Confirm.tr),
            )
          ],
        );
      },
    );
  }
}
