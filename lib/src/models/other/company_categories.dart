import 'package:business/src/models/other/company_category.dart';

class CompanyCategories {
  List<CompanyCategory>? data;
  CompanyCategories({this.data});

  factory CompanyCategories.fromJson(Map<String, dynamic> json) {
    
  print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
        print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("Data=====>${((json['result'] ?? []) as List)
            .map((e) => CompanyCategory.fromJson(e))
            .toList()}");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");
    print("µµµµµµµµµµµµµµµµµµµµµµµµµµ");

    return CompanyCategories(
        data: ((json['result'] ?? []) as List)
            .map((e) => CompanyCategory.fromJson(e))
            .toList());
  }
}
