import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/models/dbss/balance.dart';

import 'package:business/src/models/il/Subscriber.dart';
import 'package:business/src/models/enums/bundle_type.dart';
import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';
import 'package:business/src/controllers/fleet_dialog_controller.dart';

class FleetDialog extends StatefulWidget {
  final DialogInterface? listener;

  const FleetDialog({
    super.key,
    this.listener,
  });

  @override
  State<FleetDialog> createState() => FleetDialogState();
}

class FleetDialogState extends State<FleetDialog> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      child: GetBuilder<FleetDialogController>(
        id: "loading",
        builder: (ctrl) {
          if (!ctrl.loading) {
            return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Get.theme.dialogTheme.backgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Wrap(children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _getBundleWidgets(context, ctrl.subscriber),
                    ),
                  ),
                ]));
          } else {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Get.theme.dialogTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Wrap(children: <Widget>[
                Container(
                  color: Colors.transparent,
                  width: Get.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            );
          }
        },
      ),
    );
  }

  List<Widget> _getBundleWidgets(BuildContext context, Subscriber? subscriber) {
    //Add first & last name
    List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.only(right: 30, top: 15, bottom: 5, left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "${subscriber?.firstName} ${subscriber?.lastName}",
                style: Get.theme.textTheme.titleMedium?.copyWith(fontSize: 15),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.end,
                subscriber?.msisdn ?? "",
                style: Get.theme.textTheme.titleMedium?.copyWith(fontSize: 15),
              ),
            )
          ],
        ),
      ),
      const Divider(),
    ];

    //Add packages
    widgets.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _addPackages(context, subscriber),
      ),
    ));

    //Add buttons
    widgets.add(DialogFooter(
      negative: "Ok",
      listener: widget.listener,
    ));

    return widgets;
  }

  List<Widget> _addPackages(BuildContext context, Subscriber? subscriber) {
    // Init array
    List<Widget> widgets = [];

    // Add packages
    var count = subscriber?.packages?.length ?? 0;
    for (var i = 0; i < count; i++) {
      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              textAlign: TextAlign.center,
              subscriber?.packages?[i].name?.getValue() ?? "",
              style: Get.theme.textTheme.titleMedium?.copyWith(fontSize: 15),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: (1 / .25),
            ),
            itemCount: subscriber?.packages?[i].balances?.length ?? 0,
            itemBuilder: (context, index) {
              var balance = subscriber?.packages?[i].balances?[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          balance?.type?.format() ?? " ",
                          style: Get.theme.textTheme.titleSmall
                              ?.copyWith(fontSize: 12),
                        ),
                        Text(
                          balance?.getQuota() ?? " ",
                          style: Get.theme.textTheme.titleSmall
                              ?.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              size: 20,
                              balance?.getIcon(),
                              color: Get
                                  .theme.primaryTextTheme.displaySmall?.color,
                            ),
                          ),
                          Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              value: balance?.getRatio(),
                              color: Get.theme.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ));
    }

    // If no packages, display a message
    if (count == 0) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'descNoConnected'.tr,
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.titleMedium?.copyWith(fontSize: 15),
          ),
        ),
      );
    }

    // Return list
    return widgets;
  }
}
