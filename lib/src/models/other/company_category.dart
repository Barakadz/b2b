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
