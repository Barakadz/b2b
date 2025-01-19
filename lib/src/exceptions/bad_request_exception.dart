
import 'package:dio/dio.dart';

class BadRequestException extends DioException {

  String? cause;
  RequestOptions? options;

  BadRequestException({this.cause, this.options})
      : super(requestOptions: options ?? RequestOptions());
}