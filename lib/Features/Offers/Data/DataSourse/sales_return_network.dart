import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';

abstract class ISalesReturnNetworking {
  Future<dynamic> createSalesReturn(Map<String, dynamic> body);
  Future<dynamic> getSalesReturns(int conversationId);
}

class SalesReturnNetworking implements ISalesReturnNetworking {
  final NetworkHelper networking;
  SalesReturnNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> createSalesReturn(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: salesReturnsUrl,
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

  @override
  Future<dynamic> getSalesReturns(int conversationId) async {
    try {
      final response = await networking.get(
        url: '$conversationUrl/$conversationId/$salesReturnsUrl',
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
}
