import 'dart:ui';

import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/ui/widgets/circle_image.dart';
import 'package:business/src/controllers/navigation_controller.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key});

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: Get.width,
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(Get.width, 60.0)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleProfile(
                  image: null,
                  imaged: false,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _authController.subscriber.firstName ?? 'welcome'.tr,
                        style: Get.theme.primaryTextTheme.bodyMedium
                            ?.copyWith(height: 2),
                      ),
                      Text(
                        _authController.subscriber.msisdn ?? '',
                        style: Get.theme.primaryTextTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -40),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Get.theme.shadowColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<NavigationPageCtrl>(
                        init: NavigationPageCtrl(),
                        builder: (ctrl) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'myBalance'.tr,
                                style: Get.theme.primaryTextTheme.bodyMedium
                                    ?.copyWith(height: 2),
                              ),
                              Text(
                                '${TextHelper.doubleToCeil(_authController.subscriber.balance!)} ${Unit.get('da').format()}',
                                style: Get.theme.primaryTextTheme.bodySmall,
                              )
                            ],
                          );
                        }),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              child: Text('recharge'.tr), onPressed: () => {})
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
