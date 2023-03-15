import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../Utilities/cache_helper.dart';
import '../Utilities/globale_state.dart';
import '../constants/keys.dart';
import 'network_interceptors.dart';

class NetworkHelper {
  static String? apiBaseUrl = dotenv.env['API_URL'];

  final BaseOptions _options = BaseOptions(
    baseUrl: apiBaseUrl!,
    connectTimeout: 8000,
    receiveTimeout: 8000,
    sendTimeout: 8000,
  );

  Future<dynamic> get({
    required String url,
    required Map<String, String> headers,
  }) async {
    try {
      Dio dio = Dio(_options);
      dio.interceptors.add(LoggingInterceptor());
      _options.headers = headers;
      final response = await dio.get(url);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post({
    required String url,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      Dio dio = Dio(_options);
      dio.interceptors.add(LoggingInterceptor());
      _options.headers = headers;
      final response = await dio.post(
        url,
        data: jsonEncode(body),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMedia({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    Dio dio = Dio(_options);
    dio.interceptors.add(LoggingInterceptor());
    FormData formData = FormData.fromMap(body);
    body.forEach((firstkey, value) {
      if (value is Map) {
        value.forEach((secondKey, value) {
          if (value is File) {
            formData.files.add(
                MapEntry("$firstkey[$secondKey]", convertToMultiPart(value)));
          }
        });
      }
    });

    dio.options.headers = headers;
    try {
      var response = await dio.post(url, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch({
    required String url,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      Dio dio = Dio(_options);
      dio.interceptors.add(LoggingInterceptor());
      _options.headers = headers;
      final response = await dio.patch(url, data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patchMedia({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    Dio dio = Dio(_options);
    dio.interceptors.add(LoggingInterceptor());
    FormData formData = FormData.fromMap(body);
    body.forEach((firstkey, value) {
      if (value is Map) {
        value.forEach((secondKey, value) {
          if (value is File) {
            formData.files.add(
                MapEntry("$firstkey[$secondKey]", convertToMultiPart(value)));
          }
        });
      }
    });

    dio.options.headers = headers;
    try {
      var response = await dio.patch(url, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete({
    required String url,
    required Map<String, String> headers,
  }) async {
    try {
      Dio dio = Dio(_options);
      dio.interceptors.add(LoggingInterceptor());
      _options.headers = headers;
      final response = await Dio(_options).delete(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  final _downloadRequestOptions = Options(
    contentType: "application/pdf",
    responseType: ResponseType.bytes,
    followRedirects: false,
    receiveTimeout: 0,
  );

  Future getDownload({
    required String url,
    required Map<String, dynamic> headers,
  }) async {
    try {
      _downloadRequestOptions.headers = headers;
      final response =
          await Dio().get(apiBaseUrl! + url, options: _downloadRequestOptions);
      return response;
    } on Exception {
      return null;
    }
  }

  Future postDownload({
    required String url,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      _downloadRequestOptions.headers = headers;
      final response = await Dio().post(apiBaseUrl! + url,
          data: body, options: _downloadRequestOptions);
      return response;
    } on Exception {
      return null;
    }
  }

  MultipartFile convertToMultiPart(File file) {
    return MultipartFile.fromFileSync(file.path,
        filename: file.path.split("/").last);
  }
}

String getToken() =>
    GlobalState.instance.get(kToken) ?? CachHelper.getData(key: kToken);
