import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertHelper {
  static bool isDjezzy(String str, bool checkLength) {
    return false;
  }

  static Future<void> showLoadingIndicator(
      BuildContext context, String title) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Get.theme.cardColor,
          content: Container(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Get.theme.dividerColor,
                          ),
                        )),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.theme.dividerColor,
                      ),
                    ),
                  ])),
        );
      },
    );
  }

  static Future<void> showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: Get.theme.primaryTextTheme.titleMedium,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Get.theme.primaryTextTheme.titleSmall
                      ?.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('actionOk'.tr),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showMyDialog1(BuildContext context, String title,
      String message, String positiveTitle, String negativeTitle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: Get.theme.primaryTextTheme.titleMedium,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Get.theme.primaryTextTheme.titleSmall
                      ?.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(negativeTitle),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(positiveTitle),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
