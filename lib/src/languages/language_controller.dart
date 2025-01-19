import 'package:business/src/services/native/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageCtrl extends GetxController {
  RxString savedLang = 'en'.obs;
  saveLocal() async {
    await Preferences.setLocale(savedLang.value);
  }

  Future<void> setLocal() async {
    Preferences.getLocale().then((value) {
      if (value != '' && value != null) {
        Get.updateLocale(Locale(value.toString().toLowerCase()));
        savedLang.value = value.toString();
      }
    });
  }

  static String getLocation() {
    String lang = 'en';
    Preferences.getLocale().then((value) {
      lang = value ?? 'en';
    });
    return lang;
  }

  Future<void> setLanguage(String lang) async {
    Preferences.getLocale().then((value) {
      if (lang != value) {
        Get.updateLocale(Locale(lang.toString().toLowerCase()));
        savedLang.value = lang.toString().toLowerCase();
        saveLocal();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    setLocal();
  }
}
