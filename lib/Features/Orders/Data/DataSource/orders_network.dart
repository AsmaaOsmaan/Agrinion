import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';

abstract class IOrdersNetworking {
  Future<dynamic> getOrders();
  Future<dynamic> createOrderId(Map<String, dynamic> body);
  Future<dynamic> placeOrder(Map<String, dynamic> body, int orderId, int adId);
  Future<dynamic> getSales();
  Future<dynamic> createDirectOrderId(Map<String, dynamic> body);
}

class OrdersNetworking implements IOrdersNetworking {
  final NetworkHelper networking;
  OrdersNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getOrders() async {
    try {
      final response = await networking.get(url: ordersUrl, headers: headers());
      var data = response.data['orders'];
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  @override
  Future<dynamic> placeOrder(
      Map<String, dynamic> body, int orderId, int adId) async {
    try {
      final response = await networking.post(
        url: placeOrderUrl(orderId, adId),
        headers: headers(),
        body: body,
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

  String placeOrderUrl(int orderId, int adId) =>
      '$ordersUrl/$orderId/ads/$adId/conversations';

  @override
  Future<dynamic> createOrderId(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: ordersUrl,
        headers: headers(),
        body: body,
      );

      var data = response.data['order'];
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
  Future<dynamic> createDirectOrderId(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: directOrdersUrl,
        headers: headers(),
        body: body,
      );

      var data = response.data['order'];
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
  Future<dynamic> getSales() async {
    try {
      final response = await networking.get(
        url: directOrdersUrl,
        headers: headers(),
      );
      var data = response.data['orders'];
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }
}
