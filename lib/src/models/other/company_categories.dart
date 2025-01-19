import 'package:business/src/models/other/company_category.dart';

class CompanyCategories {
  List<CompanyCategory>? data;
  CompanyCategories({this.data});

  factory CompanyCategories.fromJson(Map<String, dynamic> json) {
    return CompanyCategories(
        data: ((json['data'] ?? []) as List)
            .map((e) => CompanyCategory.fromJson(e))
            .toList());
  }
}
