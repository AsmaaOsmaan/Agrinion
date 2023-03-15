import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Data/DataSourse/categories_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late CategoriesNetworking categoriesNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      categoriesNetworking = CategoriesNetworking(helper);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get categories test cases', () {
    test('Happy case scenario', () async {
      var response = {
        'categories': [
          {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
        ]
      };

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: categoriesUrl))
          .thenAnswer((_) => responseObject);
      var actual = await categoriesNetworking.getCategories();
      expect(actual, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: categoriesUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await categoriesNetworking.getCategories();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: categoriesUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await categoriesNetworking.getCategories();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: categoriesUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await categoriesNetworking.getCategories();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: categoriesUrl))
          .thenThrow(exception);
      try {
        await categoriesNetworking.getCategories();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('post category test cases', () {
    var functionBody = {
      "name_ar": "string",
      "name_en": "string",
      "active": true,
      "published": true
    };
    var response = {
      'category': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'category': {
        'name_ar': 'string',
        'name_en': 'string',
        "active": true,
        "published": true
      }
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: categoriesUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      var actual = await categoriesNetworking.addCategory(functionBody);
      expect(actual, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await categoriesNetworking.addCategory(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await categoriesNetworking.addCategory(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await categoriesNetworking.addCategory(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await categoriesNetworking.addCategory(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('patch category test cases', () {
    var functionBody = {
      "name_ar": "string",
      "name_en": "string",
      "active": true,
      "published": true
    };
    var response = {
      'category': {
        'id': 1,
        'name_ar': 'مرحبا',
        'name_en': 'hello',
        "active": true,
        "published": true
      }
    };

    var mockBody = {'category': functionBody};
    test('Happy case scenario', () async {
      when(helper.patch(
        headers: headers,
        url: '$categoriesUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        return Future.value(response);
      }));
      expect(
          await categoriesNetworking.editCategory(functionBody, 1), response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await categoriesNetworking.editCategory(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await categoriesNetworking.editCategory(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await categoriesNetworking.editCategory(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(headers: headers, url: categoriesUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await categoriesNetworking.editCategory(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete category test cases', () {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
    };
    test('Happy case scenario', () async {
      when(helper.delete(headers: headers2, url: categoriesUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await categoriesNetworking.deleteCategory(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: categoriesUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await categoriesNetworking.deleteCategory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: categoriesUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await categoriesNetworking.deleteCategory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: categoriesUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await categoriesNetworking.deleteCategory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(headers: headers, url: categoriesUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await categoriesNetworking.deleteCategory(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
