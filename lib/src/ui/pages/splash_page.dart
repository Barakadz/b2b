import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/ui/widgets/progress.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/ui/pages/base_page.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/';

  const SplashPage({super.key});

  @override
  BasePageState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Center(  // This will center the child vertically and horizontally
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Simplified padding
      child: GetBuilder<AuthController>(
        id: "loader",
        builder: (ctrl) {
          if (ctrl.isLoading()) {
            return Image.asset(
              "assets/images/logo_animated.gif",
              fit: BoxFit.contain,
              width: Get.width * 0.4,
              height: Get.width * 0.4,
            );
          } else {
            onStatusChanged(ctrl.result);
            return const SizedBox();  // Optionally return an empty widget when not loading
          }
        }
      ),
    ),
  ),
);

  }
}
