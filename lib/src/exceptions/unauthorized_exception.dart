
import 'package:dio/dio.dart';

import 'package:business/src/models/response/pair.dart';

class UnauthorizedException extends DioException {

    Pair? status;
    RequestOptions? options;

    UnauthorizedException({this.status, this.options})
        : super(requestOptions: options ?? RequestOptions());
}