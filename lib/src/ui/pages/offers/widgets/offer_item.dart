import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/ui/pages/offers/widgets/bundle_widget.dart';
import 'package:get/get.dart';

class OfferItem extends StatelessWidget {
  final Package? package;

  const OfferItem(this.package, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 10),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15.0,
                      color: Colors.black26,
                      blurStyle: BlurStyle.normal),
                ],
              ),
              child: Card(
                color: Get.theme.cardColor,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: getBundleWidgets(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Icon(
                                      size: 18,
                                      FontAwesomeIcons.stopwatch,
                                      color: Get.theme.primaryTextTheme
                                          .displaySmall?.color),
                                ),
                              ),
                              TextSpan(
                                text: package?.formatValidity(),
                                style: Get.theme.primaryTextTheme.displayMedium,
                              )
                            ]),
                          ),
                          const Spacer(),
                          RichText(
                              text: TextSpan(children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Icon(
                                    size: 18,
                                    FontAwesomeIcons.moneyBill1Wave,
                                    color: Get.theme.primaryTextTheme
                                        .displaySmall?.color),
                              ),
                            ),
                            TextSpan(
                              text: package?.formatPrice(),
                              style: Get.theme.primaryTextTheme.displayMedium,
                            ),
                          ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            width: Get.width * 0.60,
            child: Container(
              height: 34.0,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Get.theme.primaryColor.withOpacity(0.8),
                    Get.theme.primaryColor.withOpacity(0.7),
                    Get.theme.primaryColor.withOpacity(0.5),
                  ],
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    package?.name?.getValue() ?? "",
                    style: Get.theme.primaryTextTheme.displayLarge,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getBundleWidgets() {
    List<Widget> widgets = [];
    var count = min(package?.bundles?.length ?? 0, 3);
    for (int i = 0; i < count; i++) {
      //Check if it's center widget
      bool isCenter = count == 1 || (i == 1 && count > 2);

      //Add new widget
      widgets.add(BundleWidget(
        bundle: package?.bundles?[i],
        height: Get.width * 0.25,
        width: Get.width * (isCenter ? 0.22 : 0.19),
        alignment: (isCenter ? MainAxisAlignment.start : MainAxisAlignment.end),
      ));
    }

    return widgets;
  }
}
