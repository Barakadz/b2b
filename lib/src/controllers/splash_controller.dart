import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:get/get.dart';

import '/src/controllers/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    Get.find<AuthController>().loadSubscriber();
    super.onInit();
  }
}
