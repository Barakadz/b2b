import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Alerts { warning, error, info, success }

class SnackBarInfo {
  static snackAlert(String title, String message, Alerts type) {
    IconData icon() {
      switch (type) {
        case Alerts.warning:
          return Icons.warning;
        case Alerts.error:
          return Icons.error;
        case Alerts.info:
          return Icons.info_outline;
        case Alerts.success:
          return Icons.check_circle;
        default:
          return Icons.info_outline;
      }
    }

    Color backgroundColor() {
      switch (type) {
        case Alerts.warning:
          return Colors.amber;
        case Alerts.error:
          return Colors.red;
        case Alerts.info:
          return Colors.blue;
        case Alerts.success:
          return Colors.green;
        default:
          return Colors.amber;
      }
    }

    Color textColor() {
      switch (type) {
        case Alerts.warning:
          return Colors.black;
        case Alerts.error:
          return Colors.white;
        case Alerts.info:
          return Colors.black;
        case Alerts.success:
          return Colors.white;
        default:
          return Colors.black;
      }
    }

    Color iconColor() {
      switch (type) {
        case Alerts.warning:
          return Colors.black;
        case Alerts.error:
          return Colors.white;
        case Alerts.info:
          return Colors.black;
        case Alerts.success:
          return Colors.white;
        default:
          return Colors.black;
      }
    }

    return Get.snackbar(title, message,
        backgroundColor: backgroundColor(),
        colorText: textColor(),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: const EdgeInsets.all(10),
        borderRadius: 20,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          icon(),
          color: iconColor(),
        ));
  }

  static snackMessage(String message, Alerts type) {
    return Get.snackbar(
      '',
      '',
      backgroundColor: Colors.amber,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      borderRadius: 20,
      titleText: Container(),
      messageText: Center(
        child: Text(
          message,
        ),
      ),
    );
  }
}
