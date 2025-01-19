class Flag {
  final int? id;
  final int? clientId;
  final int? companyId;
  final String? managerFullName;
  final String? managerPositionTitle;
  final String? managerPhone;

  const Flag({
    this.id,
    this.clientId,
    this.companyId,
    this.managerFullName,
    this.managerPositionTitle,
    this.managerPhone,
  });

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(
      id: json['id'] ?? 0,
      clientId: json['clientId'] ?? 0,
      companyId: json['companyId'] ?? 0,
      managerFullName: json['managerFullName'] ?? '',
      managerPositionTitle: json['managerPositionTitle'] ?? '',
      managerPhone: json['managerPhone'] ?? '',
    );
  }
}
