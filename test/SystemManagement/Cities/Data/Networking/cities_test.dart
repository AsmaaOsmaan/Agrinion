import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Data/DataSourse/cities_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper mock = MockNetworkHelper();
  late CitiesNetworking citiesNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      citiesNetworking = CitiesNetworking(mock);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get cities test cases', () {
    test('Happy case scenario', () async {
      var response = {
        'cities': [
          {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
        ]
      };
      when(mock.get(headers: headers, url: citiesUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var actual = await citiesNetworking.getCities();
      expect(actual, response);
    });
    test('SocketException Bad case scenario', () async {
      when(mock.get(headers: headers, url: citiesUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await citiesNetworking.getCities();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.get(headers: headers, url: citiesUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await citiesNetworking.getCities();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.get(headers: headers, url: citiesUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await citiesNetworking.getCities();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.get(headers: headers, url: citiesUrl)).thenThrow(exception);
      try {
        await citiesNetworking.getCities();
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
      'cities': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'city': {'name_ar': 'string', 'name_en': 'string'}
    };
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
    };
    test('Happy case scenario', () async {
      when(mock.post(
        headers: headers2,
        url: citiesUrl,
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
        await citiesNetworking.addCity(functionBody),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.post(headers: headers, url: citiesUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await citiesNetworking.addCity(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.post(headers: headers, url: citiesUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await citiesNetworking.addCity(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.post(headers: headers, url: citiesUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await citiesNetworking.addCity(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.post(headers: headers, url: citiesUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await citiesNetworking.addCity(functionBody);
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
      'cities': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'city': {'name_ar': 'string', 'name_en': 'string'}
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
        url: '$citiesUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await citiesNetworking.editCity(functionBody, 1), response);
    });
    test('SocketException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: '$citiesUrl/1', body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await citiesNetworking.editCity(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: '$citiesUrl/1', body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await citiesNetworking.editCity(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: '$citiesUrl/1', body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await citiesNetworking.editCity(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.patch(headers: headers, url: '$citiesUrl/1', body: mockBody))
          .thenThrow(exception);
      try {
        await citiesNetworking.editCity(functionBody, 1);
      } catch (e) {
        expect(e, exception);
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
      when(mock.delete(headers: headers2, url: citiesUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await citiesNetworking.deleteCity(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: citiesUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await citiesNetworking.deleteCity(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: citiesUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await citiesNetworking.deleteCity(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: citiesUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await citiesNetworking.deleteCity(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.delete(headers: headers, url: citiesUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await citiesNetworking.deleteCity(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
