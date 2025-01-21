import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/exceptions/not_found_exception.dart';
import 'package:business/src/exceptions/bad_request_exception.dart';
import 'package:business/src/exceptions/unauthorized_exception.dart';
import 'package:business/src/services/api/api_interceptor.dart';
import 'package:business/src/services/native/information_retriever.dart';

class Api {
  static String msisdnKey = "msisdn";
  static String clientKey = "client_id";
  static String scopeKey = "scope";

  static String grantKey = "grant_type";
  static String secretKey = "client_secret";
  static String numberKey = "mobileNumber";
  static String otpKey = "otp";

  static String refreshKey = "refresh_token";

  static String includeKey = "include";
  static String connectedVal = "connected-products";
  static String subsTypeVal = "subscription-types";
  static String illegibilityVal = "subscription-type-illegibility";

  static String flashProductsVal = "flash-products";
  static String surpriseVal = "surprise-products";
  static String subscriptionsVal = "subscription-history";

  static String billInfoVal = "bill-info";
  static String shakeWinVal = "shake-products";
  static String flexyHistoryVal = "flexy-history";
  static String flexyHistoryVaL2 = "Flexy-history";
  static String servicesVal = "available-services";
  static String supplementaryVal = "supplementary-informations";

  static Future<dynamic> getRequest(String url, bool refresh, bool authenticate,
      Map<String, dynamic>? params) async {
    //Get dio instance
    final dio = await getDio();
    dio.interceptors.add(LogInterceptor(responseBody: true));

    //Add interceptor
    dio.interceptors.add(ApiInterceptor(dio, refresh, authenticate));

    //Send request

    print("url is ================================================================>$url");
    print("queryParameters is ================================================================>$params");
    print("options is ================================================================>${Options(responseType: ResponseType.plain)}");
    final response = await dio
        .get(
          url,
          queryParameters: params,
          options: Options(responseType: ResponseType.plain),
        )
        .timeout(const Duration(seconds: 10));
    return process(response);
  }

  static Future<dynamic> postRequest2(
      String url,
      bool refresh,
      bool authenticate,
      Map<String, dynamic>? params,
      Map<String, dynamic>? body) async {
    //Get dio instance
    final dio = await getDio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    //Add interceptor
    dio.interceptors.add(ApiInterceptor(dio, refresh, authenticate));
    //Send request
    final response = await dio
        .post(
          url,
          queryParameters: params,
          data: body,
          options: Options(responseType: ResponseType.plain),
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == HttpStatus.created) {
      return response.data;
    }
    return process(response);
  }

  static Future<dynamic> postRequest(
      String url, Map<String, dynamic> params, Map<String, dynamic> headers,
      [String body = ""]) async {
    //Get dio instance
    final dio = await getDio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    //Send request
    final response = await dio.post(
      url,
      queryParameters: params,
      options: Options(responseType: ResponseType.plain, headers: headers),
    );

    //Process the response
    return process(response);
  }

  static Future<dynamic> postRequestAuthenticated(String url, bool refresh,
      bool authenticate, Map<String, dynamic> body) async {
    //Get dio instance
    final dio = await getDio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    //Add interceptor
    dio.interceptors.add(ApiInterceptor(dio, refresh, authenticate));
    /*dio.options.headers = {
      HttpHeaders.authorizationHeader:
          "${await Preferences.getTokenType()} ${await Preferences.getAccessToken()}",
      HttpHeaders.contentTypeHeader: "application/json"
    };*/

    //Send request
    final response = await dio.post(url, data: body);

    //Process the response
    return process(response);
  }

  static Future<Dio> getDio() async {
    var baseOptions = BaseOptions(
      baseUrl: await InformationRetriever.getBaseUrl(),
      responseType: ResponseType.plain,
    );
    return Dio(baseOptions);
  }

  static dynamic process(Response<dynamic> response) {
    try {
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        //Get error body
        var error = jsonDecode(response.data);

        //Check error
        if (response.statusCode == HttpStatus.unauthorized) {
          //User not exist
          if (error["status"] == 404) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.notFound));
          }
          //User canceled
          else if (error["status"] == 403) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.cancelled));
          }
          //User blacklisted
          else if (error["status"] == 423) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.blacklisted));
          }

          //Not illegible
          else if (error["status"] == 401) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.notAllowed));
          }

          //Not authorized generic error
          else {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.notAllowed));
          }
        } else if (response.statusCode == HttpStatus.badRequest) {
          // Incorrect PIN code
          if (error["status"] == 412) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.incorrect));
          } else {
            throw BadRequestException();
          }
        } else if (response.statusCode == HttpStatus.forbidden ||
            response.statusCode == HttpStatus.serviceUnavailable) {
          //Invalid code
          if (error["status"] == 417) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.incorrect));
          }
          // Code already used by same number
          else if (error["status"] == 201) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.used));
          }
          // Code already used by another number
          else if (error["status"] == 208) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.stolen));
          }
          // Not enough balance
          else if (error["status"] == 402) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.noBalance));
          }
          // Account blocked
          else if (error["status"] == 421) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.cancelled));
          }
          // Incorrect PIN code
          else if (error["status"] == 412) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.incorrect));
          }
          // Max try reached
          else if (error["status"] == 429) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.maxReached));
          }
          //Not authorized
          else if (error["status"] == 406) {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.notAllowed));
          }
          //Other error
          else {
            throw UnauthorizedException(
                status: Pair(Status.error, Reason.unknown));
          }
        } else if (response.statusCode == HttpStatus.notFound) {
          throw NotFoundException();
        } else {
          throw UnauthorizedException(
              status: Pair(Status.error, Reason.unknown));
        }
      }
    } catch (exception) {
      throw UnauthorizedException(status: Pair(Status.error, Reason.unknown));
    }
  }
}
