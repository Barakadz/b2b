import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/other/companies.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/models/other/company_category.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/repositories/company_repository.dart';
import 'package:business/src/models/other/company_categories.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CompaniesController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final PagingController<int, Company> pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);

  int currentPage = 1;
  int pageSize = 30;
  int total = 0;
  var isLoadingCompanyList = true.obs;
  bool isCompaniesScrollingEnded = false;
  int? selectedCategoryId;
  // List<Company> companies = [];
  var search = ''.obs;
  // category variables
  RxList<CompanyCategory> companyCategories = <CompanyCategory>[].obs;
  var isLoadingCategoryList =false.obs;

  @override
  void onInit() {
    super.onInit();

    debounce(search, (_) => pagingController.refresh(),
        time: const Duration(milliseconds: 500));

    getActivityCategories();
    pagingController.addPageRequestListener((pageKey) {
      getCompanies(pageKey);
    });
  }

  onChangeSelectedCategory(int categoryId) {
    selectedCategoryId = selectedCategoryId != categoryId ? categoryId : null;
    update();
    pagingController.refresh();
  }

  onChangeSearch(String? value) {
    search.value = value ?? '';
    // search = value ?? '';
    // update();
  }

  isSelectedCategory(CompanyCategory category) {
    return selectedCategoryId != null && category.id == selectedCategoryId;
  }

  void getCompanies(int pageKey) async {
    try {
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("getCompanies start");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
      print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
 
      isLoadingCompanyList.value = true;
 
      Map<String, dynamic> data = await CompanyRepository.getCompanies(
        pageNumber: pageKey,
        search: search.value,
        categoryId: selectedCategoryId,
      );    
 
      CompaniesResponse companiesResponse = CompaniesResponse.fromJson(data);
      total = companiesResponse.total!;
                 
      update();
      final isLastPage =
          companiesResponse.currentPage! >= companiesResponse.lastPage!;

      if (isLastPage) {
        pagingController.appendLastPage(companiesResponse.data ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(companiesResponse.data ?? [], nextPageKey);
      }
      isLoadingCompanyList.value = false;
       update();
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } finally {
      isLoadingCompanyList.value = false;
       update();
    }
  }

  void getActivityCategories() async {
    isLoadingCategoryList.value = true;
    update();
  
    try {
      
      Map<String, dynamic> data =
          await CompanyRepository.getActivityCategories();
      companyCategories.assignAll(CompanyCategories.fromJson(data).data ?? []);
      print('');
  
  print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
        print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("companyCategories======>${  companyCategories[0]}");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");

      isLoadingCategoryList.value = false;
      update();
    } on DataFormatException catch (e) {
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
    if (pagingController.itemList == null) {
      updateStatus(error);
      update();
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
