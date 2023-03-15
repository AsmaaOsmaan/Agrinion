import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Reports/Data/Networking/invoices_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late InvoicesNetworking invoicesNetworking;
  var headers = {
    'Accept': 'application/pdf',
    'Content-Type': "application/pdf",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };

  var headers2 = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      invoicesNetworking = InvoicesNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('Show Exported Invoice test cases', () {
    test('Happy case scenario', () async {
      var response = List.generate(200, (index) => index);

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.getDownload(headers: headers, url: '$invoicesUrl/1.pdf'))
          .thenAnswer((_) => responseObject);
      var actual = await invoicesNetworking.showExportedInvoicePDF(1);
      expect(actual, response);
    });

    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(helper.getDownload(
        headers: headers,
        url: '$invoicesUrl/1.pdf',
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await invoicesNetworking.showExportedInvoicePDF(1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.getDownload(headers: headers, url: '$invoicesUrl/1.pdf'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await invoicesNetworking.showExportedInvoicePDF(1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.getDownload(headers: headers, url: '$invoicesUrl/1.pdf'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await invoicesNetworking.showExportedInvoicePDF(1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.getDownload(headers: headers, url: '$invoicesUrl/1.pdf'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await invoicesNetworking.showExportedInvoicePDF(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.getDownload(headers: headers, url: '$invoicesUrl/1.pdf'))
          .thenThrow(exception);
      try {
        await invoicesNetworking.showExportedInvoicePDF(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('export invoices for conversation test cases', () {
    List<int> consId = [1, 2, 3];
    var functionBody = {"conversation_ids": consId};
    var response = List.generate(200, (index) => index);
    test('Happy case scenario', () async {
      when(helper.postDownload(
        headers: headers,
        url: '$ordersUrl/1.pdf',
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await invoicesNetworking.exportInvoice(functionBody, 1), response);
    });

    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.postDownload(
        headers: headers,
        url: '$ordersUrl/1.pdf',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await invoicesNetworking.exportInvoice(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.postDownload(
              headers: headers, url: '$ordersUrl/1.pdf', body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await invoicesNetworking.exportInvoice(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.postDownload(
              headers: headers, url: '$ordersUrl/1.pdf', body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await invoicesNetworking.exportInvoice(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.postDownload(
              headers: headers, url: '$ordersUrl/1.pdf', body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await invoicesNetworking.exportInvoice(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.postDownload(
              headers: headers, url: '$ordersUrl/1.pdf', body: functionBody))
          .thenThrow(exception);
      try {
        await invoicesNetworking.exportInvoice(functionBody, 1);
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('get posts test cases', () {
    var listResponse = [
      {
        "id": 7,
        "invoice_number": "729856927",
        "grand_total": 59062.49,
        "remaining_total": 51809.2,
        "creator_id": 18,
        "supplier": {
          "id": 67,
          "profile_name": "Gwen Marvin IV",
          "commercial_register": "4312645337",
          "tax_number": "8345482070",
          "type": "FarmerCommercialProfile"
        },
        "client": {
          "id": 69,
          "profile_name": "Betsey Wehner",
          "commercial_register": "8494385731",
          "tax_number": "6369313870",
          "type": "MerchantCommercialProfile"
        }
      }
    ];

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'invoices': listResponse},
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers2, url: invoicesUrl))
          .thenAnswer((_) => responseObject);
      var actual = await invoicesNetworking.getMyInvoices();
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers2, url: invoicesUrl))
          .thenThrow(const SocketException("Hello"));
      try {
        await invoicesNetworking.getMyInvoices();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers2, url: invoicesUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await invoicesNetworking.getMyInvoices();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers2, url: invoicesUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await invoicesNetworking.getMyInvoices();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers2, url: invoicesUrl))
          .thenThrow(exception);
      try {
        await invoicesNetworking.getMyInvoices();
      } catch (e) {
        expect(e, exception);
      }
    });
  });
}
