import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:business/src/ui/pages/splash_page.dart';
import 'package:business/src/ui/pages/otp/otp_page.dart';
import 'package:business/src/ui/pages/otp/login_page.dart';
import 'package:business/src/ui/pages/navigator/navigator_page.dart';
import 'package:business/src/controllers/globale/auth_controller.dart';

final routes = {
  '/': (context) => const Router(),
  LoginPage.routeName: (context) =>
      LoginPage(title: AppLocalizations.of(context)!.helloWorld),
  OtpPage.routeName: (context) =>
      OtpPage(title: AppLocalizations.of(context)!.helloWorld),
  NavigatorPage.routeName: (context) =>
      NavigatorPage(title: AppLocalizations.of(context)!.helloWorld),
};

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<AuthController>(
          id: "status",
          builder: (ctrl) {
            switch (ctrl.status) {
              case AuthStatus.uninitialized:
                return const SplashPage();
              case AuthStatus.unverified:
                return const OtpPage(title: "OTP");
              case AuthStatus.unauthenticated:
                return const LoginPage(title: "Login");
              case AuthStatus.otpAccepted:
                return const SplashPage();
              default:
                return NavigatorPage(title: "Home");
            }
          }),
    );
  }
}
