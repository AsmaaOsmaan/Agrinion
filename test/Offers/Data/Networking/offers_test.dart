import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Offers/Data/DataSourse/offers_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late OffersNetworking offersNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      offersNetworking = OffersNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('get Conversation by order test cases', () {
    test('Happy case scenario', () async {
      var conversationsList = List.generate(
        1,
        (index) => {
          "id": 1,
          "order_id": 1,
          "ad_id": 1,
          "ad": {},
          "last_offer": {},
          "seller_group": [],
          "buyer_group": []
        },
      );
      var response = {"conversations": conversationsList};

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: '$ordersUrl/1/$conversationUrl'))
          .thenAnswer((_) => responseObject);
      var actual = await offersNetworking.getConversationsByOrder(1);
      expect(actual, conversationsList);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$ordersUrl/1/$conversationUrl'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await offersNetworking.getConversationsByOrder(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$ordersUrl/1/$conversationUrl'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await offersNetworking.getConversationsByOrder(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$ordersUrl/1/$conversationUrl'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await offersNetworking.getConversationsByOrder(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: '$ordersUrl/1/$conversationUrl'))
          .thenThrow(exception);
      try {
        await offersNetworking.getConversationsByOrder(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('show Conversation test cases', () {
    test('Happy case scenario', () async {
      var conversation = {
        "id": 1,
        "order_id": 1,
        "ad_id": 1,
        "ad": {},
        "last_offer": {},
        "seller_group": [],
        "buyer_group": []
      };

      var response = {"conversation": conversation};

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: "$conversationUrl/1"))
          .thenAnswer((_) => responseObject);
      var actual = await offersNetworking.showConversations(1);
      expect(actual, conversation);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: "$conversationUrl/1"))
          .thenThrow(const SocketException("HEllo"));
      try {
        await offersNetworking.showConversations(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: "$conversationUrl/1"))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await offersNetworking.showConversations(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: "$conversationUrl/1"))
          .thenThrow(const HttpException("HEllo"));
      try {
        await offersNetworking.showConversations(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: "$conversationUrl/1"))
          .thenThrow(exception);
      try {
        await offersNetworking.showConversations(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('add offer to conversation test cases', () {
    var functionBody = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": 1,
    };
    var response = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": 1,
      "ad_id": 1,
      "minimal_offerable_quantity": 1,
      "remaining_quantity": 1,
      "id": 1,
    };
    test('Happy case scenario', () async {
      when(helper.post(
        headers: headers,
        url: '$conversationUrl/1/$offersUrl',
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await offersNetworking.addOffer(functionBody, 1), response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(
        headers: headers,
        url: '$conversationUrl/1/$offersUrl',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await offersNetworking.addOffer(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('authentication fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(helper.post(
        headers: headers,
        url: '$conversationUrl/1/$offersUrl',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await offersNetworking.addOffer(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers,
              url: '$conversationUrl/1/$offersUrl',
              body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await offersNetworking.addOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers,
              url: '$conversationUrl/1/$offersUrl',
              body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await offersNetworking.addOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(
              headers: headers,
              url: '$conversationUrl/1/$offersUrl',
              body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await offersNetworking.addOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(
              headers: headers,
              url: '$conversationUrl/1/$offersUrl',
              body: functionBody))
          .thenThrow(exception);
      try {
        await offersNetworking.addOffer(functionBody, 1);
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('accept offer test cases', () {
    var functionBody = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": 1,
    };
    var response = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": 1,
      "ad_id": 1,
      "minimal_offerable_quantity": 1,
      "remaining_quantity": 1,
      "id": 1,
    };
    test('Happy case scenario', () async {
      when(helper.patch(
        headers: headers,
        url: '$offersUrl/1/approve_offer',
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await offersNetworking.acceptOffer(functionBody, 1), response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.patch(
        headers: headers,
        url: '$offersUrl/1/approve_offer',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await offersNetworking.acceptOffer(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('authentication fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(helper.patch(
        headers: headers,
        url: '$offersUrl/1/approve_offer',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await offersNetworking.acceptOffer(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/approve_offer',
              body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await offersNetworking.acceptOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/approve_offer',
              body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await offersNetworking.acceptOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/approve_offer',
              body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await offersNetworking.acceptOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/approve_offer',
              body: functionBody))
          .thenThrow(exception);
      try {
        await offersNetworking.acceptOffer(functionBody, 1);
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('reject offer test cases', () {
    var functionBody = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": 1,
    };
    var response = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": 1,
      "ad_id": 1,
      "minimal_offerable_quantity": 1,
      "remaining_quantity": 1,
      "id": 1,
    };
    test('Happy case scenario', () async {
      when(helper.patch(
        headers: headers,
        url: '$offersUrl/1/reject_offer',
        body: functionBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await offersNetworking.rejectOffer(functionBody, 1), response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.patch(
        headers: headers,
        url: '$offersUrl/1/reject_offer',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await offersNetworking.rejectOffer(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('authentication fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 401,
      );
      when(helper.patch(
        headers: headers,
        url: '$offersUrl/1/reject_offer',
        body: functionBody,
      )).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await offersNetworking.rejectOffer(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/reject_offer',
              body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await offersNetworking.rejectOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/reject_offer',
              body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await offersNetworking.rejectOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/reject_offer',
              body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await offersNetworking.rejectOffer(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(
              headers: headers,
              url: '$offersUrl/1/reject_offer',
              body: functionBody))
          .thenThrow(exception);
      try {
        await offersNetworking.rejectOffer(functionBody, 1);
      } catch (e) {
        expect(e, exception);
      }
    });
  });
}
