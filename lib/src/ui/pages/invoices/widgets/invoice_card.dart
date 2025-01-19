import 'package:business/src/models/dbss/Invoice.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/controllers/invoices_controller.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice? invoice;
  const InvoiceCard({super.key, this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
              blurRadius: 10,
              spreadRadius: 0.0,
              offset: Offset(2, 2),
              color: Colors.black26,
              blurStyle: BlurStyle.normal),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<InvoicesCtrl>(
            builder: (ctrl) => Checkbox(
                value: ctrl.checkedInvoices.firstWhere((element) =>
                    element.entries.first.value == invoice!.id)['checked'],
                onChanged: (value) {
                  ctrl.checkAction(value!, invoice!.id!);
                }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                invoice!.toDate.toString().substring(0, 10),
                style: Get.theme.primaryTextTheme.displayMedium
                    ?.copyWith(fontSize: 14),
              ),
              Text(
                '${'totalAmount'.tr} ${invoice!.total.toString()}  Da',
                style: Get.theme.primaryTextTheme.displayMedium
                    ?.copyWith(fontSize: 12),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'restAmount'.tr,
                    style: Get.theme.primaryTextTheme.displayMedium
                        ?.copyWith(fontSize: 12),
                  ),
                  Text(
                    '${(invoice!.total! - invoice!.paidAmount!).toString()} Da',
                    style: Get.theme.primaryTextTheme.displayMedium
                        ?.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
