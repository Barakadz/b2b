import 'dart:convert';
import 'dart:io';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/other/epayment.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/services/native/information_retriever.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:dio/dio.dart';

class InvoiceRepository {
  static Future<Map<String, dynamic>> payInvoice(
      {Epayment? epaymentModel}) async {
    try {
      var msisdn = await Preferences.getMobileNumber();
      var url = await InformationRetriever.getP();
      //if (epaymentModel == null) throw DataFormatException('INVALID_VALUE');
      print('INVOICE:::Not null');
      epaymentModel!.msisdn = msisdn;
      Map<String, dynamic> body = epaymentModel.toJson();
      print('INVOICE:::${body.toString()}');
      var response =
          await Api.postRequestAuthenticated('$url$msisdn', true, true, body);
      print('INVOICE:::${response.toString()}');
      return json.decode(response);
    } catch (exception) {
      print(exception.toString());
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
