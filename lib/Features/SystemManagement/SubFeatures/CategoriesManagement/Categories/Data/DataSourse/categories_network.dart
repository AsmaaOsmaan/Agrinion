import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../../App/Errors/exceptions.dart';
import '../../../../../../../App/Network/network_helper.dart';
import '../../../../../../../App/Network/network_routes.dart';

abstract class ICategoriesNetworking {
  Future<dynamic> getCategories();
  Future<dynamic> getCategoryGroups();
  Future<dynamic> getMainCategories();
  Future<dynamic> getCategoriesInCategoryGroup(int categoryId);
  Future<dynamic> addCategory(Map<String, dynamic> body);
  Future<dynamic> editCategory(Map<String, dynamic> body, int categoryId);
  Future<dynamic> addCategoryGroup(Map<String, dynamic> body);
  Future<dynamic> editCategoryGroup(Map<String, dynamic> body, int categoryId);
  Future<dynamic> deleteCategory(int categoryId);
  Future<dynamic> deleteCategoryGroup(int categoryId);
}

class CategoriesNetworking implements ICategoriesNetworking {
  CategoriesNetworking(this.networking);
  final NetworkHelper networking;
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> getCategories() async {
    try {
      final response = await networking.get(
        url: categoriesUrl,
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
  Future<dynamic> getCategoryGroups() async {
    try {
      final response = await networking.get(
        url: categoryGroupUrl,
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
  Future<dynamic> getMainCategories() async {
    try {
      final response = await networking.get(
        url: mainCategoriesUrl,
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
  Future<dynamic> getCategoriesInCategoryGroup(int categoryId) async {
    try {
      final response = await networking.get(
        url: '$categoriesPerCategory=$categoryId',
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
  Future<dynamic> addCategory(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: categoriesUrl,
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
  Future<dynamic> editCategory(
      Map<String, dynamic> body, int categoryId) async {
    try {
      final response = await networking.patch(
        url: categoriesUrl + "/$categoryId",
        headers: headers(),
        body: body,
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
  Future<dynamic> addCategoryGroup(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: categoryGroupUrl,
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
  Future<dynamic> editCategoryGroup(
      Map<String, dynamic> body, int categoryId) async {
    try {
      final response = await networking.patch(
        url: categoryGroupUrl + "/$categoryId",
        headers: headers(),
        body: body,
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
  Future<dynamic> deleteCategory(int categoryId) async {
    try {
      final response = await networking.delete(
        url: categoriesUrl + "/$categoryId",
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

  @override
  Future<dynamic> deleteCategoryGroup(int categoryId) async {
    try {
      final response = await networking.delete(
        url: categoryGroupUrl + "/$categoryId",
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
