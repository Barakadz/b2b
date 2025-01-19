import 'package:business/src/ui/pages/companies/companies_screen.dart';
import 'package:business/src/ui/pages/companies/companies_screen.dart';
import 'package:business/src/ui/pages/fleet/fleet_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/assets/themes.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/faq/faq.dart';
import 'package:business/src/ui/pages/home/home.dart';
import 'package:business/src/ui/pages/invoices/invoices.dart';
import '../offers/offers_page.dart';
import 'widgets/navigation_drawer.dart';

class NavigatorPage extends StatelessWidget {
  static String routeName = '/navigator';

  final String title;

  NavigatorPage({super.key, required this.title});

  final NavigationPageCtrl ctrl = Get.put(NavigationPageCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavDrawer(),
      // appBar: AppBar(
      //   backgroundColor: Get.theme.primaryColor,
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: SizedBox(
      //     height: 50,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         GetBuilder<NavigationPageCtrl>(
      //           builder: (ctrl) => Text(
      //             ctrl.pageTitle.value,
      //             style: CommonStyles.itemDesc(Colors.white, 1, 18),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: GetBuilder<NavigationPageCtrl>(builder: (ctrl) {
        switch (ctrl.selectedTab) {
          case NavDrawer.invoicesItem:
            return InvoicesPage();
          case NavDrawer.offersItem:
            return const OffersPage();
          case NavDrawer.companiesItem:
            return const CompaniesScreen();
          case NavDrawer.flotteItem:
            return const FleetPage();
          case NavDrawer.faqItem:
            return const FaqPage();
          default:
            return HomePage();
         }
      }),
    );
  }
}
