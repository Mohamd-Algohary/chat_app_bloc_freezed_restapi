// ignore_for_file: constant_identifier_names, constant_pattern_never_matches_value_type

import 'package:dio/dio.dart';

import '/presentation/resources/strings_manager.dart';
import '../../domain/model/model.dart';

class ErrorHandler implements Exception {
  late final Failure failure;

  ErrorHandler.handle(dynamic err) {
    if (err is DioException) {
      // dio Exception so it's an error from API response or from dio it self
      failure = _handelError(err);
    } else {
      // unknown error
      failure = DataSource.UNKNOWN.getFailure();
    }
  }

  //!get Firebase Auth error type
  Failure _handelError(DioException exception) {
    switch (exception.response!.data["error"]["message"]) {
      case 'weak-password':
        return Failure(01, 'The password provided is too weak.');
      case 'EMAIL_EXISTS':
        return Failure(
            02, 'The email address is already in use by another account.');
      case 'EMAIL_NOT_FOUND':
        return Failure(03, 'No user found for that email.');
      case 'INVALID_PASSWORD':
        return Failure(04,
            'The password is invalid or the user does not have a password.');
      case 'USER_DISABLED':
        return Failure(
            05, 'The user account has been disabled by an administrator.');
      default:
        return _handelServerError(exception);
    }
  }

  Failure _handelServerError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.unknown:
        return DataSource.UNKNOWN.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.badResponse:
        return DataSource.BAD_REQUEST.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.UNAUTHORIZED.getFailure();
      default:
        return DataSource.UNKNOWN.getFailure();
    }
  }
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.UNKNOWN:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      default:
        return Failure(0, "");
    }
  }
}

enum DataSource {
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CANCEL,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKNOWN
}

class ResponseCode {
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int FORBIDDEN =
      403; // failure, user is not authorized(you don't have permission,Don't try again)
  static const int UNAUTHORIZED =
      401; // failure, user is not authorized(try again)
  static const int NOT_FOUND =
      404; // failure, ApI url is not correct or not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side

  //local status code
  static const int CONNECT_TIMEOUT = -1; //
  static const int RECIEVE_TIMEOUT = -2; //
  static const int SEND_TIMEOUT = -3; //
  static const int CANCEL = -4; //
  static const int CACHE_ERROR = -5; //
  static const int NO_INTERNET_CONNECTION = -6; //
  static const int UNKNOWN = -7; //
}

class ResponseMessage {
  static const String BAD_REQUEST =
      StringsManager.badRequestRrror; // failure, API rejected request
  static const String FORBIDDEN = StringsManager
      .forbiddenError; // failure, user is not authorized(you don't have permission,Don't try again)
  static const String UNAUTHORIZED = StringsManager
      .unauthorizedError; // failure, user is not authorized(try again)
  static const String NOT_FOUND = StringsManager
      .notFoundError; // failure, ApI url is not correct or not found
  static const String INTERNAL_SERVER_ERROR =
      StringsManager.internalServerError; // failure, crash in server side

  //local status code
  static const String CONNECT_TIMEOUT = StringsManager.timeoutError; //
  static const String RECIEVE_TIMEOUT = StringsManager.timeoutError; //
  static const String SEND_TIMEOUT = StringsManager.timeoutError; //
  static const String CANCEL = StringsManager.cancel; //
  static const String CACHE_ERROR = StringsManager.cacheError; //
  static const String NO_INTERNET_CONNECTION =
      StringsManager.noInternetConnection; //
  static const String UNKNOWN = StringsManager.defaultError; //
}
