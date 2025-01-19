import 'dart:math';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/dbss/balance.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/models/enums/bundle_type.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/assets/colors.dart';
import 'package:business/src/controllers/navigation_controller.dart';

class HomePackageCard extends StatelessWidget {
  const HomePackageCard({super.key, this.package, this.order, this.shadow});
  final Package? package;
  final int? order;
  final bool? shadow;

  @override
  Widget build(BuildContext context) {
    double deltaHeight = order!.toDouble() * 3;
    return Container(
      margin: EdgeInsets.only(right: 20.0 - deltaHeight, left: 20),
      width: Get.width,
      height: 180 - deltaHeight,
      decoration: BoxDecoration(
        color: shadow!
            ? Get.theme.cardColor.withOpacity(0.85)
            : Get.theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
              blurRadius: 20,
              spreadRadius: 0.0,
              offset: Offset(3, 6),
              color: Colors.black26,
              blurStyle: BlurStyle.normal),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 166, 172, 221),
            Color.fromARGB(255, 245, 249, 253),
            Color.fromARGB(255, 218, 202, 245),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: GetBuilder<NavigationPageCtrl>(
                  init: NavigationPageCtrl(),
                  builder: (ctrl) {
                    return CircularPercentDisplay(
                        size: 140,
                        thickness: 5,
                        balance: package!.balances!.elementAt(0),
                        expiry: package!.expiryDate);
                  })),
          if (package!.balances!.length > 1)
            SizedBox(
                width: .5,
                height: 100 - deltaHeight,
                child: Container(
                  color: Colors.grey,
                )),
          if (package!.balances!.length > 1)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 8.0, left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'ableTo'.tr,
                        style: Get.theme.primaryTextTheme.displaySmall!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: min(3, package!.balances!.length - 1),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package!.balances!
                                      .elementAt(index + 1)
                                      .type!
                                      .format(),
                                  style: Get.theme.textTheme.headlineSmall,
                                ),
                                Text(
                                  package!.balances!
                                          .elementAt(index + 1)
                                          .unlimited!
                                      ? 'unlimited'.tr
                                      : '${TextHelper.doubleToCeil(package!.balances!.elementAt(index + 1).remaining!)} ${package!.balances!.elementAt(index + 1).unit!.format().toLowerCase()}',
                                  style: Get.theme.textTheme.headlineMedium,
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class CircularPercentDisplay extends StatelessWidget {
  final double? size;
  final double? thickness;
  final Balance? balance;
  final dynamic expiry;

  const CircularPercentDisplay(
      {super.key, this.size, this.thickness, this.balance, this.expiry});

  double _getPercent(Balance balance) {
    if (balance.unlimited!) {
      return 1;
    } else {
      return balance.remaining! / balance.total!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: size,
            width: size,
            padding: const EdgeInsets.all(10),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              value: 1,
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.alizarin.withOpacity(.3),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            height: size,
            width: size,
            padding: const EdgeInsets.all(10),
            child: CircularProgressIndicator(
              strokeWidth: thickness!,
              strokeCap: StrokeCap.round,
              value: _getPercent(balance!),
              valueColor: AlwaysStoppedAnimation<Color>(CustomColors.alizarin),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DefaultTextStyle(
                  style: Get.theme.textTheme.headlineSmall!,
                  child: Text(
                    balance!.type!.format(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DefaultTextStyle(
                  style: balance!.unlimited!
                      ? Get.theme.textTheme.headlineMedium!
                      : Get.theme.textTheme.headlineMedium!,
                  child: Text(
                    balance!.unlimited!
                        ? 'unlimited'.tr
                        : TextHelper.balanceToText(balance!),
                  ),
                ),
              ),
              DefaultTextStyle(
                style: Get.theme.primaryTextTheme.titleMedium
                        ?.copyWith(fontSize: 15) ??
                    const TextStyle(),
                child: Text(
                  balance!.unlimited!
                      ? ''
                      : TextHelper.DateToDisplay(
                          expiry!, TextHelper.shortDateFormat),
                  style: Get.theme.textTheme.bodyMedium!,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BundleDisplay extends StatelessWidget {
  const BundleDisplay({super.key, this.value, this.type});
  final String? value;
  final int? type;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationPageCtrl>(
        init: NavigationPageCtrl(),
        builder: (ctrl) {
          return Text(
            value!,
            style: type == 0
                ? Get.theme.primaryTextTheme.titleMedium?.copyWith(fontSize: 16)
                : Get.theme.primaryTextTheme.titleSmall,
          );
        });
  }
}
