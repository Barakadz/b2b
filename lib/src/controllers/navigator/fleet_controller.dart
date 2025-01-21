
import 'package:business/src/controllers/fleet_dialog_controller.dart';
import 'package:get/get.dart';

import 'package:business/src/models/il/Subscriber.dart';
import 'package:business/src/models/response/pair.dart';

import 'package:business/src/repositories/care_repository.dart';

import 'package:business/src/controllers/base_controller.dart';

  class FleetController extends BaseController {

  var subscribers = <Subscriber>[].obs;

  var selected = -1;
  var loadingSubscriber = false;
  reload(bool force) async {
print("------------------------------------------------------------------reload function start");

    if(result.status == Status.starting || (subscribers.isNotEmpty && !force)) {
      return;
    }
print("------------------------------------------------------------------reload function fin");
print("------------------------------------------------------------------Starting status");

    //Set status to starting
    updateStatus(Pair(Status.starting, Reason.idle));
print("------------------------------------------------------------------Fin status");
print("------------------------------------------------------------------Starting Reload");

    //Reload Data
    await Future.delayed(const Duration(seconds: 5));
    subscribers.value = (await CareRepository.getFleet(null))?.subscribers ?? [];
print("------------------------------------------------------------------Fin reload");
    //Update interface
    update(["FleetList"]);

    //Set status to not starting
    updateStatus(Pair(Status.stopped, Reason.idle));
  }

  select(int selected) async {
print("------------------------------------------------------------------Select function");

    //Get fleet dialog controller
    var ctrl = Get.find<FleetDialogController>();
    ctrl.updateStatus(true);

    //Get member details
    this.selected = selected;
    if(subscribers[selected].packages?.isNotEmpty == false){
      var response = await CareRepository.getFleetMember(null, subscribers[selected].id);
      subscribers[selected].packages = response?.subscribers?[0].packages;
    }

    //Display details
    Get.find<FleetDialogController>().subscriber = subscribers[selected];
    ctrl.updateStatus(false);
  }
}