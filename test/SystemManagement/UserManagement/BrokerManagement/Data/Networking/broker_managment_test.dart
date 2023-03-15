import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/DataSource/broker_management_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late BrokerManagementNetworking brokerManagementNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      brokerManagementNetworking = BrokerManagementNetworking(helper);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );

  group('post assign broker test cases', () {
    var functionBody = {
      "request": {"broker_id": 21, "market_id": 6}
    };
    var response = {
      "id": 21,
      "status": "approved",
      "market": {
        "id": 6,
        "name_ar": "سوق الرياض الرئيسي",
        "name_en": "Riyadh grand market"
      },
      "broker": {"id": 21, "name": "Miss Jerome Jaskolski"},
      "admin": {"id": 1, "name": null}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(
              headers: headers, url: brokerMarketRequest, body: functionBody))
          .thenAnswer((_) => responseObject);
      var actual =
          await brokerManagementNetworking.assignBrokerToMarket(functionBody);
      expect(actual, response);
    });

    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: brokerMarketRequest, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await brokerManagementNetworking.assignBrokerToMarket(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });

    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: brokerMarketRequest, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await brokerManagementNetworking.assignBrokerToMarket(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });

    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(
              headers: headers, url: brokerMarketRequest, body: functionBody))
          .thenThrow(exception);
      try {
        await brokerManagementNetworking.assignBrokerToMarket(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });

    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(
              headers: headers, url: brokerMarketRequest, body: functionBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual =
          await brokerManagementNetworking.assignBrokerToMarket(functionBody);
      expect(actual, validationRes.data);
    });
  });
  group('get unlinked broker markets test cases', () {
    test('Happy case scenario', () async {
      var response = {
        [
          {'id': 1, 'name_ar': 'مرحبا', 'name_en': 'hello'}
        ]
      };
      when(helper.get(headers: headers, url: "$marketsUrl/$unlinkedBrokerMarketUrl?broker_id=1&city_id=6"))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(
        await brokerManagementNetworking.getUnlikedBrokerMarkets(1,6),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: "$marketsUrl/$unlinkedBrokerMarketUrl?broker_id=1&city_id=6"))
          .thenThrow(const SocketException("HEllo"));
      try {
        await brokerManagementNetworking.getUnlikedBrokerMarkets(1,6);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url:    "$marketsUrl/$unlinkedBrokerMarketUrl?broker_id=1&city_id=6"))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await brokerManagementNetworking.getUnlikedBrokerMarkets(1,6);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: "$marketsUrl/$unlinkedBrokerMarketUrl?broker_id=1&city_id=6"))
          .thenThrow(const HttpException("HEllo"));
      try {
        await brokerManagementNetworking.getUnlikedBrokerMarkets(1,6);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: "$marketsUrl/$unlinkedBrokerMarketUrl?broker_id=1&city_id=6")).thenThrow(exception);
      try {
        await brokerManagementNetworking.getUnlikedBrokerMarkets(1,6);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('get linked broker markets test cases', () {
    test('Happy case scenario', () async {
      var response = {
         [
          {
            "market": {
              "id": 1,
              "name_ar": "سوق جدة",
              "name_en": "jeddah market"
            },
            "city": {
              "id": 1,
              "name_ar": "جدة",
              "name_en": "Jeddah"
            }
          },
        ]
      };
      when(helper.get(headers: headers, url: '$marketsUrl/$brokerMarketsUrl?broker_id=1'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(
        await brokerManagementNetworking.getBrokerMarkets(1),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$marketsUrl/$brokerMarketsUrl?broker_id=1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await brokerManagementNetworking.getBrokerMarkets(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$marketsUrl/$brokerMarketsUrl?broker_id=1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await brokerManagementNetworking.getBrokerMarkets(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$marketsUrl/$brokerMarketsUrl?broker_id=1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await brokerManagementNetworking.getBrokerMarkets(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: '$marketsUrl/$brokerMarketsUrl?broker_id=1')).thenThrow(exception);
      try {
        await brokerManagementNetworking.getBrokerMarkets(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('unlink request test cases', () {
    var response ={"id": 1, "name_ar": "سوق جدة", "name_en": "jeddah market"};
    String url = '$marketsUrl/$unlinkBrokerMarketUrl?broker_id=1&market_id=1';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.patch(headers: headers, url: url))
          .thenAnswer((_) => responseObject);
      var actual = await brokerManagementNetworking.unLinkBrokerMarket(1,1);
      expect(actual, response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.patch(headers: headers, url: url)).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await brokerManagementNetworking.unLinkBrokerMarket(1,1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await brokerManagementNetworking.unLinkBrokerMarket(1,1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await brokerManagementNetworking.unLinkBrokerMarket(1,1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const HttpException("HEllo"));
      try {
        await brokerManagementNetworking.unLinkBrokerMarket(1,1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(headers: headers, url: url)).thenThrow(exception);
      try {
        await brokerManagementNetworking.unLinkBrokerMarket(1,1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });



}
