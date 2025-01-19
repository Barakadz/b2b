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
  bool isLoadingCompanyList = true;
  bool isCompaniesScrollingEnded = false;
  int? selectedCategoryId;
  // List<Company> companies = [];
  var search = ''.obs;
  // category variables
  List<CompanyCategory> companyCategories = [];
  bool isLoadingCategoryList = false;

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
      isLoadingCompanyList = true;
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
      isLoadingCompanyList = false;
      // update();
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } finally {
      isLoadingCompanyList = false;
      // update();
    }
  }

  void getActivityCategories() async {
    isLoadingCategoryList = true;
    update();
    try {
      Map<String, dynamic> data =
          await CompanyRepository.getActivityCategories();
      companyCategories = CompanyCategories.fromJson(data).data ?? [];
      isLoadingCategoryList = false;
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
