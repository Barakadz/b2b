class CompanyDomain {
  final int? id;
  final String? code;
  final String? name;
  final String? category;
  final int? categoryId;

  const CompanyDomain(
      {this.id, this.code, this.name, this.category, this.categoryId});

  factory CompanyDomain.fromJson(Map<String, dynamic> json) {
    return CompanyDomain(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      categoryId: json['categoryId'] ?? 0,
    );
  }
}
