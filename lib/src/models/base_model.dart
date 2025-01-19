
class BaseModel  {

  final String? id;
  final String? type;

  const BaseModel({
    required this.id,
    required this.type,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
    );
  }
}