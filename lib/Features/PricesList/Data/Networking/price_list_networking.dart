import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';

abstract class IPriceListNetworking {
  Future getPriceList(String query);
  Future updatePriceList(Map<String, dynamic> body, int priceItemId);
  Future createPriceList(Map<String, dynamic> body);
  Future deletePriceList(int pricedItemId);
}

class PriceListNetworking implements IPriceListNetworking {
  final NetworkHelper networking;
  PriceListNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future getPriceList(String query) async {
    try {
      final response = await networking.get(
        url: '$priceListUrl?$query',
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
  Future createPriceList(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: crudPriceListUrl,
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
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future updatePriceList(Map<String, dynamic> body, int priceItemId) async {
    try {
      final response = await networking.patch(
        url: '$crudPriceListUrl/$priceItemId',
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
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future deletePriceList(int priceItemId) async {
    try {
      final response = await networking.delete(
        url: '$crudPriceListUrl/$priceItemId',
        headers: headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }
}
