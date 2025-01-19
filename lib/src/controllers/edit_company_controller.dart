import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/other/commune.dart';
import 'package:business/src/models/other/communes.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/models/other/company_categories.dart';
import 'package:business/src/models/other/company_category.dart';
import 'package:business/src/models/other/company_domain.dart';
import 'package:business/src/models/other/company_domains.dart';
import 'package:business/src/models/other/wilaya.dart';
import 'package:business/src/models/other/wilayas.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/repositories/company_repository.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class EditCompanyController extends BaseController {
  final formKey = GlobalKey<FormState>();
  var companyNameController = TextEditingController();
  var serviceTypeController = TextEditingController();
  var subscriptionTypeController = TextEditingController();
  var activityController = TextEditingController();
  var emailController = TextEditingController();
  var companyPhone1ExtensionController = TextEditingController();
  var companyPhone1Controller = TextEditingController();
  var companyPhone2ExtensionController = TextEditingController();
  var companyPhone2Controller = TextEditingController();
  var companyFaxController = TextEditingController();
  var companyAddress1Controller = TextEditingController();
  var companyAddress2Controller = TextEditingController();
  var websiteController = TextEditingController();
  var descriptionController = TextEditingController();

  final domainDropdownKey = GlobalKey<FormFieldState>();
  final communeDropdownKey = GlobalKey<FormFieldState>();
  var isLoadingSubmitCompany = false.obs;

  var image = Rx<XFile?>(null);
  var isLoadingCategoryList = true.obs;

  Rx<int?> selectedCategoryId = Rx<int?>(null);
  RxList<CompanyCategory> companyCategories = <CompanyCategory>[].obs;

  var isLoadingDomainList = false.obs;
  Rx<int?> selectedDomainId = Rx<int?>(null);
  RxList<CompanyDomain> companyDomains = <CompanyDomain>[].obs;

  var isLoadingWilayaList = false.obs;
  Rx<int?> selectedWilayaId = Rx<int?>(null);
  var wilayas = <Wilaya>[].obs;

  var isLoadingCommuneList = false.obs;
  Rx<int?> selectedCommuneId = Rx<int?>(null);
  var communes = <Commune>[].obs;

  var isLoadingCurrentUserCompany = true.obs;
  var currentCompany = Rx<Company?>(null);

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  init() async {
    await getCurrentUserCompany();
    await getActivityCategories();
    await getWilayaList();

    // resetForm();

    companyNameController.text = currentCompany.value?.companyName ?? '';
    serviceTypeController.text = currentCompany.value?.serviceType ?? '';
    activityController.text = currentCompany.value?.activity ?? '';
    emailController.text = currentCompany.value?.email ?? '';
    companyPhone1ExtensionController.text =
        currentCompany.value?.companyPhone1Extension ?? '';
    companyPhone1Controller.text = currentCompany.value?.companyPhone1 ?? '';
    companyPhone2ExtensionController.text =
        currentCompany.value?.companyPhone2Extension ?? '';
    companyPhone2Controller.text = currentCompany.value?.companyPhone2 ?? '';
    companyFaxController.text = currentCompany.value?.companyFax ?? '';
    companyAddress1Controller.text =
        currentCompany.value?.companyAddress1 ?? '';
    companyAddress2Controller.text =
        currentCompany.value?.companyAddress2 ?? '';
    websiteController.text = currentCompany.value?.website ?? '';
    descriptionController.text = currentCompany.value?.description ?? '';
    selectedCategoryId.value = currentCompany.value?.activityCategoryId;
    await getDomainList();
    selectedDomainId.value = currentCompany.value?.activityDomainId;
    selectedWilayaId.value = currentCompany.value?.wilayaId;
    await getCommuneList();
    selectedCommuneId.value = currentCompany.value?.communeId;
  }

  resetForm() {
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    companyNameController.dispose();
    serviceTypeController.dispose();
    subscriptionTypeController.dispose();
    activityController.dispose();
    emailController.dispose();
    companyPhone1ExtensionController.dispose();
    companyPhone1Controller.dispose();
    companyPhone2ExtensionController.dispose();
    companyPhone2Controller.dispose();
    companyFaxController.dispose();
    companyAddress1Controller.dispose();
    companyAddress2Controller.dispose();
    websiteController.dispose();
    descriptionController.dispose();
    formKey.currentState?.dispose();
    super.onClose();
  }

  Future<void> getCurrentUserCompany() async {
    isLoadingCurrentUserCompany.value = true;
    try {
      Map<String, dynamic>? result =
          await CompanyRepository.currentUserCompany();
      if (result != null) {
        currentCompany.value = Company.fromJson(result['data']);
      }
      isLoadingCurrentUserCompany.value = false;
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {}
    } on FetchDataException catch (_) {
    } on BadRequestException catch (_) {
    } finally {
      isLoadingCurrentUserCompany.value = false;
    }
  }

  Future<void> getActivityCategories() async {
    isLoadingCategoryList.value = true;
    try {
      Map<String, dynamic> data =
          await CompanyRepository.getActivityCategories();
      companyCategories.assignAll(CompanyCategories.fromJson(data).data ?? []);
      isLoadingCategoryList.value = false;
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        // generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    }
  }

  onChangeSelectedCategory() {
    domainDropdownKey.currentState?.reset();
    selectedDomainId.value = null;
    companyDomains.clear();
    getDomainList();
  }

  Future<void> getDomainList() async {
    isLoadingDomainList.value = true;
    try {
      Map<String, dynamic> data =
          await CompanyRepository.getActivityDomainsByCategoryId(
              selectedCategoryId.value ?? 0);
      companyDomains.assignAll(CompanyDomains.fromJson(data).data ?? []);
      isLoadingDomainList.value = false;
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        // generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    }
  }

  Future<void> getWilayaList() async {
    isLoadingWilayaList.value = true;
    try {
      Map<String, dynamic> data = await CompanyRepository.getWilayas();
      wilayas.assignAll(Wilayas.fromJson(data).data ?? []);
      isLoadingWilayaList.value = false;
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        // generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    }
  }

  onChangeSelectedWilaya() {
    communeDropdownKey.currentState?.reset();
    selectedCommuneId.value = null;
    communes.clear();
    getCommuneList();
  }

  Future<void> getCommuneList() async {
    isLoadingCommuneList.value = true;
    try {
      Map<String, dynamic> data = await CompanyRepository.getCommunesByWilayaId(
          selectedWilayaId.value ?? 0);
      communes.assignAll(Communes.fromJson(data).data ?? []);
      isLoadingCommuneList.value = false;
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        // generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      // generateError(Pair(Status.error, Reason.unknown));
    }
  }

  Future selectCompanyLogo() async {
    ImagePicker? picker = ImagePicker();
    try {
      final tmp =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (tmp == null) return;
      final String fileExtension = tmp.name.split('.').last.toLowerCase();
      if (fileExtension == 'jpeg' ||
          fileExtension == 'jpg' ||
          fileExtension == 'png') {
        // imaged = true;
        image.value = tmp;
      } else {
        SnackBarInfo.snackAlert('Warning',
            'Please select a JPEG, JPG, or PNG image.', Alerts.warning);
      }
    } catch (e) {
      // imaged = false;
    }
  }

  removeCompanyLogo() {
    image.value = null;
  }

  Future<Company?> onSubmitCompany() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoadingSubmitCompany.value = true;
      // Convert image to MultipartFile if image is not null
      dio.MultipartFile? imageFile;
      if (image.value != null) {
        imageFile = await dio.MultipartFile.fromFile(image.value!.path,
            filename: image.value!.name);
      }
      try {
        Map<String, dynamic> data = await CompanyRepository.updateCompany(
          companyName: companyNameController.text,
          serviceType: serviceTypeController.text,
          subscriptionType: subscriptionTypeController.text,
          activity: activityController.text,
          activityCategoryId: selectedCategoryId.value,
          activityDomainId: selectedDomainId.value,
          email: emailController.text,
          companyPhone1Extension: companyPhone1ExtensionController.text,
          companyPhone1: companyPhone1Controller.text,
          companyPhone2Extension: companyPhone2ExtensionController.text,
          companyPhone2: companyPhone1Controller.text,
          companyFax: companyFaxController.text,
          wilayaId: selectedWilayaId.value,
          communeId: selectedCommuneId.value,
          companyAddress1: companyAddress1Controller.text,
          companyAddress2: companyAddress2Controller.text,
          website: websiteController.text,
          description: descriptionController.text,
          image: null,
          // image.value,
        );
        SnackBarInfo.snackAlert(
          'Success',
          'Your request for update has been received successfully',
          Alerts.success,
        );
        return Company.fromJson(data);
      } on DataFormatException catch (_) {
        globalError();
      } on FetchDataException catch (_) {
        globalError();
      } on BadRequestException catch (_) {
        globalError();
      } catch (_) {
        globalError();
      } finally {
        isLoadingSubmitCompany.value = false;
      }
    }
  }

  isLoadingPage() {
    return isLoadingSubmitCompany.value ||
        isLoadingCategoryList.value ||
        isLoadingDomainList.value ||
        isLoadingWilayaList.value ||
        isLoadingCommuneList.value ||
        isLoadingCurrentUserCompany.value;
  }

  closeBottomSheet() {
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }
  }

  globalError() {
    closeBottomSheet();
    SnackBarInfo.snackAlert(
        'Error', 'Echec d\'envoi, veuillez réessayer', Alerts.error);
  }

  generateError(Pair error) {
    // if (pagingController.itemList == null) {
    //   updateStatus(error);
    //   update();
    // }
  }
}
