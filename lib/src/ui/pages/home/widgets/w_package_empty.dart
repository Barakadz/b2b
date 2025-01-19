import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageEmpty extends StatelessWidget {
  const PackageEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0, left: 20),
      width: Get.width,
      height: 180,
      decoration: const BoxDecoration(
        //color: Get.theme.cardColor,
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color.fromARGB(255, 218, 196, 255),
            Color.fromARGB(255, 181, 219, 255),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              spreadRadius: 0.0,
              offset: Offset(3, 6),
              color: Colors.black26,
              blurStyle: BlurStyle.normal),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'noPackages'.tr,
                  style: Get.theme.primaryTextTheme.titleMedium
                      ?.copyWith(fontSize: 16),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
