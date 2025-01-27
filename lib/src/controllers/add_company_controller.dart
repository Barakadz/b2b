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

class AddCompanyController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final domainDropdownKey = GlobalKey<FormFieldState>();
  final communeDropdownKey = GlobalKey<FormFieldState>();

  var isLoadingSubmitCompany = false.obs;
  var companyName = ''.obs;
  var activity = ''.obs;
  var email = ''.obs;

  var companyPhone1Extension = ''.obs;
  var companyPhone1 = ''.obs;
  var companyPhone2Extension = ''.obs;
  var companyPhone2 = ''.obs;

  var companyFax = ''.obs;
  var companyAddress1 = ''.obs;
  var companyAddress2 = ''.obs;
  var website = ''.obs;
  var description = ''.obs;
  var image = Rx<XFile?>(null);
  var isLoadingCategoryList = true.obs;
  Rx<int?> selectedCategoryId = Rx<int?>(null);
  RxList<CompanyCategory> companyCategories = <CompanyCategory>[].obs;

  var isLoadingDomainList = false.obs;
  Rx<int?> selectedDomainId = Rx<int?>(null);
  RxList<CompanyDomain> companyDomains = <CompanyDomain>[].obs;

  var isLoadingWilayaList = false.obs;
  Rx<int?> selectedWilayaId = Rx<int?>(null);
  RxList<Wilaya> wilayas = <Wilaya>[].obs;

  var isLoadingCommuneList = false.obs;
  Rx<int?> selectedCommuneId = Rx<int?>(null);
  RxList<Commune> communes = <Commune>[].obs;

  @override
  void onInit() {
    super.onInit();
    getActivityCategories();
    getWilayaList();
  }

  init() {}

  void getActivityCategories() async {
    isLoadingCategoryList.value = true;
    try {
      Map<String, dynamic> data =
          await CompanyRepository.getActivityCategories();
      companyCategories.assignAll(CompanyCategories.fromJson(data).data ?? []);
      print('');
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
     companyDomains.clear();
    getDomainList();
  }

  void getDomainList() async {
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

  void getWilayaList() async {
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

  onChangeSelectedWilaya() async {

// Clear the previously selected commune
   
  // Fetch communes for the newly selected wilaya
  //communes.clear(); // Ensure the list is reset
 
    //communeDropdownKey.currentState?.reset();
   // selectedCommuneId.value = null;
    //communes.clear();
   await getCommuneList();
  }

    getCommuneList() async {
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
        Map<String, dynamic> data = await CompanyRepository.addCompany(
          companyName: companyName.value,
          serviceType: 'serviceType',
          subscriptionType: 'subscriptionType',
          activity: activity.value,
          activityCategoryId: selectedCategoryId.value,
          activityDomainId: selectedDomainId.value,
          email: email.value,
          companyPhone1Extension: '213',
          // companyPhone1Extension.value,
          companyPhone1: companyPhone1.value,
          companyPhone2Extension: '213',
          // companyPhone2Extension.value,
          companyPhone2: companyPhone2.value,
          companyFax: companyFax.value,
          wilayaId: selectedWilayaId.value,
          communeId: selectedCommuneId.value,
          companyAddress1: companyAddress1.value,
          companyAddress2: companyAddress2.value,
          website: website.value,
          description: description.value,
          image: null,
          // image.value,
        );
        SnackBarInfo.snackAlert(
            'Success', 'company  has been added successfully', Alerts.success);
        init();
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
        isLoadingCommuneList.value;
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
