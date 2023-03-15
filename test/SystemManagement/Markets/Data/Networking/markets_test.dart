import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/DataSourse/markets_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper mock = MockNetworkHelper();
  late MarketsNetworking marketsNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      marketsNetworking = MarketsNetworking(mock);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get markets test cases', () {
    test('Happy case scenario', () async {
      var response = {
        'markets': [
          {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
        ]
      };
      when(mock.get(headers: headers, url: citiesUrl + "/1/" + marketsUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(
        await marketsNetworking.getMarkets(1),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.get(headers: headers, url: marketsUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await marketsNetworking.getMarkets(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.get(headers: headers, url: marketsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await marketsNetworking.getMarkets(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.get(headers: headers, url: marketsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await marketsNetworking.getMarkets(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.get(headers: headers, url: marketsUrl)).thenThrow(exception);
      try {
        await marketsNetworking.getMarkets(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('post market test cases', () {
    var functionBody = {"name_ar": "string", "name_en": "string"};
    var response = {
      'markets': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'market': {'name_ar': 'string', 'name_en': 'string'}
    };

    test('Happy case scenario', () async {
      when(mock.post(
        headers: headers,
        url: '$citiesUrl/1/$marketsUrl',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await marketsNetworking.addMarket(functionBody, 1), response);
    });
    test('SocketException Bad case scenario', () async {
      when(mock.post(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl',
              body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await marketsNetworking.addMarket(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.post(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl',
              body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await marketsNetworking.addMarket(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.post(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl',
              body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await marketsNetworking.addMarket(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.post(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl',
              body: mockBody))
          .thenThrow(exception);
      try {
        await marketsNetworking.addMarket(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('patch market test cases', () {
    var functionBody = {"name_ar": "string", "name_en": "string"};
    var response = {
      'markets': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'market': {'name_ar': 'string', 'name_en': 'string'}
    };

    test('Happy case scenario', () async {
      when(mock.patch(
        headers: headers,
        url: '$citiesUrl/1/$marketsUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        return Future.value(
          response,
        );
      }));
      expect(
        await marketsNetworking.editMarket(functionBody, 1, 1),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.patch(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl/1',
              body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await marketsNetworking.editMarket(functionBody, 1, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.patch(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl/1',
              body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await marketsNetworking.editMarket(functionBody, 1, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.patch(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl/1',
              body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await marketsNetworking.editMarket(functionBody, 1, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.patch(
              headers: headers,
              url: '$citiesUrl/1/$marketsUrl/1',
              body: mockBody))
          .thenThrow(exception);
      try {
        await marketsNetworking.editMarket(functionBody, 1, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete market test cases', () {
    test('Happy case scenario', () async {
      when(mock.delete(
              headers: headers,
              url: citiesUrl + "/1/" + marketsUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await marketsNetworking.deleteMarket(1, 1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: marketsUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await marketsNetworking.deleteMarket(1, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: marketsUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await marketsNetworking.deleteMarket(1, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: marketsUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await marketsNetworking.deleteMarket(1, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.delete(headers: headers, url: marketsUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await marketsNetworking.deleteMarket(1, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
