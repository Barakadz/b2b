import 'package:business/src/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:business/src/models/il/Subscriber.dart';
import 'package:get/get.dart';

class FleetItem extends StatelessWidget {
  final Subscriber? subscriber;

  const FleetItem(this.subscriber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Card(
        elevation: 1,
        color: Get.theme.cardColor,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 4, top: 8, right: 10, left: 10),
                    child: Text(
                        "${subscriber?.firstName} ${subscriber?.lastName}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8, top: 4, right: 10, left: 10),
                    child: Text(TextHelper.nationalFormat(subscriber?.msisdn)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: PopupMenuButton(
                  color: Get.theme.cardColor,
                  elevation: 2,
                  position: PopupMenuPosition.over,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'connect',
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.sim_card_outlined),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('connect'.tr),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'swap',
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.swap_horiz),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('swap'.tr),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (String value) {
                    print('You Click on po up menu item');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getBundleWidgets(BuildContext context) {
    return [];
  }
}
