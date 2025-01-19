import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:flutter/widgets.dart';

class CompanyAddEditController extends BaseController {
  int addressCount = 1;
  int phoneCount = 1;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController domainController;
  late TextEditingController activitiesController;
  late TextEditingController addressAController;
  late TextEditingController addressBController;
  late TextEditingController phoneAController;
  late TextEditingController phoneBController;
  late TextEditingController faxController;
  late TextEditingController websiteController;
  late TextEditingController emailController;

  @override
  void onInit() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    domainController = TextEditingController();
    activitiesController = TextEditingController();
    addressAController = TextEditingController();
    addressBController = TextEditingController();
    phoneAController = TextEditingController();
    phoneBController = TextEditingController();
    faxController = TextEditingController();
    websiteController = TextEditingController();
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    domainController.dispose();
    activitiesController.dispose();
    addressAController.dispose();
    addressBController.dispose();
    phoneAController.dispose();
    phoneBController.dispose();
    faxController.dispose();
    websiteController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void postData() async {
    try {} on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    }
  }

  generateError(Pair error) {
    updateStatus(error);
    update();
  }

  addAddress() {
    if (addressCount == 1) {
      addressCount++;
      update(['address']);
    } else {
      SnackBarInfo.snackMessage(
          'You have to add only one (01) address.', Alerts.info);
    }
  }

  removeAddress() {
    addressCount = 1;
    update(['address']);
  }

  addPhone() {
    if (phoneCount == 1) {
      phoneCount++;
      update(['phone']);
    } else {
      SnackBarInfo.snackMessage(
          'You have to add only one (01) phone.', Alerts.info);
    }
  }

  removePhone() {
    phoneCount = 1;
    update(['phone']);
  }
}
