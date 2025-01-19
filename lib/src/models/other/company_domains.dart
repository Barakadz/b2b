import 'package:business/src/models/other/company_domain.dart';

class CompanyDomains {
  List<CompanyDomain>? data;
  CompanyDomains({this.data});

  factory CompanyDomains.fromJson(Map<String, dynamic> json) {
    return CompanyDomains(
        data: ((json['data'] ?? []) as List)
            .map((e) => CompanyDomain.fromJson(e))
            .toList());
  }
}
