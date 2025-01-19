import 'dart:convert';
import 'dart:io';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/services/native/information_retriever.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:dio/dio.dart';

class FlexyRepository {
  static Future<Map<String, dynamic>> active(
      {String? packageCode, Map<String, dynamic>? args}) async {
    try {
      var body = {
        "data": {
          "id": packageCode,
          "type": "products",
          "meta": {
            "services": args,
          }
        }
      };
      var msisdn = await Preferences.getMobileNumber();
      var url = await InformationRetriever.getInfoUrl();
      var path = '/subscription-product';
      var response = await Api.postRequestAuthenticated(
          '$url/$msisdn$path', true, true, body);

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
