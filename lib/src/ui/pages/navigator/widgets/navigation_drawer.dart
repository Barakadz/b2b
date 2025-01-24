import 'package:business/src/assets/colors.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/language/language.dart';
import 'package:business/src/ui/pages/navigator/widgets/generic_dialog.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/controllers/navigator/navigator_controller.dart';
import 'package:business/src/ui/widgets/circle_image.dart';

class NavDrawer extends StatelessWidget {
  static const int homeItem = 0;
  static const int invoicesItem = 1;
  static const int offersItem = 2;
  static const int companiesItem = 3;
  static const int flotteItem = 4;
  static const int languageItem = 5;
  static const int faqItem = 6;
  static const int disconnectItem = 7;

  final NavigationPageCtrl _navigationCtrl = Get.find();
  final AuthController _authController = Get.find();

  NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: _buildDrawerItems(context)
          ),
          _buildThemeToggle(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return  Container(
            height: 230,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      CustomColors.secondaryColor,
                      CustomColors.secondaryColor.withOpacity(0.8),
                    ],
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      CustomColors.secondaryColor.withOpacity(0.3),
                      BlendMode.dstATop,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: CustomColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                      
                    Text(
  _authController.subscriptionType.name!.getValue(),                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
            _authController.subscriber.msisdn ?? '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
Widget _buildDrawerItems(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
          _buildDrawerItem(
  icon: Icons.home_outlined,
  title: 'menuItemHome'.tr,
  context: context,
  isSelected: Get.find<NavigationPageCtrl>().selectedTab == NavDrawer.homeItem, // Dynamic selection
  onTap: () {
    Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.homeItem);
    Get.find<NavigationPageCtrl>().pageTitle.value = 
        Get.find<NavigationPageCtrl>().getTitle(NavDrawer.homeItem);
    Navigator.pop(context);
  },
),
        if (_authController.paymentType == 'PaymentType.prepaid')
          _buildDrawerItem(
            icon: Icons.receipt_long_outlined,
            title: 'menuItemInvoices'.tr,
            context: context,
              isSelected: Get.find<NavigationPageCtrl>().selectedTab == NavDrawer.invoicesItem, // Dynamic selection

            onTap: () {
              Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.invoicesItem);
              Get.find<NavigationPageCtrl>().pageTitle.value = 
                  Get.find<NavigationPageCtrl>().getTitle(NavDrawer.invoicesItem);
              Navigator.pop(context);
            },
          ),
        _buildDrawerItem(
          icon: Icons.local_offer_outlined,
          title: 'menuItemOffers'.tr,
          context: context,
                        isSelected: Get.find<NavigationPageCtrl>().selectedTab == NavDrawer.offersItem, // Dynamic selection

          onTap: () {
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.offersItem);
            Get.find<NavigationPageCtrl>().pageTitle.value = 
                Get.find<NavigationPageCtrl>().getTitle(NavDrawer.offersItem);
            Navigator.pop(context);
          },
        ),
        _buildDrawerItem(
                                  isSelected: Get.find<NavigationPageCtrl>().selectedTab == NavDrawer.companiesItem, // Dynamic selection

          icon: Icons.business_outlined,
          title: 'menuItemCompanies'.tr,
          context: context,
          onTap: () {
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.companiesItem);
            Get.find<NavigationPageCtrl>().pageTitle.value = 
                Get.find<NavigationPageCtrl>().getTitle(NavDrawer.companiesItem);
            Navigator.pop(context);
          },
        ),
        _buildDrawerItem(
                                            isSelected: Get.find<NavigationPageCtrl>().selectedTab == NavDrawer.flotteItem, // Dynamic selection

          icon: Icons.supervised_user_circle_outlined,
          title: 'menuItemFlotte'.tr,
          context: context,
          onTap: () {
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.flotteItem);
            Get.find<NavigationPageCtrl>().pageTitle.value = 
                Get.find<NavigationPageCtrl>().getTitle(NavDrawer.flotteItem);
            Navigator.pop(context);
          },
        ),
                  _buildDrawerDivider(),

        _buildDrawerItem(
 
          icon: Icons.language_outlined,
          title: 'menuItemLanguage'.tr,
          context: context,
          onTap: () {
            Get.bottomSheet(
              const LanguagePage(),
              exitBottomSheetDuration: const Duration(milliseconds: 400),
              enterBottomSheetDuration: const Duration(milliseconds: 400),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
            );
          },
        ),
        _buildDrawerItem(
          icon: Icons.help_outline,
          title: 'menuItemFaq'.tr,
          context: context,
                                                      isSelected: Get.find<NavigationPageCtrl>().selectedTab == NavDrawer.faqItem, // Dynamic selection

          onTap: () {
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.faqItem);
            Get.find<NavigationPageCtrl>().pageTitle.value = 
                Get.find<NavigationPageCtrl>().getTitle(NavDrawer.faqItem);
            Navigator.pop(context);
          },
        ),
                  Divider(),

        _buildDrawerItem(
          icon: Icons.logout_outlined,
          title: 'menuItemDisconnect'.tr,
          context: context,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return GenericDialog(
                  listener: DrawerItem(),
                  title: 'titleConfirm'.tr,
                  negative: 'actionCancel'.tr,
                  positive: 'actionConfirm'.tr,
                  message: 'descConfirmLogout'.tr,
                );
              }
            );
          },
        ),
      ],
    ),
  );
}

// Update _buildDrawerItem to accept an onTap callback
Widget _buildDrawerItem({
  required IconData icon,
  required String title,
  required BuildContext context,
  bool isSelected = false,
  String? badge,
  Color? textColor,
  Color? iconColor,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: isSelected ? CustomColors.secondaryColor.withOpacity(0.1) : Colors.transparent,
    ),
    child: ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? (isSelected ? CustomColors.secondaryColor : Colors.grey[700]),
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (isSelected ? CustomColors.secondaryColor : Colors.grey[800]),
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
  
Widget _buildDrawerDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
  );
}
 

  Widget _buildThemeToggle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<NavigatorController>(
        builder: (ctrl) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _themeButton(
              ThemeMode.light,
              ctrl.themeMode(),
              ctrl.setThemeMode,
            ),
            _themeButton(
              ThemeMode.dark,
              ctrl.themeMode(),
              ctrl.setThemeMode,
            ),
            _themeButton(
              ThemeMode.system,
              ctrl.themeMode(),
              ctrl.setThemeMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeButton(
    ThemeMode mode,
    ThemeMode currentMode,
    Function(ThemeMode) onChanged,
  ) {
    final isSelected = mode == currentMode;
    return ElevatedButton(
      onPressed: () => onChanged(mode),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Get.theme.primaryColor : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(
        _getThemeModeName(mode),
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _handleDrawerItemTap(int item) {
    switch (item) {
      case homeItem:
        // Handle home navigation
        break;
      case invoicesItem:
        // Handle invoices navigation
        break;
      case offersItem:
        // Handle offers navigation
        break;
      case companiesItem:
        // Handle companies navigation
        break;
      case flotteItem:
        // Handle flotte navigation
        break;
      case languageItem:
        _showLanguageOptions();
       case faqItem:
        // Handle FAQ navigation
        break;
      case disconnectItem:
        break;
    }
  }

  void _showProfileOptions() {
    // Implement profile options dialog or navigation
    Get.dialog(
      AlertDialog(
        title: Text('Profile Options'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'.tr),
              onTap: () {
                Get.back();
                // Navigate to profile edit
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Account Settings'.tr),
              onTap: () {
                Get.back();
                // Navigate to account settings
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageOptions() {
     Get.bottomSheet(
    const LanguagePage(),
    exitBottomSheetDuration: const Duration(milliseconds: 400),
    enterBottomSheetDuration: const Duration(milliseconds: 400),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
  }
}