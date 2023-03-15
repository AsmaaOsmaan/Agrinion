import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_helper.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_routes.dart';

abstract class INewsNetworking {
  Future<dynamic> createNews(Map<String, dynamic> body);

  Future<dynamic> listAllNews();

  Future<dynamic> showSpecificNews(int newsId);

  Future<dynamic> deleteNews(int newsId);

  Future<dynamic> editNews(Map<String, dynamic> body, int newsId);

  Future<dynamic> homeListAllNews();
}

class NewsNetworking implements INewsNetworking {
  NewsNetworking(this.networking);

  final NetworkHelper networking;

  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  Future _getNews(String url) async {
    try {
      final response = await networking.get(url: url, headers: headers());
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
  Future<dynamic> listAllNews() async {
    return _getNews(newsUrl);
  }

  @override
  Future<dynamic> homeListAllNews() async {
    return _getNews('$newsUrl?is_home=true');
  }

  @override
  Future<dynamic> createNews(Map<String, dynamic> body) async {
    try {
      final response = await networking.postMedia(
        url: newsUrl,
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
  Future<dynamic> showSpecificNews(int newsId) async {
    try {
      final response = await networking.get(
        url: '$newsUrl/$newsId',
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
  Future<dynamic> deleteNews(int newsId) async {
    try {
      final response = await networking.delete(
        url: newsUrl + "/$newsId",
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
  Future<dynamic> editNews(Map<String, dynamic> body, int newsId) async {
    try {
      final response = await networking.patchMedia(
        url: newsUrl + "/$newsId",
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
}
