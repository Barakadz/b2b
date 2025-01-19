import 'package:business/src/controllers/news/news_controller.dart';
import 'package:business/src/ui/pages/news/widgets/articles_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (ctrl) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            // toolbarHeight: 90,
            elevation: 0,
            backgroundColor: Get.theme.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "news".tr,
              style: Get.theme.primaryTextTheme.bodyMedium
                  ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(Get.width, 90.0)),
            ),
          ),
        ),
        // appBar: AppBar(
        //   backgroundColor: Get.theme.primaryColor,
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   title: SizedBox(
        //     height: 50,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           "news".tr,
        //           style: Get.theme.textTheme.displayMedium!.copyWith(
        //             fontSize: 17,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: Column(
          children: [
            // Container(
            //     height: 20,
            //     width: Get.width,
            //     decoration: BoxDecoration(
            //       color: Get.theme.primaryColor,
            //       borderRadius: BorderRadius.vertical(
            //           bottom: Radius.elliptical(Get.width, 60.0)),
            //     )),
            if (ctrl.categories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TabBar(
                  tabs: ctrl.categories
                      .map(
                        (e) => Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: ctrl.categories
                                          .elementAt(ctrl.selectedCategory)
                                          .category ==
                                      e.category
                                  ? Get.theme.indicatorColor
                                  : Colors.black12,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            e.category!,
                            style: ctrl.categories
                                        .elementAt(ctrl.selectedCategory)
                                        .category ==
                                    e.category
                                ? Get.textTheme.displayMedium!
                                    .copyWith(fontSize: 14)
                                : Get.textTheme.bodySmall!
                                    .copyWith(fontSize: 13),
                          ),
                        ),
                      )
                      .toList(),
                  controller: ctrl.tabController,
                  dividerHeight: 0,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                  isScrollable: true,
                  indicator: const BoxDecoration(),
                  tabAlignment: TabAlignment.start,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.white;
                      }
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.white;
                      }
                      return null;
                    },
                  ),
                ),
              ),
            const Expanded(child: ArticlesList()),
          ],
        ),
      ),
    );
  }
}
