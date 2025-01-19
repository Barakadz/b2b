import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:business/src/models/response/pair.dart';
import 'package:business/src/exceptions/bad_request_exception.dart';
import 'package:business/src/exceptions/unauthorized_exception.dart';

import 'package:business/src/services/native/preferences.dart';
import 'package:business/src/repositories/user_repository.dart';

class ApiInterceptor extends Interceptor {
  bool refresh;
  final Dio dio;
  final bool authenticate;

  ApiInterceptor(this.dio, this.refresh, this.authenticate);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //Add authorization header if requested
    if (authenticate) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader:
            "${await Preferences.getTokenType()} ${await Preferences.getAccessToken()}"
      });
    }
    print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
    print(options.headers);
    print('---AAAAA ${await Preferences.getAccessToken()}');

    //Return
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      var error = jsonDecode(err.response?.data);
      if (error["fault"] is Map<String, dynamic>) {
        error = error["fault"];
        if (error["code"] == 900902) {
          //throw new UnauthorizedException(JobStatus.error_unauthorized);
          return handler.next(UnauthorizedException(
              status: Pair(Status.error, Reason.notAuthorized)));
        }
      }

      //Check for the error format
      if (error["error"] is Map<String, dynamic>) {
        error = error["error"];
      }
      //User not exist
      if (error["status"] == 404 || error["status"] == 403) {
        return handler.next(
            UnauthorizedException(status: Pair(Status.error, Reason.notExist)));
      }
      //User blacklisted
      else if (error["status"] == 423) {
        return handler.next(UnauthorizedException(
            status: Pair(Status.error, Reason.notAllowed)));
      }
      //Not illegible
      else if (error["status"] == 401) {
        return handler.next(UnauthorizedException(
            status: Pair(Status.error, Reason.notIllegible)));
      }
      //Not illegible
      else if (error["status"] == 401) {
        return handler.next(UnauthorizedException(
            status: Pair(Status.error, Reason.notAuthorized)));
      }
      // Refresh the access token
      else if (refresh && err.response?.statusCode == 401) {
        //Avoid refresh token for the next iteration
        refresh = false;

        //Manage exception on refresh
        var refreshed = await UserRepository.refreshToken();

        if (refreshed) {
          // Resend request with the updated header
          return handler.resolve(await dio.fetch(err.requestOptions));
        } else {
          // Raise the same error
          return handler.next(BadRequestException());
        }
      }
    } catch (ex) {}
    return handler.next(err);
  }
}
