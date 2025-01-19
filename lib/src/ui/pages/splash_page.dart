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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                fit: BoxFit.contain,
                "assets/images/ic_logo.png",
                width: Get.width * 0.25,
                height: Get.width * 0.25,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: GetBuilder<AuthController>(
                    id: "loader",
                    builder: (ctrl) {
                      if (ctrl.isLoading()) {
                        return const ProgressLoaderWidget();
                      } else {
                        onStatusChanged(ctrl.result);
                        return const SizedBox();
                      }
                    }),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
