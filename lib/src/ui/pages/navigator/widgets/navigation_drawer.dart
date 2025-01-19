import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/controllers/navigator/navigator_controller.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/ui/widgets/circle_image.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/navigator/interfaces/drawer_interface.dart';

class NavDrawer extends StatelessWidget {
  static const int homeItem = 0;
  static const int invoicesItem = 1;
  static const int offersItem = 2;
  static const int companiesItem = 3;
  static const int flotteItem = 4;
  static const int languageItem = 5;
  static const int faqItem = 6;
  static const int disconnectItem = 7;

  final DrawerInterface? listener;

  NavDrawer({super.key, this.listener});

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<NavigationPageCtrl>(
        init: NavigationPageCtrl(),
        builder: (ctrl) => Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color.fromARGB(255, 218, 196, 255),
                    Color.fromARGB(255, 181, 219, 255),
                  ],
                ),
              ),
              padding: EdgeInsets.zero,
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: const CircleProfile(
                        size: 50,
                        image: null,
                        imaged: false,
                      ),
                    ),
                    Text(
                      _authController.subscriptionType.name!.getValue(),
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _authController.subscriber.msisdn ?? '',
                      style: Get.theme.primaryTextTheme.displayMedium?.copyWith(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerItem(
                    item: homeItem,
                    desc: 'menuItemHome'.tr,
                  ),
                  DrawerItem(
                    item: invoicesItem,
                    desc: 'menuItemInvoices'.tr,
                  ),
                  DrawerItem(
                    item: offersItem,
                    desc: 'menuItemOffers'.tr,
                  ),
                  DrawerItem(
                    item: companiesItem,
                    desc: 'menuItemCompanies'.tr,
                  ),
                  DrawerItem(
                    item: flotteItem,
                    desc: 'menuItemFlotte'.tr,
                  ),
                  DrawerItem(
                    item: languageItem,
                    desc: 'menuItemLanguage'.tr,
                  ),
                  DrawerItem(
                    item: faqItem,
                    desc: 'menuItemFaq'.tr,
                  ),
                  DrawerItem(
                    item: disconnectItem,
                    desc: 'menuItemDisconnect'.tr,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Change the color as needed
                  width: 1.0, // Adjust the border width
                ),
                borderRadius:
                    BorderRadius.circular(8.0), // Adjust the border radius
              ),
              child: GetBuilder<NavigatorController>(
                builder: (ctrl) {
                  return CupertinoSlidingSegmentedControl<ThemeMode>(
                    children: {
                      ThemeMode.light: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Light',
                          style: TextStyle(color: Get.theme.dividerColor),
                        ),
                      ),
                      ThemeMode.dark: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Dark',
                          style: TextStyle(color: Get.theme.dividerColor),
                        ),
                      ),
                      ThemeMode.system: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'System',
                          style: TextStyle(color: Get.theme.dividerColor),
                        ),
                      ),
                    },
                    groupValue: ctrl.themeMode(),
                    thumbColor: Get.theme.cardColor,
                    backgroundColor: Colors.transparent,
                    onValueChanged: (value) {
                      ctrl.setThemeMode(value as ThemeMode);
                      //Navigator.pop(context);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
