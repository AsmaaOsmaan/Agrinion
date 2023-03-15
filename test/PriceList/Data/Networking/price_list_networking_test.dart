import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/PricesList/Data/Networking/price_list_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper mock = MockNetworkHelper();
  late PriceListNetworking _networking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token': 'token'
  };
  var functionBody = {
    "price_list_item": {
      "market_id": 1,
      "product_id": 2,
      "min_price": 27,
      "max_price": 200,
      "price_list_id": 7,
      "unit_type_id": 1
    }
  };
  var response = {
    "id": 1,
    "min_price": 27,
    "max_price": 200,
    "product": {"product_id": 1, "name_ar": "تفاح", "name_en": "apple"},
    "unit_type": {"unit_type_id": 1, "name_ar": "كيلو جرام", "name_en": "Kg"},
    "created_at": "2023-02-15T10:01:35.654Z",
    "updated_at": "2023-02-15T10:01:35.654Z"
  };

  setUp(
    () {
      _networking = PriceListNetworking(mock);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get pricelist test cases', () {
    String query = 'market_id=1&price_date=23-1-2023';
    test('get function returns response with data', () async {
      var response = {
        "id": 9,
        "price_date": "2023-02-15",
        "market": {
          "id": 2,
          "name_ar": "سوق جدة الرئيسي",
          "name_en": "jeddah grand market"
        },
        "created_at": "2023-02-16T09:51:12.660Z",
        "updated_at": "2023-02-16T09:51:12.660Z",
        "price_list_items": [
          {
            "id": 2,
            "min_price": 27,
            "max_price": 200,
            "product": {"product_id": 1, "name_ar": "تفاح", "name_en": "apple"},
            "unit_type": {
              "unit_type_id": 1,
              "name_ar": "كيلو جرام",
              "name_en": "Kg"
            },
            "created_at": "2023-02-15T10:02:21.956Z",
            "updated_at": "2023-02-15T10:02:21.956Z"
          }
        ],
        "non_price_list_items": [
          {"product_id": 1, "name_ar": "تفاح", "name_en": "apple"}
        ]
      };
      when(mock.get(headers: headers, url: '$priceListUrl?$query'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var actual = await _networking.getPriceList(query);
      expect(actual, response);
    });
    test('SocketException Bad case scenario', () async {
      when(mock.get(headers: headers, url: '$priceListUrl?$query'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.getPriceList(query);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.get(headers: headers, url: '$priceListUrl?$query'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.getPriceList(query);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.get(headers: headers, url: '$priceListUrl?$query'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.getPriceList(query);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mock.get(headers: headers, url: '$priceListUrl?$query'))
          .thenThrow(exception);
      try {
        await _networking.getPriceList(query);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('create price list test cases', () {
    test('create pricelist done and returns response', () async {
      when(mock.post(
        headers: headers,
        url: crudPriceListUrl,
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await _networking.createPriceList(functionBody), response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(mock.post(
        headers: headers,
        url: crudPriceListUrl,
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      expect(await _networking.createPriceList(functionBody), {});
    });
    test('wrong data fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(mock.post(
        headers: headers,
        url: crudPriceListUrl,
        body: {},
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      expect(await _networking.createPriceList({}), {});
    });
    test('SocketException Bad case scenario', () async {
      when(mock.post(
              headers: headers, url: crudPriceListUrl, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.createPriceList(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.post(
              headers: headers, url: crudPriceListUrl, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.createPriceList(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.post(
              headers: headers, url: crudPriceListUrl, body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.createPriceList(functionBody);
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
              headers: headers, url: crudPriceListUrl, body: functionBody))
          .thenThrow(exception);
      try {
        await _networking.createPriceList(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('update price list test cases', () {
    test('update pricelist done and returns response', () async {
      when(mock.patch(
        headers: headers,
        url: '$crudPriceListUrl/1',
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await _networking.updatePriceList(functionBody, 1), response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(mock.patch(
        headers: headers,
        url: '$crudPriceListUrl/1',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      expect(await _networking.updatePriceList(functionBody, 1), {});
    });
    test('wrong data fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(mock.patch(
        headers: headers,
        url: '$crudPriceListUrl/1',
        body: {},
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      expect(await _networking.updatePriceList({}, 1), {});
    });
    test('SocketException Bad case scenario', () async {
      when(mock.patch(
              headers: headers, url: '$crudPriceListUrl/1', body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.updatePriceList(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mock.patch(
              headers: headers, url: '$crudPriceListUrl/1', body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.updatePriceList(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mock.patch(
              headers: headers, url: '$crudPriceListUrl/1', body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.updatePriceList(functionBody, 1);
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
              headers: headers, url: '$crudPriceListUrl/1', body: functionBody))
          .thenThrow(exception);
      try {
        await _networking.updatePriceList(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
