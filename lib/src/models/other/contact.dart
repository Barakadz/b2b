class ContactModel {
  final String? name;
  final String? number;
  const ContactModel({this.name, this.number});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['attributes']['name'],
      number: json['attributes']['number'],
    );
  }
}
