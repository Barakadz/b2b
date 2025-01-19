import 'package:business/src/controllers/companies_controller.dart';
import 'package:business/src/controllers/faq_controller.dart';
import 'package:business/src/controllers/flexy/flexy_controller.dart';
import 'package:business/src/controllers/invoices_controller.dart';
import 'package:business/src/controllers/navigator/offers_controller.dart';
import 'package:business/src/models/enums/click_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SorryWidget extends StatelessWidget {
  //final ClickInterface? callback;
  final ClickAction? type;
  final String? text;
  final String? icon;
  const SorryWidget({super.key, this.text, this.type, this.icon});

  callback(ClickAction type) {
    switch (type) {
      case ClickAction.reloadFaq:
        Get.find<FaqController>().loadFaqs(true);
        break;
      case ClickAction.reloadTransactions:
        Get.find<FlexyController>().fetchData();
        break;
      case ClickAction.reloadInvoices:
        Get.find<InvoicesCtrl>().fetchData();
        break;
      case ClickAction.reloadOffers:
        Get.find<OffersController>().reload(true);
        break;
      case ClickAction.reloadCompanies:
        // Get.find<CompaniesController>().loadCompanies(true);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Get.width,
          alignment: Alignment.center,
          child: SizedBox(
            width: 60,
            height: 60,
            child: Icon(
                icon == 'error' ? Icons.cloud_off_outlined : Icons.data_array,
                size: 60),
          ),
        ),
        Container(
          width: Get.width,
          alignment: Alignment.center,
          child: Text(text!),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: Get.width,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => callback(type!),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(0, 0),
                      blurRadius: 0,
                      spreadRadius: 0)
                ],
              ),
              child: const Icon(
                Icons.refresh,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
