import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../Errors/exceptions.dart';
import '../GlobalWidgets/loading_dialog.dart';
import '../constants/strings.dart';

class APIHandler {
  void handleRequestException(Object e) {
    if (e is SocketException) {
      throw const SocketException(serverErrorMessage);
    }
    if (e is TimeoutException) {
      throw TimeoutException(serverErrorMessage);
    }
  }

  Response<dynamic> handleResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response;
      case 500:
        throw ServerException();
      case 401:
        throw UnAuthorizeException();
      case 422:
        throw BadEntitesException;
      case 404:
        throw NotFoundException();

      default:
        throw UnCaughtException();
    }
  }

  static void handleExceptions(e) {
    switch (e) {
      case ServerException:
        LoadingDialog.showSimpleToast(e.message);
        break;
      case ConnectivityException:
        LoadingDialog.showSimpleToast(noConnectionMessage);
        break;
      case UnAuthorizeException:
        LoadingDialog.showSimpleToast(e.message);
        break;
      case BadEntitesException:
        LoadingDialog.showSimpleToast(e.message);
        break;
      case NotFoundException:
        LoadingDialog.showSimpleToast(e.message);
        break;

      default:
        LoadingDialog.showSimpleToast(e.message);
        break;
    }
  }
}
