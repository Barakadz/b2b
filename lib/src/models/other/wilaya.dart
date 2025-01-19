class Wilaya {
  final int? id;
  final int? code;
  final String? name;

  const Wilaya({this.id, this.code, this.name});

  factory Wilaya.fromJson(Map<String, dynamic> json) {
    return Wilaya(
      id: json['id'] ?? 0,
      code: json['code'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
