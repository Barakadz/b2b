import 'package:flutter/material.dart';

import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';

import 'package:business/src/models/dbss/package.dart';
import 'package:get/get.dart';

class OfferDialog extends StatefulWidget {
  final Package? package;
  final DialogInterface? listener;

  const OfferDialog({
    super.key,
    this.package,
    this.listener,
  });

  @override
  State<OfferDialog> createState() => OfferDialogState();
}

class OfferDialogState extends State<OfferDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Get.theme.dialogTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: Wrap(children: <Widget>[
        Container(
          color: Colors.transparent,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getBundleWidgets(context),
          ),
        ),
      ]),
    );
  }

  List<Widget> _getBundleWidgets(BuildContext context) {
    //Add title
    List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.package?.name?.getValue() ?? "",
          style: Get.theme.textTheme.titleLarge,
        ),
      )
    ];

    //Add bundles
    var count = widget.package?.bundles?.length ?? 0;
    for (int i = 0; i < count; i++) {
      var bundle = widget.package?.bundles?[i];
      if (bundle != null) {
        //Add quota
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Text(
            (bundle.unlimited == false
                    ? bundle.getQuota()
                    : bundle.description?.getValue()) ??
                "",
            style: i == 0
                ? Get.theme.textTheme.headlineMedium
                : Get.theme.textTheme.headlineSmall,
          ),
        ));

        if (bundle.unlimited != true) {
          widgets.add(Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "${bundle.description?.getValue()}",
              style: i == 0
                  ? Get.theme.textTheme.labelMedium
                  : Get.theme.textTheme.labelSmall,
            ),
          ));
        }
      }
    }

    //Add Price/validity
    widgets.add(Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        "Pour ${widget.package?.formatPrice()} / ${widget.package?.formatValidity()}",
        style: Get.theme.textTheme.titleMedium,
      ),
    ));

    //Add buttons
    widgets.add(DialogFooter(
      parent: widget.key,
      listener: widget.listener,
      positive: widget.package?.illegible == true ? 'actionActivate'.tr:null,
    ));

    return widgets;
  }
}
