import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Data/DataSourse/unit_types_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper mock = MockNetworkHelper();
  late UnitTypesNetworking unitTypesNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      unitTypesNetworking = UnitTypesNetworking(mock);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get unitTypes test cases', () {
    test('Happy case scenario', () async {
      var response = {
        'unitTypes': [
          {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
        ]
      };
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(mock.get(headers: headers, url: unitTypesUrl))
          .thenAnswer((_) => responseObject);
      expect(
        await unitTypesNetworking.getUnitTypes(),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.get(headers: headers, url: unitTypesUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await unitTypesNetworking.getUnitTypes();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.get(headers: headers, url: unitTypesUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await unitTypesNetworking.getUnitTypes();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.get(headers: headers, url: unitTypesUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await unitTypesNetworking.getUnitTypes();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.get(headers: headers, url: unitTypesUrl)).thenThrow(exception);
      try {
        await unitTypesNetworking.getUnitTypes();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('post unitType test cases', () {
    var functionBody = {"name_ar": "string", "name_en": "string"};
    var response = {
      'unit_type': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'unit_type': {'name_ar': 'string', 'name_en': 'string'}
    };

    test('Happy case scenario', () async {
      when(mock.post(
        headers: headers,
        url: unitTypesUrl,
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
        await unitTypesNetworking.addUnitType(functionBody),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.post(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await unitTypesNetworking.addUnitType(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.post(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await unitTypesNetworking.addUnitType(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.post(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await unitTypesNetworking.addUnitType(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.post(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await unitTypesNetworking.addUnitType(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('patch unitType test cases', () {
    var functionBody = {"name_ar": "string", "name_en": "string"};
    var response = {
      'unit_type': {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
    };

    var mockBody = {
      'unit_type': {'name_ar': 'string', 'name_en': 'string'}
    };

    test('Happy case scenario', () async {
      when(mock.patch(
        headers: headers,
        url: '$unitTypesUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        return Future.value(
          response,
        );
      }));
      expect(
        await unitTypesNetworking.editUnitType(functionBody, 1),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await unitTypesNetworking.editUnitType(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await unitTypesNetworking.editUnitType(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.patch(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await unitTypesNetworking.editUnitType(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.patch(headers: headers, url: unitTypesUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await unitTypesNetworking.editUnitType(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete unitType test cases', () {
    test('Happy case scenario', () async {
      when(mock.delete(headers: headers, url: unitTypesUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await unitTypesNetworking.deleteUnitType(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: unitTypesUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await unitTypesNetworking.deleteUnitType(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: unitTypesUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await unitTypesNetworking.deleteUnitType(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.delete(headers: headers, url: unitTypesUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await unitTypesNetworking.deleteUnitType(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.delete(headers: headers, url: unitTypesUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await unitTypesNetworking.deleteUnitType(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
