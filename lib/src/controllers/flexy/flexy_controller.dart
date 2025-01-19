import 'dart:io';

import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/il/Transaction.dart';
import 'package:business/src/models/response/apim_response.dart';
import 'package:business/src/repositories/flexy_repository.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:business/src/ui/pages/flexy/widgets/flexy_dialog.dart';
import 'package:business/src/ui/pages/flexy/widgets/flexy_success_dialog.dart';
import 'package:business/src/ui/widgets/dialogs/loading_dialog.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:get/get.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/repositories/user_repository.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/controllers/base_controller.dart';

class FlexyController extends BaseController {
  String? msisdn = "";
  List<Transaction> transactions = [];

  @override
  onInit() {
    fetchData();
    super.onInit();
  }

  initState() {
    updateStatus(Pair(Status.loading, Reason.idle));
    update(["FlexyList"]);
  }

  void fetchData() async {
    initState();
    msisdn = await Preferences.getMobileNumber();
    transactions = [];
    try {
      ApimResponse data =
          await UserRepository.getInfo(null, [Api.flexyHistoryVal])
              as ApimResponse;
      if (data.includes != null) {
        for (int i = 0; i < data.includes!.length; i++) {
          if (data.includes![i].type == Api.flexyHistoryVaL2) {
            Transaction t = data.includes![i] as Transaction;
            transactions.add(t);
          }
        }
        updateStatus(Pair(Status.success, Reason.idle));
        update(["FlexyList"]);
      }
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    }
  }

  generateError(Pair error) {
    updateStatus(error);
    update(["FlexyList"]);
  }

  globalError() {
    closeBottomSheet();
    SnackBarInfo.snackAlert(
        'Error', 'Echec d\'envoi, veuillez réessayer', Alerts.error);
  }

  active(Transaction t) async {
    try {
      Get.bottomSheet(
        const LoadingDialog(),
        isDismissible: false,
        enableDrag: false,
        enterBottomSheetDuration: const Duration(milliseconds: 400),
        exitBottomSheetDuration: const Duration(milliseconds: 400),
      );
      Map<String, dynamic> args = {
        "code": t.code,
        "id": "DataShared",
        "b-number": t.receiver,
        "amount": t.amount
      };
      updateActionStatus(Pair(Status.starting, Reason.idle));
      Map<String, dynamic> response =
          await FlexyRepository.active(packageCode: t.code, args: args);
      closeBottomSheet();
      if (response.containsKey('status')) {
        if (response['status'] == 200) {
          fetchData();
          updateActionStatus(Pair(Status.stopped, Reason.idle));
          openSuccess(t);
        } else {
          globalError();
        }
      }
    } on DataFormatException catch (_) {
      globalError();
    } on FetchDataException catch (_) {
      globalError();
    } on BadRequestException catch (_) {
      globalError();
    } on SocketException catch (_) {
      globalError();
    } catch (e) {
      globalError();
    }
  }

  void openDialog() async {
    if (Get.find<AuthController>().isFlexyIligible()) {
      var res1 = await Get.bottomSheet(
        const FlexyDialog(),
        enterBottomSheetDuration: const Duration(milliseconds: 400),
        exitBottomSheetDuration: const Duration(milliseconds: 400),
      );
      if (res1 is Transaction) {
        active(res1);
      }
    } else {
      SnackBarInfo.snackAlert('warning'.tr,
          'You are not iligible for this service.', Alerts.warning);
    }
  }

  void openSuccess(Transaction t) async {
    var res = await Get.bottomSheet(
      FlexySuccessDialog(transaction: t),
      enterBottomSheetDuration: const Duration(milliseconds: 400),
      exitBottomSheetDuration: const Duration(milliseconds: 400),
    );
    if (res == 1) {
      openDialog();
    }
  }

  closeBottomSheet() {
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }
  }

  var historyStatic = [
    {
      "id": "130343",
      "type": "Flexy-history",
      "attributes": {
        "usage-amout": "500",
        "service-id": "DataShared",
        "price": 30.00,
        "name": {
          "text": {
            "ar": "500 Mo FLEXY NET",
            "fr": "500 Mo FLEXY NET",
            "en": "500 Mo FLEXY NET"
          }
        },
        "sent-to": "213784611511",
        "transaction-time": "2023-11-30T11:54:38.000Z",
        "usage-type": "data",
        "usage-unit": "mb",
        "received-from": "213784619532",
        "status": "done"
      },
      "links": {"self": "/djezzy-api/api/v1/Flexy-history/130343"}
    },
    {
      "id": "130344",
      "type": "Flexy-history",
      "attributes": {
        "usage-amout": "500",
        "service-id": "DataShared",
        "price": 30.00,
        "name": {
          "text": {
            "ar": "500 Mo FLEXY NET",
            "fr": "500 Mo FLEXY NET",
            "en": "500 Mo FLEXY NET"
          }
        },
        "sent-to": "213784611532",
        "transaction-time": "2023-11-30T11:55:13.000Z",
        "usage-type": "data",
        "usage-unit": "mb",
        "received-from": "213784619532",
        "status": "failed"
      },
      "links": {"self": "/djezzy-api/api/v1/Flexy-history/130344"}
    },
    {
      "id": "130345",
      "type": "Flexy-history",
      "attributes": {
        "usage-amout": "1",
        "service-id": "DataShared",
        "price": 50.00,
        "name": {
          "text": {
            "ar": "1 Go FLEXY NET",
            "fr": "1 Go FLEXY NET",
            "en": "1 Go FLEXY NET"
          }
        },
        "sent-to": "213784612017",
        "transaction-time": "2023-11-30T11:55:42.000Z",
        "usage-type": "data",
        "usage-unit": "gb",
        "received-from": "213784619532",
        "status": "done"
      },
      "links": {"self": "/djezzy-api/api/v1/Flexy-history/130345"}
    }
  ];
}
