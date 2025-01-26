import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:business/src/ui/pages/news/news.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/ui/pages/flexy/flexy.dart';
import 'package:business/src/controllers/navigation_controller.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  _toQuickAction(Map<String, dynamic> action) {
    if (action["title"] == "flexy") {
      Get.to(() => const FlexyPage());
    } else if (action["title"] == "menuItemFlotte") {
      Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.flotteItem);
    } else if (action["title"] == "news") {
      Get.to(() => const NewsPage());
    }
  }

  String _getIcon(Map<String, dynamic> item) {
    switch (item['title']) {
      case 'menuItemFlotte':
        return 'assets/images/online_community.png';
      case 'flexy':
        return 'assets/images/data_warehouse.png';
      case 'shop':
        return 'assets/images/market_research.png';
      case 'news':
        return 'assets/images/call_to_action.png';
      default:
        return 'assets/images/call_to_action.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'quickActions'.tr,
              style: Get.theme.textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
          ),
          GetBuilder<NavigationPageCtrl>(
              init: NavigationPageCtrl(),
              builder: (ctrl) {
                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.horizentalList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () =>
                              _toQuickAction(ctrl.horizentalList[index]),
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                      _getIcon(ctrl.horizentalList[index])),
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 40,
                                ),
                                Text(
                                  ctrl.horizentalList[index]['title']
                                      .toString()
                                      .tr,
                                  style: Get.theme.textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
