import 'dart:ui';

import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/ui/widgets/circle_image.dart';
import 'package:business/src/controllers/navigation_controller.dart';

class HomeHeader2 extends StatelessWidget {
  HomeHeader2({super.key});
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(Get.width, 60.0)),
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    // width: Get.width - 30,
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 252, 252)
                            .withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                'myBalance'.tr,
                                style: Get.theme.primaryTextTheme.bodyMedium
                                    ?.copyWith(height: 2),
                              ),
                              Text(
                                '${TextHelper.doubleToCeil(_authController.subscriber.balance!)} ${Unit.get('da').format()}',
                                style: Get.theme.primaryTextTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => {
                              // print("ok"),
                            },
                            child: Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'recharge'.tr,
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
