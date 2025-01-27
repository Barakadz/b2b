import 'dart:io';
import 'package:business/src/assets/colors.dart';
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
  final AddCompanyController _controller = Get.put(AddCompanyController());
  
  int _currentStep = 0;

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
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
          controlsBuilder: (context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
            ElevatedButton(
            onPressed: _onStepContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.secondaryColor, // Red button
              foregroundColor: Colors.white, // White text
            ),
            child:(_currentStep==3)? const Text('Envoyer'): const Text('Suivant'),
          ),
          TextButton(
            
            onPressed: _onStepCancel,
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  },
        steps: [
          _buildLogoStep(),
          _buildCompanyInfoStep(),
          _buildContactStep(),
          _buildAddressStep(),
         ],
      ),
    );
  }
Step _buildLogoStep() {
  return Step(
    title: Text('Logo'),
    content: Column(
      children: [
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
                  child: Obx(() => _controller.image.value == null
                      ? Image.asset('assets/images/company.png', fit: BoxFit.cover)
                      : Image.file(
                          File(_controller.image.value!.path),
                          fit: BoxFit.cover,
                        )),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _controller.selectCompanyLogo,
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
        if (_controller.image.value == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Company logo is required',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    ),
    isActive: _currentStep >= 0,
    state: _currentStep > 0 ? StepState.complete : StepState.indexed,
  );
}

  Step _buildCompanyInfoStep() {
    return Step(
      title: Text('Company Info'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            child: Column(
              children: [
                _buildTextField(
                  label: 'Company Name',
                  icon: Icons.business,
                  onSaved: (value) => _controller.companyName.value = value!,
                  validator: (value) {
                    if (value!.isEmpty) return 'Company name is required';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  
                  label: 'Company Activity',
                  items: _controller.companyCategories,
                  onChanged: (value) {
                    _controller.selectedCategoryId.value = value!;
                    _controller.onChangeSelectedCategory();
                  },
                ),
          
               Obx(() {
            if (_controller.selectedCategoryId.value != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            _controller.isLoadingDomainList.value
                ? const CircularProgressIndicator()
                : _buildDropdown(
                    label: 'Domain Company',
                    items: _controller.companyDomains.isNotEmpty
                        ? _controller.companyDomains
                        : ['Aucun domaine disponible'],
                    onChanged: (value) {
                      _controller.selectedDomainId.value = value;
                    },
                  ),
          ],
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(height: 10,),
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
              onSaved: (value) => _controller.description.value = value ?? '',
            ),
          ),
              ],
            ),
          ),
        ),
      ),
      isActive: _currentStep >= 1,
      state: _currentStep > 1 ? StepState.complete : StepState.indexed,
    );
  }

  Step _buildContactStep() {
    return Step(
      title: Text('Contact'),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildTextField(
                label: 'Email',
                icon: Icons.email,
                onSaved: (value) => _controller.email.value = value!,
               /* validator: (value) {
                  if (value!.isEmpty  ) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },*/
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSaved: (value) => _controller.companyPhone1.value = value!,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Website',
                icon: Icons.language,
                onSaved: (value) => _controller.website.value = value!,
              ),
            ],
          ),
        ),
      ),
      isActive: _currentStep >= 2,
      state: _currentStep > 2 ? StepState.complete : StepState.indexed,
    );
  }

  Step _buildAddressStep() {
    return Step(
      title: Text('Address'),
      content: Column(
        children: [
          _buildDropdown(
            label: 'Wilaya',
            items: _controller.wilayas,
            onChanged: (value) {
              _controller.selectedWilayaId.value = value!;
              _controller.onChangeSelectedWilaya();
            },
          ),
               Obx(() {
            if (_controller.selectedWilayaId.value != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            _controller.isLoadingCommuneList.value
                ? const CircularProgressIndicator()
                :  _buildDropdown(
                    label: 'Commune',
                    items: _controller.communes,
                    onChanged: (value) {
                      _controller.selectedCommuneId.value = value!;
                    },
                  ),
          ],
              );
            }
            return const SizedBox.shrink();
          }),

 
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Address Line 1',
            icon: Icons.location_on,
            onSaved: (value) => _controller.companyAddress1.value = value!,
          ),
        ],
      ),
      isActive: _currentStep >= 3,
      state: _currentStep > 3 ? StepState.complete : StepState.indexed,
    );
  }

   void _onStepContinue() {
  switch (_currentStep) {
    case 0:
      // Logo step validation
      if (_controller.image.value == null) {
        Get.snackbar('Error', 'Please select a company logo',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      setState(() => _currentStep += 1);
      break;
    case 1:
      // Company Info step
      if (_controller.formKey.currentState!.validate()) {
        _controller.formKey.currentState!.save();
        setState(() => _currentStep += 1);
      }
      break;
    case 2:
      // Contact step
      if (_validateContactStep()) {
        setState(() => _currentStep += 1);
      }
      break;
    case 3:
      // Address step
      if (_validateAddressStep()) {
        setState(() => _currentStep += 1);
      }
      break;
    case 4:
      // Details step
      _submitForm();
      break;
  }
}

bool _validateContactStep() {
  bool isValid = true;

  // Email validation
 /* if (_controller.email.value.isEmpty ) {
    Get.snackbar('Error', 'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM);
    isValid = false;
  }
*/
  // Optional: Phone number validation if needed
  if (_controller.companyPhone1.value.isNotEmpty) {
    // Add specific phone number validation if required
    // For example, check length or format
  }

  return isValid;
}

bool _validateAddressStep() {
  bool isValid = true;

  // Wilaya selection validation
  if (_controller.selectedWilayaId.value == null) {
    Get.snackbar('Error', 'Please select a Wilaya',
        snackPosition: SnackPosition.BOTTOM);
    isValid = false;
  }

  // Commune selection validation
  if (_controller.selectedCommuneId.value == null) {
    Get.snackbar('Error', 'Please select a Commune',
        snackPosition: SnackPosition.BOTTOM);
    isValid = false;
  }

  // Address line validation (optional)
 /* if (_controller.companyAddress1.value.isEmpty) {
    Get.snackbar('Error', 'Please enter an address',
        snackPosition: SnackPosition.BOTTOM);
    isValid = false;
  }*/

  return isValid;
}
 /* void _onStepContinue() {
    final isLastStep = _currentStep == 4;
    if (isLastStep) {
      // Submit the form
      _submitForm();
    } else {
      setState(() => _currentStep += 1);
    }
  }*/

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  void _submitForm() async {
    Company? company = await _controller.onSubmitCompany();
    if (company != null) {
      Get.off(() => const CompaniesScreen());
    }
  }

  // Reusable TextField method
  Widget _buildTextField({
    required String label,
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

  // Reusable Dropdown method
  Widget _buildDropdown({
    required String label,
    required List<dynamic> items,
    required Function(int?) onChanged,
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
        validator: (value) => value == null ? 'Please select an option' : null,
      ),
    );
  }
}