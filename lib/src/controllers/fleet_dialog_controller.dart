
import 'package:get/get.dart';

import 'package:business/src/models/il/Subscriber.dart';

class FleetDialogController extends GetxController {

  var loading = false;
  Subscriber? subscriber;

  updateStatus(bool loading){
    this.loading = loading;
    update(["loading"]);
  }
}