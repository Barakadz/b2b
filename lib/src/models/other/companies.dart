import 'package:business/src/models/other/company.dart';

class CompaniesResponse {
  int? currentPage;
  int? lastPage;
  List<Company>? data;
  int? total;

  CompaniesResponse({this.currentPage, this.lastPage, this.total, this.data});

  factory CompaniesResponse.fromJson(Map<String, dynamic> json) {
    var meta = json['result']['meta'] ?? {};

    return CompaniesResponse(
        currentPage: meta['current_page'] ?? 0,
        lastPage: meta['last_page'] ?? 0,
        total: meta['total'] ?? 0,
        data: ((json['result']['data'] ?? []) as List)
            .map((e) => Company.fromJson(e))
            .toList());
  }
}
