import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';
import '../../../../App/Network/network_routes.dart';

abstract class IAuthNetworking {
  Future<dynamic> login(Map<String, dynamic> body);
  Future<dynamic> register(String role, Map<String, dynamic> body);
  Future<dynamic> verifyUser(String role, int id, Map<String, Map> body);
  Future<dynamic> forgetPassword(String mobile);
  Future<dynamic> verifyOTP(Map<String, dynamic> body);
  String verifyEndPoint(String role, int id);
}

class AuthNetworking implements IAuthNetworking {
  AuthNetworking(this.networking);
  late NetworkHelper networking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
  };
  @override
  Future<dynamic> login(Map<String, dynamic> body) async {
    try {
      final loginResponse = await networking.post(
        url: loginUrl,
        headers: headers,
        body: body,
      );
      return loginResponse.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 401) {
          throw UnAuthorizeException();
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> register(String role, Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: role + "/" + registerUrl,
        headers: headers,
        body: body,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> verifyUser(String role, int id, Map<String, Map> body) async {
    try {
      final response = await networking.post(
        url: verifyEndPoint(role, id),
        body: body,
        headers: headers,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  String verifyEndPoint(String role, int id) => "$role/$id/$verifyUserUrl";
  @override
  Future<dynamic> forgetPassword(String mobile) async {
    try {
      final response = await networking.post(
        url: forgetPassUrl,
        body: {"mobile": "+966" + mobile},
        headers: headers,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> verifyOTP(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: verifyOTPUrl,
        body: body,
        headers: headers,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }


}
