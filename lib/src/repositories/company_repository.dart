import 'dart:convert';
import 'dart:io';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

const msisdn = '0542530498';
const baseUrl = 'http://192.168.43.115:8001/api/v1/$msisdn/user';
const companyId = '5';

class CompanyRepository {
  static Future<Map<String, dynamic>> getCompanies(
      {int? pageNumber, String? search, int? categoryId}) async {
    try {
      // var msisdn = await Preferences.getMobileNumber();
      var response = await Api.getRequest(
        '$baseUrl/clients',
        true,
        true,
        {
          'pageNumber': pageNumber,
          'search': search,
          'categoryId': categoryId,
        },
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>?> currentUserCompany() async {
    var response;
    try {
      // var msisdn = await Preferences.getMobileNumber();
      response = await Api.getRequest(
        '$baseUrl/clients/clientByCompanyId/$companyId',
        true,
        true,
        {},
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.response?.statusCode == 404) {
          return null;
        } else if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<bool> userCanAddCompany() async {
    try {
      var response = await Api.getRequest(
        '$baseUrl/clients/userCanAddClient/$companyId',
        true,
        true,
        {},
      );
      return json.decode(response)?['data'] ?? false;
    } catch (exception) {
      return false;
    }
  }

  static Future<bool> userCanUpdateCompany() async {
    try {
      var response = await Api.getRequest(
        '$baseUrl/clients/userCanUpdateClient/$companyId',
        true,
        true,
        {},
      );
      return json.decode(response)?['data'] ?? false;
    } catch (exception) {
      return false;
    }
  }

  static Future<bool> userCanReportCompany({required int clientId}) async {
    try {
      var response = await Api.getRequest(
        '$baseUrl/clients/userCanReportClient/$clientId/$companyId',
        true,
        true,
        {},
      );
      return json.decode(response)?['data'] ?? false;
    } catch (exception) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getActivityCategories() async {
    try {
      // var msisdn = await Preferences.getMobileNumber();
      var response =
          await Api.getRequest('$baseUrl/activityCategories', true, true, {});
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>> getActivityDomainsByCategoryId(
      int categoryId) async {
    try {
      // var msisdn = await Preferences.getMobileNumber();
      var response = await Api.getRequest(
        '$baseUrl/activityDomains/activityDomainsByCategoryId/${categoryId}',
        true,
        true,
        {},
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>> getWilayas() async {
    try {
      // var msisdn = await Preferences.getMobileNumber();
      var response = await Api.getRequest(
        '$baseUrl/wilayas',
        true,
        true,
        {},
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>> getCommunesByWilayaId(
      int wilayaId) async {
    try {
      var msisdn = await Preferences.getMobileNumber();
      var response = await Api.getRequest(
        '$baseUrl/communes/communesByWilayaId/${wilayaId}',
        true,
        true,
        {},
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>> addCompany({
    String? companyName,
    String? serviceType,
    String? subscriptionType,
    String? activity,
    int? activityCategoryId,
    int? activityDomainId,
    String? email,
    String? companyPhone1Extension,
    String? companyPhone1,
    String? companyPhone2Extension,
    String? companyPhone2,
    String? companyFax,
    int? wilayaId,
    int? communeId,
    String? companyAddress1,
    String? companyAddress2,
    String? website,
    String? description,
    XFile? image,
  }) async {
    Map<String, dynamic> params = {};
    try {
      // var msisdn = await Preferences.getMobileNumber();
      String? managerFullName = 'test one';
      String? managerPositionTitle = 'dev manager';
      String? managerPhone = '0542530498';
      var response = await Api.postRequest2(
        '$baseUrl/clients',
        true,
        true,
        {},
        {
          'companyId': companyId,
          'companyName': companyName,
          'serviceType': serviceType,
          'subscriptionType': subscriptionType,
          'activity': activity,
          'activityCategoryId': activityCategoryId,
          'activityDomainId': activityDomainId,
          'email': email,
          'companyPhone1': companyPhone1,
          'companyPhone1Extension': companyPhone1Extension,
          'companyPhone2': companyPhone2,
          'companyPhone2Extension': companyPhone2Extension,
          'companyFax': companyFax,
          'wilayaId': wilayaId,
          'communeId': communeId,
          'companyAddress1': companyAddress1,
          'companyAddress2': companyAddress2,
          'website': website,
          'managerFullName': managerFullName,
          'managerPositionTitle': managerPositionTitle,
          'managerPhone': managerPhone,
          'description': description,
          'logo': null,
          //  image,
        },
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>> updateCompany({
    String? companyName,
    String? serviceType,
    String? subscriptionType,
    String? activity,
    int? activityCategoryId,
    int? activityDomainId,
    String? email,
    String? companyPhone1Extension,
    String? companyPhone1,
    String? companyPhone2Extension,
    String? companyPhone2,
    String? companyFax,
    int? wilayaId,
    int? communeId,
    String? companyAddress1,
    String? companyAddress2,
    String? website,
    String? description,
    XFile? image,
  }) async {
    Map<String, dynamic> params = {};
    try {
      // var msisdn = await Preferences.getMobileNumber();
      String? managerFullName = 'test one';
      String? managerPositionTitle = 'dev manager';
      String? managerPhone = '0542530498';
      var response = await Api.postRequest2(
        '$baseUrl/clientChanges/$companyId',
        true,
        true,
        {},
        {
          'companyId': companyId,
          'companyName': companyName,
          'serviceType': serviceType,
          'subscriptionType': subscriptionType,
          'activity': activity,
          'activityCategoryId': activityCategoryId,
          'activityDomainId': activityDomainId,
          'email': email,
          'companyPhone1': companyPhone1,
          'companyPhone1Extension': companyPhone1Extension,
          'companyPhone2': companyPhone2,
          'companyPhone2Extension': companyPhone2Extension,
          'companyFax': companyFax,
          'wilayaId': wilayaId,
          'communeId': communeId,
          'companyAddress1': companyAddress1,
          'companyAddress2': companyAddress2,
          'website': website,
          'managerFullName': managerFullName,
          'managerPositionTitle': managerPositionTitle,
          'managerPhone': managerPhone,
          'description': description,
          'logo': null,
          //  image,
        },
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Future<Map<String, dynamic>> reportCompany({
    required int clientId,
    required String managerDescription,
  }) async {
    Map<String, dynamic> params = {};
    try {
      // var msisdn = await Preferences.getMobileNumber();
      String? managerFullName = 'test one';
      String? managerPositionTitle = 'dev manager';
      String? managerPhone = '0542530498';
      var response = await Api.postRequest2(
        '$baseUrl/clients/reportClient',
        true,
        true,
        {},
        {
          'clientId': clientId,
          'companyId': companyId,
          'managerFullName': managerFullName,
          'managerPositionTitle': managerPositionTitle,
          'managerPhone': managerPhone,
          'managerDescription': managerDescription
        },
      );
      return json.decode(response);
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }
}
