import 'package:flutter/material.dart';

import 'package:business/src/assets/colors.dart';
import 'package:business/src/models/dbss/bundle.dart';
import 'package:get/get.dart';

class BundleWidget extends StatelessWidget {
  final Bundle? bundle;

  final double? width;
  final double? height;
  final MainAxisAlignment alignment;

  const BundleWidget(
      {super.key,
      this.width,
      this.height,
      this.bundle,
      required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: alignment,
        children: [
          Container(
            height: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 2.5, color: CustomColors.alizarin.withOpacity(0.7)),
            ),
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child: Icon(
                      bundle?.getIcon(),
                      size: (width ?? 0) * 0.35,
                      color: Get.theme.primaryTextTheme.displaySmall?.color,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: (height ?? 0) * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          bundle?.getQuota() ?? "",
                          style: Get.theme.primaryTextTheme.displaySmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
