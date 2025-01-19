import 'package:business/src/models/other/company_contact.dart';
import 'package:intl/intl.dart';

class Company {
  final int? id;
  final int? companyId;
  final String? serviceType;
  final String? companyName;
  final String? companyPhone1;
  final String? companyPhone1Extension;
  final String? companyPhone2;
  final String? companyPhone2Extension;
  final String? companyFax;
  final String? companyAddress1;
  final String? companyAddress2;
  final int? communeId;
  final String? commune;
  final int? wilayaId;
  final String? wilaya;
  final String? activity;
  final int? activityDomainId;
  final String? domain;
  final int? activityCategoryId;
  final String? category;
  final String? website;
  final String? email;
  final String? status;
  final String? updateStatus;
  final String? changeStatusReason;
  final String? subscriptionType;
  final int? authorId;
  final String? managerFullName;
  final String? managerPositionTitle;
  final String? managerPhone;
  final String? description;
  final String? companyLogo;
  final String? createdAt;
  final String? updatedAt;
  final List<CompanyContact>? contacts;

  const Company({
    this.id,
    this.companyId,
    this.serviceType,
    this.companyName,
    this.companyPhone1Extension,
    this.companyPhone1,
    this.companyPhone2Extension,
    this.companyPhone2,
    this.companyFax,
    this.companyAddress1,
    this.companyAddress2,
    this.communeId,
    this.commune,
    this.wilayaId,
    this.wilaya,
    this.activity,
    this.activityDomainId,
    this.domain,
    this.activityCategoryId,
    this.category,
    this.website,
    this.email,
    this.status,
    this.updateStatus,
    this.changeStatusReason,
    this.subscriptionType,
    this.authorId,
    this.managerFullName,
    this.managerPositionTitle,
    this.managerPhone,
    this.description,
    this.companyLogo,
    this.createdAt,
    this.updatedAt,
    this.contacts,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      companyId: json['companyId'] ?? 0,
      serviceType: json['serviceType'] ?? '',
      companyName: json['companyName'] ?? '',
      companyPhone1: json['companyPhone1'] ?? '',
      companyPhone1Extension: json['companyPhone1Extension'] ?? '',
      companyPhone2: json['companyPhone2'] ?? '',
      companyPhone2Extension: json['companyPhone2Extension'] ?? '',
      companyFax: json['companyFax'] ?? '',
      companyAddress1: json['companyAddress1'] ?? '',
      companyAddress2: json['companyAddress2'] ?? '',
      communeId: json['communeId'] ?? 0,
      commune: json['commune'] ?? '',
      wilayaId: json['wilayaId'] ?? 0,
      wilaya: json['wilaya'] ?? '',
      activity: json['activity'] ?? '',
      activityDomainId: json['activityDomainId'] ?? 0,
      domain: json['domain'] ?? '',
      activityCategoryId: json['activityCategoryId'] ?? 0,
      category: json['category'] ?? '',
      website: json['website'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      updateStatus: json['updateStatus'] ?? '',
      changeStatusReason: json['changeStatusReason'] ?? '',
      subscriptionType: json['subscriptionType'] ?? '',
      authorId: json['authorId'] ?? 0,
      managerFullName: json['managerFullName'] ?? '',
      managerPositionTitle: json['managerPositionTitle'] ?? '',
      managerPhone: json['managerPhone'] ?? '',
      description: json['description'] ?? '',
      companyLogo: json['companyLogo'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((contactJson) => CompanyContact.fromJson(contactJson))
          .toList(),
    );
  }

  get timeAgo {
    if (createdAt == null || createdAt == '') {
      return 'unknown';
    }
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(createdAt!, true).toLocal();
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
    }
  }

  getCompanyLogoUrl() {
    return 'http://192.168.43.115:8001/$companyLogo';
  }
}
