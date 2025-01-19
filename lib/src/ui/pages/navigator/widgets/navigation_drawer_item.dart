
import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/ui/pages/language/language.dart';
import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/navigator/widgets/generic_dialog.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';

//ignore: must_be_immutable
class DrawerItem extends StatelessWidget implements DialogInterface {

  final int? item;
  final String? desc;

  GlobalKey<GenericDialogState> genericDialog = GlobalKey();

  DrawerItem({
    super.key,
    this.item,
    this.desc
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationPageCtrl>(
      builder: (ctrl) => ListTile(
        leading: Icon(ctrl.getIcon(item!)),
        selected: ctrl.selectedTab == item,
        title: Text(
          desc!,
          style: Get.theme.textTheme.headlineLarge?.copyWith(fontSize: 15),
        ),
        onTap: () {
         // Get.back();
          if (item == NavDrawer.languageItem) {
            Get.bottomSheet(
    const LanguagePage(),
    exitBottomSheetDuration: const Duration(milliseconds: 400),
    enterBottomSheetDuration: const Duration(milliseconds: 400),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
          }
          else if (item == NavDrawer.disconnectItem) {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return GenericDialog(
                    listener: this,
                    key: genericDialog,
                    title: 'titleConfirm'.tr,
                    negative: 'actionCancel'.tr,
                    positive: 'actionConfirm'.tr,
                    message: 'descConfirmLogout'.tr,
                  );
                });
          }
          else {
            ctrl.setSelectedTab(item!);
            ctrl.pageTitle.value = ctrl.getTitle(item!);
          }
        },
      ),
    );
  }

  @override
  void onClick(Key? key, ClickType clickType) {
    if(key == genericDialog){
      if(clickType == ClickType.positive){
        Preferences.setMobileNumber("");
        Get.find<AuthController>().setStatus(AuthStatus.unauthenticated);
      }
      Get.back();
    }
  }
}
