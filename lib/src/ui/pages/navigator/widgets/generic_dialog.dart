import 'package:flutter/material.dart';

import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';

import 'package:get/get.dart';

class GenericDialog extends StatefulWidget {

  final String? title;
  final String? message;
  final String? positive;
  final String? neutral;
  final String? negative;

  final DialogInterface? listener;

  const GenericDialog({
    super.key,
    this.listener,
    this.title,
    this.message,
    this.positive,
    this.neutral,
    this.negative,
  });

  @override
  State<GenericDialog> createState() => GenericDialogState();
}

class GenericDialogState extends State<GenericDialog> {

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Get.theme.dialogTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0),
          ),
      ),
      child: Wrap(children: <Widget>[
        Container(
          color: Colors.transparent,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.title ?? "",
                    style: Get.theme.textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.message ?? "",
                  style: Get.theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                ),
              ),
              DialogFooter(
                parent: widget.key,
                listener: widget.listener,
                positive: widget.positive,
                negative: widget.negative,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
