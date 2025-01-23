import 'dart:io';
import 'package:business/src/controllers/add_company_controller.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/ui/pages/companies/companies_screen.dart';
import 'package:business/src/ui/pages/companies/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final AddCompanyController addCompanyController = Get.put(AddCompanyController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Create New Company',
          style: Get.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[50],
            child: SingleChildScrollView(
              child: Form(
                key: addCompanyController.formKey,
                child: Obx(() {
                  return AbsorbPointer(
                    absorbing: addCompanyController.isLoadingPage(),
                    child: Column(
                      children: [
                        _buildHeaderSection(),
                        _buildCompanyInfoSection(),
                        _buildContactSection(),
                        _buildAddressSection(),
                        _buildDetailsSection(),
                        _buildSubmitButton(),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(0.05),
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company Logo',
            style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Center(
            child: Stack(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: addCompanyController.image.value == null
                        ? Image.asset(
                            'assets/images/company.png',
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(addCompanyController.image.value!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: addCompanyController.selectCompanyLogo,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyInfoSection() {
    return _buildSection(
      'Company Information',
      [
        _buildTextField(
          label: 'Company Name',
          hint: 'Enter company name',
          icon: Icons.business,
          onSaved: (value) => addCompanyController.companyName.value = value!,
          validator: (value) {
            if (value!.isEmpty) return 'Company name is required';
            if (GetUtils.isLengthGreaterThan(value, 255)) {
              return 'Maximum 255 characters allowed';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Company Activity',
          hint: 'Enter company activity',
          icon: Icons.work,
          onSaved: (value) => addCompanyController.activity.value = value!,
        ),
        const SizedBox(height: 16),
        _buildDropdown(
          label: 'Activity Category',
          items: addCompanyController.companyCategories,
          onChanged: (value) {
            addCompanyController.selectedCategoryId.value = value!;
            addCompanyController.onChangeSelectedCategory();
          },
          validator: (value) {
            if (value == null) return 'Please select a category';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return _buildSection(
      'Contact Information',
      [
        _buildTextField(
          label: 'Email',
          hint: 'company@example.com',
          icon: Icons.email,
          onSaved: (value) => addCompanyController.email.value = value!,
          validator: (value) {
            if (value!.isEmpty || !GetUtils.isEmail(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Phone',
          hint: 'Enter phone number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onSaved: (value) => addCompanyController.companyPhone1.value = value!,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Website',
          hint: 'www.company.com',
          icon: Icons.language,
          onSaved: (value) => addCompanyController.website.value = value!,
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return _buildSection(
      'Address Information',
      [
        _buildDropdown(
          label: 'Wilaya',
          items: addCompanyController.wilayas,
          onChanged: (value) {
            addCompanyController.selectedWilayaId.value = value!;
            addCompanyController.onChangeSelectedWilaya();
          },
          validator: (value) {
            if (value == null) return 'Please select a wilaya';
            return null;
          },
        ),
        if (addCompanyController.selectedWilayaId.value != null) ...[
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Commune',
            items: addCompanyController.communes,
            onChanged: (value) {
              addCompanyController.selectedCommuneId.value = value!;
            },
            validator: (value) {
              if (value == null) return 'Please select a commune';
              return null;
            },
          ),
        ],
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Address Line 1',
          hint: 'Enter primary address',
          icon: Icons.location_on,
          onSaved: (value) => addCompanyController.companyAddress1.value = value!,
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return _buildSection(
      'Additional Details',
      [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter company description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onSaved: (value) => addCompanyController.description.value = value ?? '',
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.theme.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required Function(String?) onSaved,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Get.theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List items,
    required Function(int?) onChanged,
    required String? Function(int?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((item) {
          return DropdownMenuItem<int>(
            value: item.id,
            child: Text(item.name ?? ''),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: () async {
          if (!addCompanyController.isLoadingPage()) {
            Company? company = await addCompanyController.onSubmitCompany();
            if (company != null) {
              Get.off(() => const CompaniesScreen());
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          'Create Company',
          style: Get.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Obx(
      () {
        if (addCompanyController.isLoadingPage()) {
          return Container(
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Get.theme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Creating company...',
                      style: Get.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}