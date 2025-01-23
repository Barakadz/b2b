import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressLoaderWidget extends StatelessWidget {
  const ProgressLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Image.asset(
                "assets/images/logo_animated.gif",
                fit: BoxFit.contain,
                width: Get.width * 0.4,
                height: Get.width * 0.4,
              );
  }
}
