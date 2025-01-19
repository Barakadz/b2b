
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/models/enums/theme_mode.dart';
import 'package:business/src/services/native/preferences.dart';

class NavigatorController extends GetxController {

  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    ever(themeMode, (_) async {await Preferences.set('mode', themeMode.value.name);});
    getThemeMode();
  }

  void setThemeMode(ThemeMode themeMode) {
    this.themeMode(themeMode);
    Get.changeThemeMode(themeMode);
  }

  void getThemeMode() async {
    ThemeMode themeMode = ThemeModeEx.get(await Preferences.get('mode'));
    this.themeMode(themeMode);
  }
}