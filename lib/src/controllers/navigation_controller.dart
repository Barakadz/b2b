import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPageCtrl extends GetxController {
  RxString pageTitle = ''.obs;
  List<Map<String, dynamic>> horizentalList = [
    {'title': 'menuItemFlotte'},
    {'title': 'flexy'},
    {'title': 'shop'},
    {'title': 'news'},
  ];
  int selectedTab = 0;

  setSelectedTab(int index) {
    if (selectedTab != index) {
      selectedTab = index;
      update();
    }
  }

  IconData getIcon(int item) {
    switch (item) {
      case NavDrawer.homeItem:
        return Icons.home;
      case NavDrawer.invoicesItem:
        return Icons.list;
      case NavDrawer.offersItem:
        return Icons.data_array;
      case NavDrawer.companiesItem:
        return Icons.business;
      case NavDrawer.flotteItem:
        return Icons.people;
      case NavDrawer.languageItem:
        return Icons.language;
      case NavDrawer.faqItem:
        return Icons.question_answer;
      case NavDrawer.disconnectItem:
        return Icons.logout;
      default:
        return Icons.more_vert;
    }
  }

  String getTitle(int item) {
    switch (item) {
      case NavDrawer.homeItem:
        return '';
      case NavDrawer.invoicesItem:
        return 'menuItemInvoices'.tr;
      case NavDrawer.offersItem:
        return 'menuItemOffers'.tr;
      case NavDrawer.companiesItem:
        return 'menuItemCompanies'.tr;
      case NavDrawer.flotteItem:
        return 'menuItemFlotte'.tr;
      case NavDrawer.faqItem:
        return 'menuItemFaq'.tr;
      default:
        return '';
    }
  }
}
