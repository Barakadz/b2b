import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/ui/pages/base_page.dart';
import 'package:business/src/ui/pages/fleet/widgets/fleet_item.dart';
import 'package:business/src/ui/pages/fleet/widgets/fleet_dialog.dart';
import 'package:business/src/ui/pages/offers/widgets/offer_dialog.dart';

import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';
import 'package:business/src/controllers/navigator/fleet_controller.dart';

class FleetPage extends StatefulWidget {
  const FleetPage({super.key});

  @override
  BasePageState<FleetPage> createState() => _FleetPageState();
}

class _FleetPageState extends BasePageState<FleetPage>
    implements DialogInterface {
  int initPosition = 0;
  GlobalKey<OfferDialogState> offerDialog = GlobalKey();
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  @override
  void initState() {
    //get controller
    FleetController ctrl = Get.find<FleetController>();

    //Refresh
    if (ctrl.subscribers.isEmpty) {
      Future.delayed(
        Duration.zero,
        () {
          refreshIndicator.currentState!.show(atTop: true);
        },
      );
    }

    //Refresh
    if (true) {
      Future.delayed(
        Duration.zero,
        () {
          refreshIndicator.currentState!.show(atTop: true);
        },
      );
    }

    //Super call
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          // toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            Get.find<NavigationPageCtrl>().getTitle(NavDrawer.flotteItem),
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
      drawer: NavDrawer(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (val) =>
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.homeItem),
        child: Column(
          children: [
            // Container(
            //     height: 20,
            //     width: Get.width,
            //     decoration: BoxDecoration(
            //       color: Get.theme.primaryColor,
            //       borderRadius: BorderRadius.vertical(
            //         bottom: Radius.elliptical(Get.width, 60.0),
            //       ),
            //     )),
            Expanded(
              child: RefreshIndicator(
                key: refreshIndicator,
                onRefresh: () => onRefresh(true),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.black12,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'searchFloat'.tr,
                                  hintStyle: Get.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                          fontSize: 15, color: Colors.black26),
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.black12,
                            ),
                            child: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: GetBuilder<FleetController>(
                      id: "FleetList",
                      builder: (ctrl) {
                        return ListView.builder(
                          itemCount: ctrl.subscribers.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                              child: FleetItem(ctrl.subscribers[i]),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      ctrl.select(i);
                                      return FleetDialog(
                                        listener: null,
                                        key: offerDialog,
                                      );
                                    });
                              },
                            );
                          },
                        );
                      },
                    )),
                    GetBuilder<FleetController>(
                        id: "loader",
                        builder: (ctrl) {
                          onStatusChanged(ctrl.result);
                          return const SizedBox();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClick(Key? key, ClickType clickType) {
    if (key == offerDialog) {
      Navigator.pop(context);
    }
  }

  Future<void> onRefresh(bool force) async {
    await Get.find<FleetController>().reload(force);
  }
}
