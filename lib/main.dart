import 'package:business/src/controllers/current_user_company_controller.dart';
import 'package:business/src/controllers/fleet_dialog_controller.dart';
import 'package:business/src/controllers/navigator/fleet_controller.dart';
import 'package:business/src/controllers/navigator/navigator_controller.dart';
import 'package:business/src/controllers/navigator/offers_controller.dart';
import 'package:business/src/languages/language_controller.dart';
import 'package:business/src/languages/translations.dart';
import 'package:business/src/models/enums/theme_mode.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/helpers/routes.dart';
import 'package:business/src/assets/themes/dark_mode.dart';
import 'package:business/src/assets/themes/light_mode.dart';
import 'package:business/src/controllers/splash_controller.dart';
import 'package:business/src/controllers/globale/auth_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.clear();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    print("ThemeMode // initState");
    super.initState();
    Future.delayed(Duration.zero, () async {
      _themeMode = await _getThemeMode();
      Get.changeThemeMode(_themeMode);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Add controllers to getX
    Get.put(AuthController());
    Get.put(SplashController());
    Get.put(LanguageCtrl());
    Get.put(OffersController());
    Get.put(FleetController());
    Get.put(FleetDialogController());
    Get.put(NavigatorController());
    Get.put(CurrentUserCompanyController());

    //ThemeMode mode = ThemeMode.system;
    String lang = 'en';
    /*Preferences.getLocale().then((value) {
      lang = value ?? 'en';
    });*/

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Djezzy Business",
      translations: Translation(),
      locale: Locale(lang),
      fallbackLocale: const Locale('en'),
      theme: LightTheme.get(),
      darkTheme: DarkTheme.get(),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: routes,
    );
  }

  Future<ThemeMode> _getThemeMode() async {
    return ThemeModeEx.get(await Preferences.get('mode'));
  }
}
