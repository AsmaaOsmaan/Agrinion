import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_helper.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_routes.dart';

abstract class IProfileNetworking {
  Future<dynamic> updateCommercialProfile(Map<String, dynamic> body);
  Future<dynamic> getProfile();
  Future<dynamic> resetPassword(Map<String, dynamic> body);
  Future<dynamic> setPassword(Map<String, dynamic> body);
}

class ProfileNetworking implements IProfileNetworking {
  final NetworkHelper _helper;

  ProfileNetworking(this._helper);


  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };


  @override
  Future<dynamic> updateCommercialProfile(Map<String, dynamic> body) async {
    final response = await _helper.patchMedia(
      url: profileUrl,
      headers: headers(),
      body: body,
    );
    return response;
  }

  @override
  Future<dynamic> resetPassword(Map<String, dynamic> body) async {
    try {
      final response = await _helper.post(
        url: resetPasswordUrl,
        headers: headers(),
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
  Future<dynamic> setPassword(Map<String, dynamic> body) async {
    try {
      final response = await _helper.post(
        url: setPasswordUrl,
        headers: headers(),
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
  Future getProfile() async {
    final response = await _helper.get(
      url: profileUrl,
      headers: headers(),
    );
    return response.data;
  }
}
