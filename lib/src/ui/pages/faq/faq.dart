import 'package:business/src/controllers/faq_controller.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/faq/widgets/faq_list.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  IconData _getIcon(String item) {
    switch (item) {
      case 'line':
        return Icons.phone;
      case 'service':
        return Icons.settings;
      case 'internet':
        return Icons.four_g_mobiledata;
      case 'contact':
        return Icons.numbers;
      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            Get.find<NavigationPageCtrl>().getTitle(NavDrawer.faqItem),
            style: Get.theme.primaryTextTheme.bodyMedium
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //       bottom: Radius.elliptical(Get.width, 90.0)),
          // ),
        ),
      ),
      drawer: NavDrawer(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (val) =>
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.homeItem),
        child: GetBuilder<FaqController>(
          init: FaqController(),
          builder: (ctrl) => Scaffold(
            appBar: AppBar(
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: TabBar(
                tabs: ctrl.categries
                    .map((e) => Tab(
                          text: e.title!.tr,
                          icon: Icon(_getIcon(e.item!)),
                        ))
                    .toList(),
                controller: ctrl.tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.white;
                    if (states.contains(MaterialState.pressed))
                      return Colors.white;
                    return null;
                  },
                ),
              ),
            ),
            body: const FaqList(),
          ),
        ),
      ),
    );
  }
}
