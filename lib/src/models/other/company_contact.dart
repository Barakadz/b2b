class CompanyContact {
  final int? id;
  final String? honorific;
  final String? firstName;
  final String? lastName;
  final String? position;
  final String? email;
  final String? phone1;
  final String? phone1Extension;
  final String? phone2;
  final String? phone2Extension;
  final String? fax;
  final int? clientId;
  final String? createdAt;
  final String? updatedAt;

  const CompanyContact({
    this.id,
    this.honorific,
    this.firstName,
    this.lastName,
    this.position,
    this.email,
    this.phone1,
    this.phone1Extension,
    this.phone2,
    this.phone2Extension,
    this.fax,
    this.clientId,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyContact.fromJson(Map<String, dynamic> json) {
    return CompanyContact(
      id: json['id'] ?? 0,
      honorific: json['honorific'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      position: json['position'] ?? '',
      email: json['email'] ?? '',
      phone1: json['phone1'] ?? '',
      phone1Extension: json['phone1Extension'] ?? '',
      phone2: json['phone2'] ?? '',
      phone2Extension: json['phone2Extension'] ?? '',
      fax: json['fax'] ?? '',
      clientId: json['clientId'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
