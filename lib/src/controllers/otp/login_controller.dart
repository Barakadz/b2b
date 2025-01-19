import 'dart:io';
import 'package:business/src/controllers/otp/otp_controller.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:get/get.dart';
import '/src/helpers/text_helper.dart';
import '/src/controllers/base_controller.dart';
import '/src/exceptions/bad_request_exception.dart';
import '/src/controllers/globale/auth_controller.dart';
import '../../models/response/pair.dart';
import '../../repositories/user_repository.dart';

class LoginController extends BaseController {
  bool canSend = false;
  String phoneNumber = "";
  bool condition1 = false;
  bool condition2 = false;

  void manageKeyPress(int key) async {
    if (key == -1) {
      if (condition1) {
        updateStatus(Pair(Status.starting, Reason.idle));
        try {
          var response = await UserRepository.requestPin(
              msisdn: TextHelper.internationalFormat(phoneNumber));
          if (response.status == 200) {
            updateStatus(Pair(Status.idle, Reason.idle));

            //Pass phone number to OtpPresenter
            Get.find<OtpController>().phoneNumber = phoneNumber;

            //Redirect to OtpPage
            Get.find<AuthController>().setStatus(AuthStatus.unverified);
          } else {
            updateStatus(Pair(Status.error, Reason.unknown));
          }
        } catch (exception) {
          if (exception is SocketException) {
            updateStatus(Pair(Status.error, Reason.network));
          } else if (exception is BadRequestException) {
            updateStatus(Pair(Status.error, Reason.notFound));
          } else {
            updateStatus(Pair(Status.error, Reason.unknown));
          }
        }
      } else {
        SnackBarInfo.snackAlert('Warning', 'acceptTerms'.tr, Alerts.warning);
      }
    } else if (key >= 0) {
      var next = phoneNumber + key.toString();
      updateNumber(next, true);
    } else if (key == -2 && phoneNumber.isNotEmpty) {
      var next = phoneNumber.substring(0, phoneNumber.length - 1);
      updateNumber(next, false);
    }
  }

  void updateNumber(String next, bool check) {
    bool updated = false;
    if (!check || !TextHelper.isDjezzy(phoneNumber, true)) {
      updated = true;
      phoneNumber = next;
      update(["phoneNumber"]);
    }

    if (TextHelper.isDjezzy(next, true)) {
      canSend = true;
      update(["canSend"]);
    } else if (updated) {
      canSend = false;
      update(["canSend"]);
    }
  }

  updateCondition(bool value, int pos) {
    if (pos == 1) {
      condition1 = value;
      update(['condition1']);
    } else if (pos == 2) {
      condition2 = value;
      update(['condition2']);
    }
  }
}
