import 'package:get/get.dart';

import 'package:business/src/models/response/pair.dart';

abstract class BaseController extends GetxController {
  Pair result = Pair(Status.idle, Reason.unknown);
  Pair actionStatus = Pair(Status.idle, Reason.unknown);

  void updateStatus(Pair result) {
    this.result = result;
    update(["loader"]);
  }

  bool isLoading() {
    return result.status == Status.starting;
  }

  void updateActionStatus(Pair result) {
    this.result = result;
    update(["action_loader"]);
  }
}
