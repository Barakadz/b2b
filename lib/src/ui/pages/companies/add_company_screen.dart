import 'dart:io';
import 'package:business/src/controllers/add_company_controller.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/ui/pages/companies/companies_screen.dart';
import 'package:business/src/ui/pages/companies/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final AddCompanyController addCompanyController =
      Get.put(AddCompanyController());
  @override
  void initState() {
    // PhoneInputFormatter.replacePhoneMask(
    //   countryCode: 'RU',
    //   newMask: '+0 (000) 000 00 00',
    // );
    // PhoneInputFormatter.addAlternativePhoneMasks(
    //   countryCode: 'BR',
    //   alternativeMasks: [
    //     '+00 (00) 0000-0000',
    //     '+(00) 00000',
    //     '+00 (00) 00-0000',
    //   ],
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Add Company',
            style: Get.theme.primaryTextTheme.bodyMedium
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: addCompanyController.formKey,
                child: Obx(
                  () {
                    return AbsorbPointer(
                      absorbing: addCompanyController.isLoadingPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '1.Company Logo :',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 100,
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
                                    child:
                                        addCompanyController.image.value == null
                                            ? Image.asset(
                                                'assets/images/company.png',
                                                fit: BoxFit.contain,
                                              )
                                            : Image.file(
                                                File(
                                                  addCompanyController
                                                      .image.value!.path,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CustomBtn(
                                  text: 'Change image',
                                  textColor: Colors.blue[700],
                                  backgroundColor: Colors.blue[50],
                                  height: 40,
                                  onTab: addCompanyController.selectCompanyLogo,
                                  isEnabled: true,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomBtn(
                                  text: 'Remove',
                                  textColor: Colors.red[700],
                                  backgroundColor: Colors.red[50],
                                  height: 40,
                                  onTab: addCompanyController.removeCompanyLogo,
                                  isEnabled: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '2.Company Info :',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                addCompanyController.companyName.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a company name';
                              }
                              if (GetUtils.isLengthGreaterThan(value, 255)) {
                                return 'Maximum characters allowed is 255';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Company Name',
                              hintText: 'Company Name',
                              prefixIcon: Icon(
                                Icons.business_center_rounded,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                addCompanyController.activity.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (GetUtils.isLengthGreaterThan(value, 255)) {
                                return 'Maximum characters allowed is 255';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Company Activity',
                              hintText: 'Company Activity',
                              prefixIcon: Icon(
                                Icons.local_activity,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<int>(
                            isExpanded: true,
                            decoration: textFieldDecoration(
                              labelText: 'Activity Category',
                              hintText: 'Activity Category',
                              prefixIcon: Icon(
                                Icons.donut_small_outlined,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            items: addCompanyController.companyCategories.map(
                              (category) {
                                return DropdownMenuItem<int>(
                                  value: category.id ?? 0,
                                  child: Text(
                                    category.name ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              addCompanyController.selectedCategoryId.value =
                                  value!;
                              addCompanyController.onChangeSelectedCategory();
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              addCompanyController.selectedCategoryId.value =
                                  value!;
                            },
                          ),
                          if (addCompanyController.selectedCategoryId.value !=
                                  null ||
                              addCompanyController.isLoading())
                            const SizedBox(
                              height: 16,
                            ),
                          if (addCompanyController.selectedCategoryId.value !=
                                  null ||
                              addCompanyController.isLoading())
                            DropdownButtonFormField<int>(
                              isExpanded: true,
                              key: addCompanyController.domainDropdownKey,
                              decoration: textFieldDecoration(
                                labelText: 'Category Domain',
                                hintText: 'Category Domain',
                                prefixIcon: Icon(
                                  Icons.domain,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              items: addCompanyController.companyDomains.map(
                                (domain) {
                                  return DropdownMenuItem<int>(
                                    value: domain.id,
                                    child: Text(
                                      domain.name ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                addCompanyController.selectedDomainId.value =
                                    value!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a domain';
                                }
                                return null;
                              },
                              onSaved: (value) => addCompanyController
                                  .selectedDomainId.value = value!,
                            ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            '3.Contact Info :',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                addCompanyController.email.value = value!,
                            validator: (value) {
                              if (value!.isEmpty || !GetUtils.isEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: ' Company Email',
                              hintText: 'Company Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (value) => addCompanyController
                                .companyPhone1.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (GetUtils.isLengthGreaterThan(value, 12)) {
                                return 'Please enter a phone number';
                              }
                              if (GetUtils.isLengthLessThan(value, 9)) {
                                return 'Please enter a phone number';
                              }
                              if (!GetUtils.isNumericOnly(value)) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Phone 1',
                              hintText: 'Phone 1',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (value) => addCompanyController
                                .companyPhone2.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (GetUtils.isLengthGreaterThan(value, 12)) {
                                return 'Please enter a phone number';
                              }
                              if (GetUtils.isLengthLessThan(value, 9)) {
                                return 'Please enter a phone number';
                              }
                              if (!GetUtils.isNumericOnly(value)) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Phone 2',
                              hintText: 'Phone 2',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            onSaved: (value) =>
                                addCompanyController.companyFax.value = value!,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.isEmpty ||
                                  GetUtils.isLengthGreaterThan(value, 12)) {
                                return 'Please enter a fax number';
                              }
                              if (!GetUtils.isNumericOnly(value)) {
                                return 'Please enter a fax number';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Fax',
                              hintText: 'Fax',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onSaved: (value) =>
                                addCompanyController.website.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (GetUtils.isLengthGreaterThan(value, 255)) {
                                return 'Maximum characters allowed is 255';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'WebSite',
                              hintText: 'WebSite',
                              prefixIcon: Icon(
                                Icons.satellite_alt_outlined,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            '4.Address Info :',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownButtonFormField<int>(
                            isExpanded: true,
                            decoration: textFieldDecoration(
                              labelText: 'Wilaya',
                              hintText: 'Wilaya',
                              prefixIcon: Icon(
                                Icons.place,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            items: addCompanyController.wilayas.map(
                              (wilaya) {
                                return DropdownMenuItem<int>(
                                  value: wilaya.id,
                                  child: Text(
                                    '${wilaya.code} ${wilaya.name}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              addCompanyController.selectedWilayaId.value =
                                  value!;
                              addCompanyController.onChangeSelectedWilaya();
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a wilaya';
                              }
                              return null;
                            },
                            onSaved: (value) => addCompanyController
                                .selectedWilayaId.value = value!,
                          ),
                          if (addCompanyController.selectedWilayaId.value !=
                                  null ||
                              addCompanyController.isLoading())
                            const SizedBox(
                              height: 16,
                            ),
                          if (addCompanyController.selectedWilayaId.value !=
                                  null ||
                              addCompanyController.isLoading())
                            DropdownButtonFormField<int>(
                              isExpanded: true,
                              key: addCompanyController.communeDropdownKey,
                              decoration: textFieldDecoration(
                                labelText: 'Commune',
                                hintText: 'Commune',
                                prefixIcon: Icon(
                                  Icons.place,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              items: addCompanyController.communes.map(
                                (commune) {
                                  return DropdownMenuItem<int>(
                                    value: commune.id,
                                    child: Text(
                                      commune.name ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                addCompanyController.selectedCommuneId.value =
                                    value!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a Commune';
                                }
                                return null;
                              },
                              onSaved: (value) => addCompanyController
                                  .selectedCommuneId.value = value!,
                            ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onSaved: (value) => addCompanyController
                                .companyAddress1.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (GetUtils.isLengthGreaterThan(value, 255)) {
                                return 'Maximum characters allowed is 255';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Company Address 1',
                              hintText: 'Company Address 1',
                              prefixIcon: Icon(
                                Icons.place,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            onSaved: (value) => addCompanyController
                                .companyAddress2.value = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (GetUtils.isLengthGreaterThan(value, 255)) {
                                return 'Maximum characters allowed is 255';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: textFieldDecoration(
                              labelText: 'Company Address 2',
                              hintText: 'Company Address 2',
                              prefixIcon: Icon(
                                Icons.place,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            '5.Details :',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height:
                                100, // Set the height to mimic a textarea with 2 lines
                            child: TextFormField(
                              onSaved: (value) => addCompanyController
                                  .description.value = value!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return null;
                                }
                                if (GetUtils.isLengthGreaterThan(value, 500)) {
                                  return 'Maximum characters allowed is 500';
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 16.0,
                                ),
                                hintStyle:
                                    Get.theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15,
                                  color: Colors.black26,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.0,
                                  ),
                                ),
                                hintText: 'Description',
                              ),
                              maxLines: null,
                              expands:
                                  true, // Allow the TextField to expand vertically
                              textAlignVertical: TextAlignVertical
                                  .top, // Start the text from the top
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            color: Colors.black,
                          ),
                          CustomBtn(
                            text: 'Save changes',
                            textColor: Colors.white,
                            backgroundColor: Colors.blueGrey[700],
                            height: 45,
                            onTab: () async {
                              Company? company =
                                  await addCompanyController.onSubmitCompany();
                              if (company != null) {
                                Get.off(() => const CompaniesScreen());
                              }
                            },
                            isEnabled: !addCompanyController.isLoadingPage(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Obx(
            () {
              if (addCompanyController.isLoadingPage()) {
                return Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Get.theme.primaryColor,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  InputDecoration textFieldDecoration({
    required String labelText,
    required String hintText,
    required Icon prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey.shade600, // Change the color here
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade700,
          width: 1,
        ),
      ),
      // errorText: 'zzzzz',
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade800,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade800,
          width: 1,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 16.0,
      ),
      hintStyle: Get.theme.textTheme.bodyMedium
          ?.copyWith(fontSize: 15, color: Colors.black26),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),
      hintText: hintText,
      prefixIcon: prefixIcon,
    );
  }
}
