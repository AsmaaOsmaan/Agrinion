import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../../../../App/Network/network_helper.dart';

abstract class ICitiesNetworking {
  Future<dynamic> getCities();
  Future<dynamic> addCity(Map<String, dynamic> body);
  Future<dynamic> editCity(Map<String, dynamic> body, int id);
  Future<dynamic> deleteCity(int id);
}

class CitiesNetworking implements ICitiesNetworking {
  NetworkHelper networking;
  CitiesNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getCities() async {
    try {
      final response = await networking.get(
        url: citiesUrl,
        headers: headers(),
      );
      var data = response.data;
      return data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> addCity(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: citiesUrl,
        headers: headers(),
        body: {"city": body},
      );
      var data = response.data;
      return data;
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
  Future<dynamic> editCity(Map<String, dynamic> body, int id) async {
    try {
      final response = await networking.patch(
        url: '$citiesUrl/$id',
        headers: headers(),
        body: {"city": body},
      );
      return response.data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> deleteCity(int id) async {
    try {
      final response = await networking.delete(
        url: citiesUrl + "/$id",
        headers: headers(),
      );
      return response;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }
}
