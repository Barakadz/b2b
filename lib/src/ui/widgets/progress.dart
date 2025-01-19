import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressLoaderWidget extends StatelessWidget {
  const ProgressLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation(Get.theme.indicatorColor),
    );
  }
}
