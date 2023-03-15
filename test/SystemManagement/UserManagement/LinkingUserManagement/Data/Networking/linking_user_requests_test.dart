import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/DataSource/linking_user_requests_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late LinkingUserRequestsNetworking _networking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      _networking = LinkingUserRequestsNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('get requests by status test cases', () {
    var url = '$linkingUserRequests?status=approved';

    test('Happy case scenario', () async {
      var response = {
        [
          {
            'id': 36,
            'status': 'pending',
            "user": {"id": 5, "name": " Vernell Baumbach"},
            "linked_user": {"id": 4, "name": "Dr. Gino Wolf"}
          }
        ]
      };

      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: url))
          .thenAnswer((_) => responseObject);
      var actual = await _networking.getRequestsByStatus("approved");
      expect(actual, response);
    });

    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.getRequestsByStatus('approved');
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: url))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.getRequestsByStatus('approved');
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: url))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.getRequestsByStatus('approved');
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: url)).thenThrow(exception);
      try {
        await _networking.getRequestsByStatus('approved');
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('approve request test cases', () {
    var response = {
      'id': 36,
      'status': 'pending',
      "user": {"id": 5, "name": " Vernell Baumbach"},
      "linked_user": {"id": 4, "name": "Dr. Gino Wolf"}
    };
    String url = '$linkingUserRequests/1/approve_request';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.patch(headers: headers, url: url))
          .thenAnswer((_) => responseObject);
      var actual = await _networking.approveRequest(1);
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
      var actual = await _networking.approveRequest(1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.approveRequest(1);
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
        await _networking.approveRequest(1);
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
        await _networking.approveRequest(1);
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
        await _networking.approveRequest(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('reject request test cases', () {
    // var  reasonModel={
    //   "request": {
    //     "rejection_reason": "text" //required
    //   }
    // };

    var response = {
      'id': 36,
      'status': 'pending',
      "user": {"id": 5, "name": " Vernell Baumbach"},
      "linked_user": {"id": 4, "name": "Dr. Gino Wolf"}
    };
    String url = '$linkingUserRequests/1/reject_request';
    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.patch(headers: headers, url: url))
          .thenAnswer(((realInvocation) {
        return responseObject;
      }));
      expect(await _networking.rejectRequest(1), response);
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
      var actual = await _networking.rejectRequest(1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.rejectRequest(1);
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
        await _networking.rejectRequest(1);
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
        await _networking.rejectRequest(1);
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
        await _networking.rejectRequest(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('unlink request test cases', () {
    var response = {
      'id': 36,
      'status': 'pending',
      "user": {"id": 5, "name": " Vernell Baumbach"},
      "linked_user": {"id": 4, "name": "Dr. Gino Wolf"}
    };
    String url = '$linkingUserRequests/1/unlink_user';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.patch(headers: headers, url: url))
          .thenAnswer((_) => responseObject);
      var actual = await _networking.unLinkRequest(1);
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
      var actual = await _networking.unLinkRequest(1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.unLinkRequest(1);
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
        await _networking.unLinkRequest(1);
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
        await _networking.unLinkRequest(1);
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
        await _networking.unLinkRequest(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('cancel request test cases', () {
    var response = {
      'id': 36,
      'status': 'pending',
      "user": {"id": 5, "name": " Vernell Baumbach"},
      "linked_user": {"id": 4, "name": "Dr. Gino Wolf"}
    };
    String url = '$linkingUserRequests/1/cancel_request';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.patch(headers: headers, url: url))
          .thenAnswer((_) => responseObject);
      var actual = await _networking.cancelRequest(1);
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
      var actual = await _networking.cancelRequest(1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.cancelRequest(1);
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
        await _networking.cancelRequest(1);
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
        await _networking.cancelRequest(1);
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
        await _networking.cancelRequest(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
