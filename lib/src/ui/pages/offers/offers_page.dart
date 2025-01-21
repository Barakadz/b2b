import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/helpers/alert_helper.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/ui/pages/base_page.dart';
import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';
import 'package:business/src/controllers/navigator/offers_controller.dart';
import 'package:business/src/ui/pages/offers/widgets/offer_item.dart';
import 'package:business/src/ui/pages/offers/widgets/offer_dialog.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  BasePageState<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends BasePageState<OffersPage>
    with TickerProviderStateMixin
    implements DialogInterface {
  GlobalKey<OfferDialogState> offerDialog = GlobalKey();
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  var _tabController;

  @override
  void initState() {
    //get controller
    OffersController ctrl = Get.find<OffersController>();

    //Refresh
    if (ctrl.products.isEmpty) {
      Future.delayed(
        Duration.zero,
        () => refreshIndicator.currentState!.show(atTop: true),
      );
    }

    //Super call
    super.initState();
  }

  late int _currentPosition = 0;

  @override
  void dispose() {
    print("OffersPage /// Dispose");
    if (_tabController != null) {
      _tabController.removeListener(onPositionChange);
    }
    super.dispose();
  }

  void onPositionChange() {
    if (_tabController != null && !_tabController.indexIsChanging) {
      _currentPosition = _tabController.index;
      Get.find<OffersController>().updatePosition(_currentPosition);
    }
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
            Get.find<NavigationPageCtrl>().getTitle(NavDrawer.offersItem),
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
          child: Column(children: [
            GetBuilder<OffersController>(
              id: "OffersList",
              builder: (ctrl) {
                //Remove listener if exist
                if (_tabController != null) {
                  _tabController.removeListener(onPositionChange);
                }

                //Recreate tabController
                _tabController =
                    TabController(length: ctrl.products.length, vsync: this);
                _tabController.addListener(onPositionChange);

                return ctrl.products.isNotEmpty
                    ? TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        tabs: List.generate(
                          ctrl.products.length,
                          (i) => Tab(
                            text: ctrl.products[i].name?.getValue(),
                          ),
                        ))
                    : Container();
              },
            ),
//card of offres
            Expanded(
              child: RefreshIndicator(
                key: refreshIndicator,
                onRefresh: () => onRefresh(true),
                child: GetBuilder<OffersController>(
                  id: "selected",
                  builder: (ctrl) {
                    return ListWheelScrollView(
                     
                       itemExtent: 220,
                      physics: const FixedExtentScrollPhysics(),
                      controller: ctrl.listController,
                      diameterRatio: 4,
                      children: getPackages(ctrl),
                    );
                  },
                ),
              ),
            ),
            GetBuilder<OffersController>(
                id: "loader",
                builder: (ctrl) {
                  onStatusChanged(ctrl.result);
                  return const SizedBox();
                }),
          ])),
    );
  }

  var themeMode = ThemeMode.light;

  @override
  void onStartLoading() {
    AlertHelper.showLoadingIndicator(context, 'displayWait'.tr);
  }

  @override
  void onStopLoading() {
    Get.back();
  }

  @override
  void onClick(Key? key, ClickType clickType) {
    print("click sur Activate");
    print("package : ${offerDialog}");
    if (key == offerDialog) {
      if (clickType == ClickType.positive) {
        Get.find<OffersController>()
            .activate(offerDialog.currentState!.widget.package);
      }
      Get.back();
    }
  }

  Future<void> onRefresh(bool force) async {
    await Get.find<OffersController>().reload(force);
  }

  getPackages(OffersController ctrl) {
    var packs = ctrl.products.length > ctrl.selected
        ? ctrl.products[ctrl.selected].packs
        : [];

    List<Widget> list = [];
    for (Package p in (packs ?? [])) {
      list.add(GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext bc) {
                  return OfferDialog(
                    listener: this,
                    key: offerDialog,
                    package: p,
                  );
                });
          },
          child: OfferItem(p)));
    }
    return list;
  }

  @override
  onStatusChanged(Pair result) {
    //Add package retrieve
    if (result.status == Status.success) {
      Future.delayed(
        Duration.zero,
        () {
          Get.back();
          AlertHelper.showMyDialog(context, "Félicitations", "Offre activé");
        },
      );
    } else {
      return super.onStatusChanged(result);
    }
  }
}
