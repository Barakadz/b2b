class Commune {
  final int? id;
  final String? name;
  final int? wilayaId;

  const Commune({this.id, this.name, this.wilayaId});

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      wilayaId: json['wilayaId'] ?? 0,
    );
  }
}
