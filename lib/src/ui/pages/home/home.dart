import 'package:business/src/assets/colors.dart';
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
          elevation: 0,
          backgroundColor: CustomColors.secondaryColor,
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
                    style: Get.theme.primaryTextTheme.bodyMedium?.copyWith(height: 2),
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
            HomeHeader2(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                                SizedBox(height: 20,),

                    GetBuilder<AuthController>(
                      builder: (ctrl) => ctrl.connectedProducts.isNotEmpty
                          ? const HomePackagesList()
                          : const PackageEmpty(),
                    ),
                    const SizedBox(height: 10),
                    const HomeQuickActions(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                       child: _buildNewsSection(),
                     )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest News',
              style: Get.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to more news
              },
              child: Text(
                'More',
                style: TextStyle(color: CustomColors.secondaryColor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildNewsCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(int index) {
    return Column(
      children: [
        Container(
          width: 300,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  "assets/images/news.jpg",
                  width: 300,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'News Title ${index + 1}',
                  style: Get.theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

                  SizedBox(height: 20,)

      ],
    );
  }

}


