import 'dart:io';
import 'package:get/get.dart';

import '/src/helpers/text_helper.dart';
import '/src/controllers/base_controller.dart';
import '/src/exceptions/bad_request_exception.dart';
import '/src/controllers/globale/auth_controller.dart';

import '../../models/response/pair.dart';
import '../../repositories/user_repository.dart';

class OtpController extends BaseController {
  bool canSend = false;

  String pin = "";
  String phoneNumber = "";

  void manageKeyPress(int key) async {
    if (key == -1) {
      updateStatus(Pair(Status.starting, Reason.idle));
      try {
        await UserRepository.checkPin(
            msisdn: TextHelper.internationalFormat(phoneNumber),
            pin: TextHelper.getDigits(pin));

        //Update service status
        updateStatus(Pair(Status.idle, Reason.idle));

        Get.find<AuthController>().setStatus(AuthStatus.otpAccepted);
        await Get.find<AuthController>().loadSubscriber();

        //Update route status
        //Get.find<AuthController>().setStatus(AuthStatus.authenticated);
      } catch (exception) {
        if (exception is SocketException) {
          updateStatus(Pair(Status.error, Reason.network));
        } else if (exception is BadRequestException) {
          updateStatus(Pair(Status.error, Reason.notFound));
        } else {
          updateStatus(Pair(Status.error, Reason.unknown));
        }
      }
    } else if (key >= 0) {
      var next = pin + key.toString();
      updatePin(next, true);
    } else if (key == -2 && pin.isNotEmpty) {
      var next = pin.substring(0, pin.length - 1);
      updatePin(next, false);
    }
  }

  void updatePin(String next, bool check) {
    bool updated = false;
    if (!check || pin.length < 6) {
      updated = true;
      pin = next;
      update(["pin"]);
    }

    if (next.length == 6) {
      canSend = true;
      update(["canSend"]);
    } else if (updated) {
      canSend = false;
      update(["canSend"]);
    }
  }
}
