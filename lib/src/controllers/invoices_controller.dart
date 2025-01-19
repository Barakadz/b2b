import 'dart:io';

import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/dbss/Invoice.dart';
import 'package:business/src/models/other/epayment.dart';
import 'package:business/src/models/response/apim_response.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/repositories/invoice_repository.dart';
import 'package:business/src/repositories/user_repository.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/ui/pages/invoices/widgets/invoice_dialog.dart';
import 'package:business/src/ui/widgets/dialogs/loading_dialog.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoicesCtrl extends BaseController {
  static const String termsUrl = "https://moncompte.djezzy.dz/%s/eflexy/terms/";
  static const double maxAmount = 999999;
  double totalAmount = 0;
  double totalToPay = 0.0;
  String expiryDate = '';
  double checkedAmount = 0.0;
  List<Invoice> invoices = [];
  Epayment? epaymentModel;
  List<Map<String, dynamic>> checkedInvoices = [];
  TextEditingController textController = TextEditingController();
  int cardMethod = 0;

  @override
  onInit() {
    fetchData();
    super.onInit();
  }

  initState() {
    updateStatus(Pair(Status.loading, Reason.idle));
    update();
  }

  void fetchData() async {
    initState();
    invoices = [];
    totalAmount = 0;
    try {
      ApimResponse data =
          await UserRepository.getInfo(null, [Api.billInfoVal]) as ApimResponse;
      if (data.includes != null) {
        List<Invoice> list = [];
        for (var include in data.includes!) {
          if (include.type == Api.billInfoVal) {
            Invoice p = include as Invoice;
            list.add(p);
          }
        }
        if (list.length > 1) {
          list.sort((a, b) {
            DateTime d1 = a.toDate as DateTime;
            DateTime d2 = b.toDate as DateTime;
            return d2.compareTo(d1);
          });
        }
        for (Invoice i in list) {
          checkedInvoices.add({"id": i.id, "checked": false});
          totalAmount += i.total!;
        }
        invoices = list;
        updateStatus(Pair(Status.success, Reason.idle));
        update();
      } else {
        generateError(Pair(Status.error, Reason.unknown));
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
    update();
  }

  pay() {
    if (totalToPay == 0) {
      SnackBarInfo.snackAlert('Warning',
          'Please to check invoices or type an amount', Alerts.warning);
    } else if (totalToPay > maxAmount) {
      SnackBarInfo.snackAlert(
          'Warning',
          'Votre paiement est supérieur à 10.000.000 Da veuillez le solder en plusieurs rechargements',
          Alerts.warning);
    } else {
      epaymentModel = Epayment(
          aParty: 'a',
          bParty: 'bparty',
          paymentType: Epayment.payment,
          amount: totalToPay,
          invoiceId: '');
      openInvoiceDialog();
    }
  }

  void openInvoiceDialog() async {
    await Get.bottomSheet(
      InvoiceDialog(
        epaymentModel: epaymentModel,
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 400),
      exitBottomSheetDuration: const Duration(milliseconds: 400),
    ).then((value) {
      if (value is int && value == 1) {
        if (epaymentModel != null) {
          epaymentModel!.cardType =
              cardMethod == 1 ? Epayment.poste : Epayment.cib;
          epaymentModel!.service =
              cardMethod == 1 ? Epayment.postOffice : Epayment.satim;
          payInvoice();
        } else {
          Get.back(result: 0);
        }
      } else {
        initConfig();
      }
    });
  }

  void payInvoice() async {
    try {
      Get.bottomSheet(
        const LoadingDialog(),
        isDismissible: false,
        enableDrag: false,
        enterBottomSheetDuration: const Duration(milliseconds: 400),
        exitBottomSheetDuration: const Duration(milliseconds: 400),
      );
      String ePaymentUrl = '';
      Map<String, dynamic> response =
          await InvoiceRepository.payInvoice(epaymentModel: epaymentModel);
      closeBottomSheet();
      if (response[Epayment.epOrderId] != null) {
        if (response[Epayment.epFormUrl] != null) {
          ePaymentUrl = response[Epayment.epFormUrl];
          redirect(ePaymentUrl);
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

  closeBottomSheet() {
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }
  }

  globalError() {
    closeBottomSheet();
    SnackBarInfo.snackAlert(
        'Error', 'Echec d\'envoi, veuillez réessayer', Alerts.error);
  }

  redirect(String url) async {
    var theUrl = Uri.parse(url);
    await launchUrl(theUrl);
  }

  checkAction(bool checked, String id) {
    int index = checkedInvoices
        .indexWhere((element) => element.entries.first.value == id);
    if (checked) {
      for (int i = index; i < checkedInvoices.length; i++) {
        checkedInvoices[i]['checked'] = checked;
      }
    } else {
      bool showWarning = false;
      for (int i = 0; i <= index; i++) {
        if (checkedInvoices[i]['checked'] && i != index) {
          showWarning = true;
        }
        checkedInvoices[i]['checked'] = checked;
      }
      if (showWarning) {
        SnackBarInfo.snackAlert(
            'Warning', 'You have to pay invoices by order', Alerts.warning);
      }
    }
    totalToPay = calculateTotal();
    textController.text = totalToPay.toString();
    update();
  }

  double calculateTotal() {
    double amount = 0;
    for (int i = 0; i < checkedInvoices.length; i++) {
      if (checkedInvoices[i]['checked']) {
        amount +=
            invoices.elementAt(i).total! - invoices.elementAt(i).paidAmount!;
      }
    }
    return amount;
  }

  //Dialog ctrl
  bool condition = false;

  // 0:none, 1:poste, 2:cib
  setCardMethod(int type) {
    cardMethod = type;
    update(['invoiceDialog']);
  }

  updateCondition(bool value) {
    condition = value;
    update(['invoiceDialog']);
  }

  initConfig() {
    condition = false;
    cardMethod = 0;
    epaymentModel = null;
  }
  //***********

  List<Map<String, dynamic>> invoicesStatic = [
    {'id': '212255', 'total': 30.0, 'remain': 2.0, 'date': '15 April 2023'},
    {'id': '565655', 'total': 1250.0, 'remain': 250.0, 'date': '15 March 2023'},
    {
      'id': '154525',
      'total': 100.0,
      'remain': 50.0,
      'date': '15 February 2023'
    },
  ];

  List<Map<String, dynamic>> checkedInvoicesStatic = [
    {'id': '212255', 'checked': false},
    {'id': '565655', 'checked': false},
    {'id': '154525', 'checked': false},
  ];
}
