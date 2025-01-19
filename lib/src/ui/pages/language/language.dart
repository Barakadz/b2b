import 'package:business/src/languages/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageCtrl>(
      builder: (ctrl) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'chooseLang'.tr,
              style: Get.theme.textTheme.displayMedium?.copyWith(fontSize: 18),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              ctrl.setLanguage('en');
            },
            label: Text('englishLang'.tr),
            icon: Icon(ctrl.savedLang.value == 'en'
                ? Icons.check_circle
                : Icons.check_circle_outlined),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith<Size?>(
                (Set<MaterialState> states) {
                  return const Size.fromWidth(150);
                },
              ),
              alignment: Alignment.center,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              ctrl.setLanguage('ar');
            },
            label: Text('arabicLang'.tr),
            icon: Icon(ctrl.savedLang.value == 'ar'
                ? Icons.check_circle
                : Icons.check_circle_outlined),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith<Size?>(
                (Set<MaterialState> states) {
                  return const Size.fromWidth(150);
                },
              ),
              alignment: Alignment.center,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              ctrl.setLanguage('fr');
            },
            label: Text('frenchLang'.tr),
            icon: Icon(ctrl.savedLang.value == 'fr'
                ? Icons.check_circle
                : Icons.check_circle_outlined),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith<Size?>(
                (Set<MaterialState> states) {
                  return const Size.fromWidth(150);
                },
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
