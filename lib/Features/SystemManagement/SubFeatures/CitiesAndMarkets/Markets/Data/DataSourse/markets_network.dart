import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../../App/Errors/exceptions.dart';
import '../../../../../../../App/Network/network_helper.dart';
import '../../../../../../../App/Network/network_routes.dart';

abstract class IMarketsNetworking {
  Future<dynamic> getMarkets(int id);
  Future<dynamic> addMarket(Map<String, dynamic> body, int cityId);

  Future<dynamic> editMarket(
      Map<String, dynamic> body, int cityId, int marketId);

  Future<dynamic> deleteMarket(int cityId, int marketId);
}

class MarketsNetworking implements IMarketsNetworking {
  final NetworkHelper networking;
  MarketsNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getMarkets(int id) async {
    try {
      final response = await networking.get(
        url: citiesUrl + "/$id/" + marketsUrl,
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  @override
  Future<dynamic> addMarket(Map<String, dynamic> body, int cityId) async {
    try {
      final response = await networking.post(
        url: citiesUrl + "/$cityId/" + marketsUrl,
        headers: headers(),
        body: {"market": body},
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
  Future<dynamic> editMarket(
      Map<String, dynamic> body, int cityId, int marketId) async {
    try {
      final response = await networking.patch(
        url: citiesUrl + "/$cityId/" + marketsUrl + "/$marketId",
        headers: headers(),
        body: {"market": body},
      );
      return response;
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
  Future<dynamic> deleteMarket(int cityId, int marketId) async {
    final response = await networking.delete(
      url: '$citiesUrl/$cityId/$marketsUrl/$marketId',
      headers: headers(),
    );
    return response;
  }
}
