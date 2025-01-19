import 'package:business/src/controllers/invoices_controller.dart';
import 'package:business/src/models/other/epayment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceDialog extends StatelessWidget {
  const InvoiceDialog({super.key, this.epaymentModel});
  final Epayment? epaymentModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesCtrl>(
      id: 'invoiceDialog',
      builder: (ctrl) => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Get.theme.dialogTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Wrap(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              reverseDuration: const Duration(milliseconds: 100),
              child: Container(
                color: Colors.transparent,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${'invoicesPayText'.tr} ${epaymentModel!.amount.toString()} ${'da'.tr}',
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: OutlinedButton(
                              onPressed: () => ctrl.setCardMethod(1),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                                /*(
                                    color:
                                        Colors.white /*Get.theme.dividerColor*/,
                                    width: 1),*/
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: SizedBox(
                                height: ctrl.cardMethod == 1 ? 70 : 40,
                                width: ctrl.cardMethod == 1 ? 70 : 40,
                                child: Image.asset(
                                    "assets/images/option_poste.png"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: OutlinedButton(
                              onPressed: () => ctrl.setCardMethod(2),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: SizedBox(
                                height: ctrl.cardMethod == 2 ? 70 : 40,
                                width: ctrl.cardMethod == 2 ? 70 : 40,
                                child:
                                    Image.asset("assets/images/option_cib.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: ctrl.condition,
                            onChanged: (value) {
                              ctrl.updateCondition(value!);
                            }),
                        Text(
                          '${'term1'.tr} ',
                          style:
                              Get.textTheme.bodyMedium!.copyWith(fontSize: 13),
                        ),
                        Flexible(
                          child: Text(
                            'termsAndConditions'.tr,
                            style: Get.textTheme.labelMedium!
                                .copyWith(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.back(result: 0);
                            },
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back(result: 1);
                              },
                              child: Text(
                                'confirm'.tr,
                                style: Get.theme.primaryTextTheme.titleMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
