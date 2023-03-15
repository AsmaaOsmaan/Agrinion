import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Data/DataSourse/products_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper mock = MockNetworkHelper();
  late ProductsNetworking productsNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      productsNetworking = ProductsNetworking(mock);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get cities test cases', () {
    test('Happy case scenario', () async {
      var response = {
        'products': [
          {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello', 'category_id': 1}
        ]
      };
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(mock.get(headers: headers, url: productsUrl))
          .thenAnswer((_) => responseObject);
      expect(await productsNetworking.getProducts(), response);
    });
    test('SocketException Bad case scenario', () async {
      when(mock.get(headers: headers, url: productsUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await productsNetworking.getProducts();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.get(headers: headers, url: productsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await productsNetworking.getProducts();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.get(headers: headers, url: productsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await productsNetworking.getProducts();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.get(headers: headers, url: productsUrl)).thenThrow(exception);
      try {
        await productsNetworking.getProducts();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('post city test cases', () {
    var functionBody = {"name_ar": "string", "name_en": "string"};
    var response = {
      'product': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'product': {'name_ar': 'string', 'name_en': 'string'}
    };
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
    };
    test('Happy case scenario', () async {
      when(mock.postMedia(
        headers: headers2,
        url: productsUrl,
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(
        await productsNetworking.addProduct(functionBody),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.postMedia(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await productsNetworking.addProduct(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.postMedia(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await productsNetworking.addProduct(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.postMedia(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await productsNetworking.addProduct(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.postMedia(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await productsNetworking.addProduct(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('patch city test cases', () {
    var functionBody = {"name_ar": "string", "name_en": "string"};
    var response = {
      'product': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'product': {'name_ar': 'string', 'name_en': 'string'}
    };
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
    };
    test('Happy case scenario', () async {
      when(mock.patch(
        headers: headers2,
        url: '$productsUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(
        await productsNetworking.editProduct(functionBody, 1),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await productsNetworking.editProduct(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await productsNetworking.editProduct(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await productsNetworking.editProduct(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.patch(headers: headers, url: productsUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await productsNetworking.editProduct(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete city test cases', () {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
    };
    test('Happy case scenario', () async {
      when(mock.delete(headers: headers2, url: productsUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await productsNetworking.deleteProduct(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: productsUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await productsNetworking.deleteProduct(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: productsUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await productsNetworking.deleteProduct(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: productsUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await productsNetworking.deleteProduct(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.delete(headers: headers, url: productsUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await productsNetworking.deleteProduct(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
