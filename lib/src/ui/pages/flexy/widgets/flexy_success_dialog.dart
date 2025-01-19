import 'package:business/src/controllers/flexy/flexy_controller.dart';
import 'package:business/src/models/il/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexySuccessDialog extends StatelessWidget {
  const FlexySuccessDialog({super.key, this.transaction});
  final Transaction? transaction;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlexyController>(
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
                      'Send confirmation',
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.lightGreen,
                      size: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'SUCCESS!',
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 20, color: Colors.lightGreen),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${'youSent'.tr} ${transaction!.amount} Mo ${'to'.tr} ${transaction!.receiver}',
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'flexyText'.tr,
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
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
                                'resend'.tr,
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
