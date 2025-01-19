import 'package:business/src/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(20.0),
      width: 80,
      decoration: BoxDecoration(
          color: Get.theme.dialogTheme.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          )),
      child: const Wrap(children: [
        Center(
          child: ProgressLoaderWidget(),
        ),
      ]),
    );
  }
}
