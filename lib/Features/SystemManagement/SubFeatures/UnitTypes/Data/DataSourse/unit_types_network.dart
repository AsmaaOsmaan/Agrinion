import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../../../App/Errors/exceptions.dart';
import '../../../../../../App/Network/network_helper.dart';

abstract class IUnitTypesNetworking {
  Future<dynamic> getUnitTypes();
  Future<dynamic> addUnitType(Map<String, dynamic> body);
  Future<dynamic> editUnitType(Map<String, dynamic> body, int id);
  Future<dynamic> deleteUnitType(int id);
}

class UnitTypesNetworking implements IUnitTypesNetworking {
  UnitTypesNetworking(this.networking);
  final NetworkHelper networking;
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getUnitTypes() async {
    try {
      final response = await networking.get(
        url: unitTypesUrl,
        headers: headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> addUnitType(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: unitTypesUrl,
        headers: headers(),
        body: {"unit_type": body},
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
  Future<dynamic> editUnitType(Map<String, dynamic> body, int id) async {
    try {
      final response = await networking.patch(
        url: '$unitTypesUrl/$id',
        headers: headers(),
        body: {"unit_type": body},
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> deleteUnitType(int id) async {
    try {
      final response = await networking.delete(
        url: unitTypesUrl + "/$id",
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
