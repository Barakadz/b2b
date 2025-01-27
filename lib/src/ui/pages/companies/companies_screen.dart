import 'package:business/src/controllers/companies_controller.dart';
import 'package:business/src/controllers/current_user_company_controller.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/ui/pages/companies/add_company_screen.dart';
import 'package:business/src/ui/pages/companies/edit_company_screen.dart';
import 'package:business/src/ui/pages/companies/company_detail_screen.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyCategory {
  final int? id;
  final String? code;
  final String? name;
  final int? parentId;

  const CompanyCategory({this.id, this.code, this.name, this.parentId});

  factory CompanyCategory.fromJson(Map<String, dynamic> json) {
    return CompanyCategory(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      parentId: json['parentId'] ?? 0,
    );
  }
}

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});
  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final CurrentUserCompanyController _currentUserCompanyController =
      Get.find<CurrentUserCompanyController>();
  final TextEditingController _searchController = TextEditingController();

  var userCanAddCompany = false;
  var userCanUpdateCompany = false;
     List<CompanyCategory> companyCategories = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getCurrentUserCompanyInfo();
  }

  Future<void> getCurrentUserCompanyInfo() async {






    
    _currentUserCompanyController.getCurrentUserCompany();
    var userCanAddCompanyResult =
        await _currentUserCompanyController.userCanAddCompany();
    var userCanUpdateCompanyResult =
        await _currentUserCompanyController.userCanUpdateCompany();

    setState(() {
       companyCategories = [
        CompanyCategory(
          id: 4263,
          code: "A",
          name: "AGRICULTURE, CHASSE ET SYLVICULTURE",
          parentId: 22,
        ),
        CompanyCategory(
          id: 4264,
          code: "B",
          name: "INDUSTRIE MANUFACTURIÈRE",
          parentId: 23,
        ),
        CompanyCategory(
          id: 4265,
          code: "C",
          name: "CONSTRUCTION",
          parentId: 24,
        ),
      ];
   
  
      userCanAddCompany = userCanAddCompanyResult;
      userCanUpdateCompany = userCanUpdateCompanyResult;
    });
  }

  Future<void> _refreshCompanies() async {
    final CompaniesController companiesController =
        Get.find<CompaniesController>();
    companiesController.pagingController.refresh();
  }

  void _clearSearch() {
    _searchController.clear();
    Get.find<CompaniesController>().onChangeSearch('');
  }

  void _onSearchChanged() {
    setState(() {});
  }

  Future<void> _makePhoneCall(Company company) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: company.companyPhone1 ?? company.companyPhone1 ?? '',
    );
    await launchUrl(launchUri);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  final CompaniesController companiesController2 = Get.put(CompaniesController());

 
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          Get.find<NavigationPageCtrl>().getTitle(NavDrawer.companiesItem),
          style: Get.theme.primaryTextTheme.bodyMedium?.copyWith(
            fontSize: 25, 
            fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
      ),
    ),
    drawer: NavDrawer(),
    body: PopScope(
      canPop: false,
      onPopInvoked: (val) => Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.homeItem),
      child: RefreshIndicator(
        onRefresh: _refreshCompanies,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField(
                      onChanged: (value) {
                        companiesController2.onChangeSearch(value);
                      },
                      controller: _searchController,
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 16.0
                        ),
                        hintStyle: Get.theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15, 
                          color: Colors.black26
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400, 
                            width: 1.0
                          ),
                        ),
                        suffixIcon: _searchController.text.trim().isNotEmpty
                            ? IconButton(
                                onPressed: _clearSearch,
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                        hintText: 'searchCompanies'.tr,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 34,
                child: companiesController2.isLoadingCategoryList.value
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => _buildCategoryLoader(),
                        separatorBuilder: (context, index) => const SizedBox(width: 6),
                      )
                    : companiesController2.companyCategories.isNotEmpty
                        ? Obx(() =>                      ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  companiesController2.companyCategories.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  // if (!companiesController2
                                  //         .isLoadingCompanyList &&
                                  //     !companiesController2
                                  //         .isLoadingCategoryList) {
                                  companiesController2.onChangeSelectedCategory(
                                    companiesController2
                                            .companyCategories[index].id ??
                                        0,
                                  );
                                  // }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        companiesController2.isSelectedCategory(
                                                companiesController2
                                                    .companyCategories[index])
                                            ? Colors.white
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: companiesController2
                                              .isSelectedCategory(
                                                  companiesController2
                                                      .companyCategories[index])
                                          ? Get.theme.primaryColor
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      companiesController2
                                              .companyCategories[index].name ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 1,
                                        color: companiesController2
                                                .isSelectedCategory(
                                                    companiesController2
                                                            .companyCategories[
                                                        index])
                                            ? Get.theme.primaryColor
                                            : Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 6,
                              ),
                            ),
                    //end listview
        )
                        : const Center(child: Text('No categories available')),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Skeletonizer(
                      enabled: companiesController2.isLoadingCompanyList.value,
                      child: Text(
                        '${companiesController2.total} companies',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PagedListView<int, Company>(
                  shrinkWrap: false,
                  pagingController: companiesController2.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Company>(
                    itemBuilder: (context, company, index) {
                      return Column(
                        children: [
                          _buildCompany(companiesController2, company),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                    newPageProgressIndicatorBuilder: (context) => Column(
                      children: [
                        _buildCompanyLoader(),
                        const SizedBox(height: 12),
                        _buildCompanyLoader(),
                      ],
                    ),
                    firstPageProgressIndicatorBuilder: (context) => Column(
                      children: [
                        _buildCompanyLoader(),
                        const SizedBox(height: 12),
                        _buildCompanyLoader(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: _buildAddOrEditCompanyBtn(),
  );
}

  Widget _buildAddOrEditCompanyBtn() {
    return Obx(() {
      if (!_currentUserCompanyController
              .isLoadingCurrentUserCompanyController() &&
          (userCanAddCompany == true || userCanUpdateCompany == true)) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: FloatingActionButton(
            backgroundColor: Get.theme.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () {
              Get.to(
                userCanAddCompany
                    ? const AddCompanyScreen()
                    : const EditCompanyScreen(),
              );
            },
            shape: const CircleBorder(),
            child: userCanAddCompany
                ? const Icon(Icons.add)
                : const Icon(Icons.edit),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _buildCategoryLoader() {
    return Skeletonizer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: const Center(
          child: Text(
            '---------------',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyLoader() {
    return Skeletonizer(
      ignoreContainers: false,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: 140,
                  color: Colors.grey[300],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '----------',
                      style: Get.theme.primaryTextTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              '------------------------------------------',
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              '----------------------------------------------',
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      '-------------------',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const Text(
                  '------------------',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompany(
      CompaniesController companiesController, Company company) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: company.id ?? '',
                    child: CachedNetworkImage(
                      imageUrl: company.getCompanyLogoUrl() ?? '',
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Text(
                company.timeAgo,
                style: Get.theme.primaryTextTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            company.companyName ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                wordSpacing: -1,
                letterSpacing: -0.5),
          ),
          const SizedBox(
            height: 2,
          ),
          Text.rich(
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Activity : ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: company.activity!.trim() != ''
                      ? company.activity
                      : 'unknown',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            '${company.companyAddress1 ?? ''} , ${company.commune ?? ''} , ${company.wilaya ?? ''}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              wordSpacing: -1,
              letterSpacing: -0.5,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.domain,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: 140,
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      company.category != '' ? company.category! : 'unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  _makePhoneCall(company);
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  // color: Colors.red,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        '+213 77${company.companyPhone1 ?? company.companyPhone2 ?? ''}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final result = await Get.to(
                        () => CompanyDetailScreen(company: company));
                    if (result == true) {
                      setState(() {
                        userCanAddCompany = false;
                        userCanUpdateCompany = false;
                      });
                      getCurrentUserCompanyInfo();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade600,
                        width: 1,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            size: 18,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "See More",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
