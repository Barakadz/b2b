import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/models/other/flag.dart';
import 'package:business/src/repositories/company_repository.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentUserCompanyController extends BaseController {
  final reportCompanyFormKey = GlobalKey<FormState>();
  var managerDescriptionController = TextEditingController();

  var isManager = Rx<bool>(true);
  var isLoadingCurrentUserCompany = Rx<bool>(false);
  var company = Rx<Company?>(null);

  var isLoadingUserCanAddCompany = Rx<bool>(false);
  var isLoadingUserCanUpdateCompany = Rx<bool>(false);
  var isLoadingUserCanReportCompany = Rx<bool>(false);
  var isLoadingReportCompany = Rx<bool>(false);
  var error = Rx<bool>(false);

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  init() async {}

  resetForm() {
    reportCompanyFormKey.currentState?.reset();
  }

  @override
  void onClose() {
    managerDescriptionController.dispose();
    super.onClose();
  }

  Future<void> getCurrentUserCompany() async {
    isLoadingCurrentUserCompany.value = true;
    try {
      Map<String, dynamic>? result =
          await CompanyRepository.currentUserCompany();
      if (result != null) {
        company.value = Company.fromJson(result['data']);
      }
      isLoadingCurrentUserCompany.value = false;
    } on DataFormatException catch (e) {
      error.value = true;
      if (e.toString() == 'INVALID_VALUE') {}
    } on FetchDataException catch (_) {
    } on BadRequestException catch (_) {
    } finally {
      isLoadingCurrentUserCompany.value = false;
    }
    isLoadingCurrentUserCompany.value = false;
  }

  Future<bool> userCanAddCompany() async {
    if (!isManager.value) {
      return false;
    }
    isLoadingUserCanUpdateCompany.value = true;
    try {
      var result = await CompanyRepository.userCanAddCompany();
      isLoadingUserCanUpdateCompany.value = false;
      return result;
    } catch (e) {
      error.value = true;
    } finally {
      isLoadingUserCanUpdateCompany.value = false;
    }
    return false;
  }

  Future<bool> userCanUpdateCompany() async {
    if (!isManager.value) {
      return false;
    }
    isLoadingUserCanUpdateCompany.value = true;
    try {
      var result = await CompanyRepository.userCanUpdateCompany();
      isLoadingUserCanUpdateCompany.value = false;
      return result;
    } catch (e) {
      error.value = true;
    } finally {
      isLoadingUserCanUpdateCompany.value = false;
    }
    return false;
  }

  Future<bool> userCanReportCompany({required int clientId}) async {
    if (!isManager.value) {
      return false;
    }
    isLoadingUserCanReportCompany.value = true;
    try {
      var result =
          await CompanyRepository.userCanReportCompany(clientId: clientId);
      isLoadingUserCanReportCompany.value = false;
      return result;
    } catch (e) {
      error.value = true;
    } finally {
      isLoadingUserCanReportCompany.value = false;
    }
    return false;
  }

  Future<bool> onSubmitReportCompany({required int clientId}) async {
    if (reportCompanyFormKey.currentState!.validate()) {
      reportCompanyFormKey.currentState!.save();
      isLoadingReportCompany.value = true;
      try {
        Map<String, dynamic> data = await CompanyRepository.reportCompany(
          clientId: clientId,
          managerDescription: managerDescriptionController.text.trim(),
        );
        SnackBarInfo.snackAlert('Success',
            'company has been reported successfully', Alerts.success);
        isLoadingReportCompany.value = false;

        if (data['success'] && data['success'] == true) {
          return true;
        }

        // return Flag.fromJson(data);
      } catch (_) {
        globalError();
      } finally {
        isLoadingReportCompany.value = false;
      }
    }
    return false;
  }

  globalError() {
    SnackBarInfo.snackAlert(
      'Error',
      'Echec d\'envoi, veuillez réessayer',
      Alerts.error,
    );
  }

  isLoadingCurrentUserCompanyController() {
    return isLoadingCurrentUserCompany.value ||
        isLoadingUserCanAddCompany.value ||
        isLoadingUserCanUpdateCompany.value ||
        isLoadingUserCanReportCompany.value;
  }
}
