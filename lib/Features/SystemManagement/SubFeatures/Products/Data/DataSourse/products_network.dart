import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../App/Errors/exceptions.dart';
import '../../../../../../App/Network/network_helper.dart';
import '../../../../../../App/Network/network_routes.dart';

abstract class IProductsNetworking {
  Future<dynamic> getProducts();
  Future<dynamic> getProductsPerCategory(int categoryId);
  Future<dynamic> addProduct(Map<String, dynamic> body);
  Future<dynamic> editProduct(Map<String, dynamic> body, int productId);
  Future<dynamic> deleteProduct(int productId);
}

class ProductsNetworking implements IProductsNetworking {
  final NetworkHelper networking;
  ProductsNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getProducts() async {
    try {
      final response = await networking.get(
        url: productsUrl,
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
  Future<dynamic> getProductsPerCategory(int categoryId) async {
    try {
      final response = await networking.get(
        url: productsPerCategoryId(categoryId),
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

  String productsPerCategoryId(int categoryId) =>
      '$categoriesUrl/$categoryId/$productsUrl';
  @override
  Future<dynamic> addProduct(Map<String, dynamic> body) async {
    try {
      final response = await networking.postMedia(
        url: productsUrl,
        headers: headers(),
        body: {"product": body},
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
  Future<dynamic> editProduct(Map<String, dynamic> body, int productId) async {
    try {
      final response = await networking.patch(
        url: '$productsUrl/$productId',
        headers: headers(),
        body: {"product": body},
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
  Future<dynamic> deleteProduct(int productId) async {
    try {
      final response = await networking.delete(
        url: productsUrl + "/$productId",
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
