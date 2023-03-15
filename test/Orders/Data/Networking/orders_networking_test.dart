import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Orders/Data/DataSource/orders_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late OrdersNetworking ordersNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      ordersNetworking = OrdersNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('get Orders test cases', () {
    test('Happy case scenario', () async {
      var orderList = List.generate(
        1,
        (index) => {
          "id": 1,
          "reference_number": null,
          "created_at": "2022-12-04T10:00:09.520Z",
          "creator": {"id": 20, "name": null, "type": "Broker"},
          "commercial_profile_id": 37
        },
      );
      var response = {"orders": orderList};

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: ordersUrl))
          .thenAnswer((_) => responseObject);
      var actual = await ordersNetworking.getOrders();
      expect(actual, orderList);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: ordersUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await ordersNetworking.getOrders();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: ordersUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await ordersNetworking.getOrders();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: ordersUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await ordersNetworking.getOrders();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: ordersUrl)).thenThrow(exception);
      try {
        await ordersNetworking.getOrders();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('create order id test cases', () {
    var functionBody = {
      "order": {"commercial_profile_id": 1}
    };
    var response = {
      'order': {'commercial_profile_id': 1, 'id': 1, 'creator': {}}
    };
    test('Happy case scenario', () async {
      when(helper.post(
        headers: headers,
        url: ordersUrl,
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data['order'] = response;
        return Future.value(res);
      }));
      expect(await ordersNetworking.createOrderId(functionBody), response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: ordersUrl, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await ordersNetworking.createOrderId(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: ordersUrl, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await ordersNetworking.createOrderId(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: ordersUrl, body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await ordersNetworking.createOrderId(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: ordersUrl, body: functionBody))
          .thenThrow(exception);
      try {
        await ordersNetworking.createOrderId(functionBody);
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('place order test cases', () {
    var functionBody = {
      'ad_id': 1,
      "order_id": 1,
      "offers_attributes": [
        {'ad_id': 1, "quantity": 1, "price": 1.0, "notes": "notes"}
      ]
    };
    var response = {
      'id': 1,
      'notes': "1",
      "price": 1.0,
      "quantity": 1,
      "ad_id": 1,
      "conversation_id": 1,
      "previous_offer_id": 1,
      "minimal_offerable_quantity": 1,
      "remaining_quantity": "remaining_quantity",
      'creator_id': 1,
    };

    test('Happy case scenario', () async {
      when(helper.post(
        headers: headers,
        url: ordersNetworking.placeOrderUrl(1, 1),
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await ordersNetworking.placeOrder(functionBody, 1, 1), response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(
        headers: headers,
        url: ordersNetworking.placeOrderUrl(1, 1),
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await ordersNetworking.placeOrder(functionBody, 1, 1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers,
              url: ordersNetworking.placeOrderUrl(1, 1),
              body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await ordersNetworking.placeOrder(functionBody, 1, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers,
              url: ordersNetworking.placeOrderUrl(1, 1),
              body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await ordersNetworking.placeOrder(functionBody, 1, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(
              headers: headers,
              url: ordersNetworking.placeOrderUrl(1, 1),
              body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await ordersNetworking.placeOrder(functionBody, 1, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(
              headers: headers,
              url: ordersNetworking.placeOrderUrl(1, 1),
              body: functionBody))
          .thenThrow(exception);
      try {
        await ordersNetworking.placeOrder(functionBody, 1, 1);
      } catch (e) {
        expect(e, exception);
      }
    });
  });
}
