import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/ui/pages/home/widgets/w_banners_list.dart';
import 'package:business/src/ui/pages/home/widgets/w_header.dart';
import 'package:business/src/ui/pages/home/widgets/w_header2.dart';
import 'package:business/src/ui/pages/home/widgets/w_package_empty.dart';
import 'package:business/src/ui/pages/home/widgets/w_packages_list.dart';
import 'package:business/src/ui/pages/home/widgets/w_quick_actions.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:business/src/ui/pages/notification/notifications.dart';
import 'package:business/src/ui/widgets/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          // toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleProfile(
                image: null,
                imaged: false,
                size: 40,
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: InkWell(
                 child: const Icon(
                  Icons.notifications,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          children: [
             //HomeHeader(),
            HomeHeader2(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   GetBuilder<AuthController>(
                      builder: (ctrl) => ctrl.connectedProducts.isNotEmpty
                          ? const HomePackagesList()
                          : const PackageEmpty()),
                          
                    const SizedBox(
                      height: 10,
                    ),
                    const HomeQuickActions(),
                    HomeBanners(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
