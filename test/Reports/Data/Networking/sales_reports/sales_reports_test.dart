import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Reports/Data/Networking/sales_report_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late ISalesReportsNetworking salesReportsNetworking;

  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
      salesReportsNetworking = SalesReportsNetworking(helper);
    },
  );
  group('Get Clients test cases', () {
    test('Happy case scenario', () async {
      var response = List.generate(
        2,
        (index) => {"id": index, "profile_name": "name$index"},
      );

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {"clients": response},
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: salesClientsUrl))
          .thenAnswer((_) => responseObject);
      var actual = await salesReportsNetworking.getClients();
      expect(actual, response);
    });

    test('Authorization fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(helper.get(
        headers: headers,
        url: salesClientsUrl,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await salesReportsNetworking.getClients();
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: salesClientsUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await salesReportsNetworking.getClients();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: salesClientsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await salesReportsNetworking.getClients();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: salesClientsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await salesReportsNetworking.getClients();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: salesClientsUrl))
          .thenThrow(exception);
      try {
        await salesReportsNetworking.getClients();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('get products test cases', () {
    var response = List.generate(
      2,
      (index) => {"id": index, "name": "Product"},
    );
    Response res = Response(
      requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
      data: {"products": response},
    );
    test('Happy case scenario', () async {
      when(helper.get(
        headers: headers,
        url: salesProductsUrl,
      )).thenAnswer(((realInvocation) {
        return Future.value(res);
      }));
      var actual = await salesReportsNetworking.getProducts();
      expect(actual, response);
    });

    test('Authorization fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(helper.get(
        headers: headers,
        url: salesProductsUrl,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await salesReportsNetworking.getProducts();
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(
        headers: headers,
        url: salesProductsUrl,
      )).thenThrow(const SocketException("HEllo"));
      try {
        await salesReportsNetworking.getProducts();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(
        headers: headers,
        url: salesProductsUrl,
      )).thenThrow(TimeoutException("HEllo"));
      try {
        await salesReportsNetworking.getProducts();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(
        headers: headers,
        url: salesProductsUrl,
      )).thenThrow(const HttpException("HEllo"));
      try {
        await salesReportsNetworking.getProducts();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(
        headers: headers,
        url: salesProductsUrl,
      )).thenThrow(exception);
      try {
        await salesReportsNetworking.getProducts();
      } catch (e) {
        expect(e, exception);
      }
    });
  });
}
