import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../App/Utilities/utils.dart';

abstract class IUserManagementNetworking {
  Future<dynamic> getAllCommercialProfiles();
  Future<dynamic> getAllMerchantCommercialProfiles();
  Future<dynamic> getMerchantsCommercialProfiles();
  Future<dynamic> getFarmersCommercialProfiles();
  Future<dynamic> addCommercialProfile(Map<String, dynamic> body, String type);
  Future<dynamic> editCommercialProfile(Map<String, dynamic> body, int id);
  Future<dynamic> deleteCommercialProfile(int id);
}

class UserManagementNetworking extends IUserManagementNetworking {
  UserManagementNetworking(this.networking);
  final NetworkHelper networking;
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getAllCommercialProfiles() async {
    try {
      final response = await networking.get(
        url: commercialProfileUrl,
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getAllMerchantCommercialProfiles() async {
    try {
      final response = await networking.get(
        url: commercialProfileUrl + "/merchants",
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getMerchantsCommercialProfiles() async {
    try {
      final response = await networking.get(
        url: '$commercialProfileUrl/$merchantsCommercialProfileUrl',
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getFarmersCommercialProfiles() async {
    try {
      final response = await networking.get(
        url: '$commercialProfileUrl/$farmersCommercialProfileUrl',
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> addCommercialProfile(
      Map<String, dynamic> body, String type) async {
    try {
      final response = await networking.post(
        url: '$commercialProfileUrl/$type',
        headers: headers(),
        body: {getKey(type): body},
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        return e.response?.data;
      } else {
        rethrow;
      }
    }
  }

  String getKey(String type) =>
      Utils.singularizingTheString(type) + '_commercial_profile';

  @override
  Future<dynamic> editCommercialProfile(
      Map<String, dynamic> body, int id) async {
    try {
      final response = await networking.patch(
        url: '$commercialProfileUrl/$id',
        headers: headers(),
        body: {"commercial_profile": body},
      );
      return response;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> deleteCommercialProfile(int id) async {
    try {
      final response = await networking.delete(
        url: commercialProfileUrl + "/$id",
        headers: headers(),
      );
      return response;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }
}
