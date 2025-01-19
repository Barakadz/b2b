class ApiExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  ApiExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApiExceptions {
  FetchDataException([String? message]) : super(message, '');
}

class BadRequestException extends ApiExceptions {
  BadRequestException([message]) : super(message, '');
}

class NotFoundException extends ApiExceptions {
  NotFoundException([message]) : super(message, '');
}

class UnauthorizedException extends ApiExceptions {
  UnauthorizedException([message]) : super(message, '');
}

class ForbiddenException extends ApiExceptions {
  ForbiddenException([message]) : super(message, '');
}

class NoDataException extends ApiExceptions {
  NoDataException([message]) : super(message, '');
}

class DataTimeoutException extends ApiExceptions {
  DataTimeoutException([message]) : super(message, '');
}

class DataFormatException extends ApiExceptions {
  DataFormatException([message]) : super(message, '');
}
