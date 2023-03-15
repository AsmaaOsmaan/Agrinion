import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';

abstract class ISalesReportsNetworking {
  Future<dynamic> exportSalesReportPDF(String query);
  Future<dynamic> getClients();
  Future<dynamic> getProducts();
}

class SalesReportsNetworking implements ISalesReportsNetworking {
  final NetworkHelper networking;
  SalesReportsNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> exportSalesReportPDF(String query) async {
    Map<String, String> headers() => {
          'Accept': 'application/pdf',
          'Content-Type': "application/pdf",
          'X-access-token': getToken(),
        };
    try {
      final response = await networking.getDownload(
        url: '$salesReportsUrl?$query',
        headers: headers(),
      );
      var data = response.data;
      return data;
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

  @override
  Future<dynamic> getClients() async {
    try {
      final response = await networking.get(
        url: salesClientsUrl,
        headers: headers(),
      );
      var data = response.data;
      return data['clients'];
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

  @override
  Future<dynamic> getProducts() async {
    try {
      final response = await networking.get(
        url: salesProductsUrl,
        headers: headers(),
      );
      var data = response.data;
      return data['products'];
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
