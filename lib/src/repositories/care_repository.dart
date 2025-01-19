import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:business/src/controllers/base_controller.dart';

import 'package:business/src/models/response/pair.dart';
import 'package:business/src/models/response/ussd_response.dart';

import 'package:business/src/exceptions/bad_request_exception.dart';
import 'package:business/src/exceptions/unauthorized_exception.dart';

import 'package:business/src/services/api/api.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:business/src/services/native/information_retriever.dart';

class CareRepository {
  static Future<UssdResponse?> getFleet(BaseController? presenter) async {
    try {
      //Check number
      var msisdn = await Preferences.getMobileNumber();
      if (msisdn == null) {
        presenter != null
            ? presenter.updateStatus(Pair(Status.error, Reason.notAllowed))
            : throw BadRequestException();
      }

      final response = await Api.getRequest(
          "${await InformationRetriever.getCareUrl()}/$msisdn",
          true,
          true,
          {"type": "fleet"});
      return UssdResponse.fromJson(jsonDecode(response));
    } catch (e) {
      if (e is BadRequestException || e is UnauthorizedException) {
        presenter != null
            ? presenter.updateStatus(Pair(Status.error, Reason.notFound))
            : throw BadRequestException();
      } else if (e is DioException) {
        if (e.error is SocketException || e.error is TimeoutException) {
          presenter != null
              ? presenter.updateStatus(Pair(Status.error, Reason.network))
              : throw SocketException(e.message ?? "");
        } else {
          presenter != null
              ? presenter.updateStatus(Pair(Status.error, Reason.unknown))
              : throw Exception();
        }
      } else {
        presenter != null
            ? presenter.updateStatus(Pair(Status.error, Reason.unknown))
            : throw Exception();
      }
      return null;
    }
  }

  static Future<UssdResponse?> getFleetMember(
      BaseController? presenter, String? subscriptionId) async {
    try {
      //Check number
      var msisdn = await Preferences.getMobileNumber();
      if (msisdn == null) {
        presenter != null
            ? presenter.updateStatus(Pair(Status.error, Reason.notAllowed))
            : throw BadRequestException();
      }

      final response = await Api.getRequest(
          "${await InformationRetriever.getCareUrl()}/$msisdn",
          true,
          true,
          {"type": "fleet_member", "code": subscriptionId});
      return UssdResponse.fromJson(jsonDecode(response));
    } catch (e) {
      if (e is BadRequestException || e is UnauthorizedException) {
        presenter != null
            ? presenter.updateStatus(Pair(Status.error, Reason.notFound))
            : throw BadRequestException();
      } else if (e is DioException) {
        if (e.error is SocketException || e.error is TimeoutException) {
          presenter != null
              ? presenter.updateStatus(Pair(Status.error, Reason.network))
              : throw SocketException(e.message ?? "");
        } else {
          presenter != null
              ? presenter.updateStatus(Pair(Status.error, Reason.unknown))
              : throw Exception();
        }
      } else {
        presenter != null
            ? presenter.updateStatus(Pair(Status.error, Reason.unknown))
            : throw Exception();
      }
      return null;
    }
  }
}
