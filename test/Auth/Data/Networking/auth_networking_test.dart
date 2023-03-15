import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Authentication/Data/DataSource/auth_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late AuthNetworking authNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json"
  };
  setUp(
    () {
      authNetworking = AuthNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('login test cases', () {
    var response = {
      "access_token":
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Q665Vp7_fwDto0gSF8goIDutZp7anx2ADaZ4MMUQ6UU",
      "id": 1,
      "name": null,
      "mobile": "+966555554444",
      "type": "Admin",
      "confirmed": true
    };

    var mockBody = {
      "session": {"mobile": "+966555554444", "password": "123456"}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      var actual = await authNetworking.login(mockBody);
      expect(actual, response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await authNetworking.login(mockBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('register test cases', () {
    var response = {
      "access_token":
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Q665Vp7_fwDto0gSF8goIDutZp7anx2ADaZ4MMUQ6UU",
      "id": 1,
      "name": null,
      "mobile": "+966555554444",
      "type": "Admin",
      "confirmed": true
    };

    var mockBody = {
      "session": {"mobile": "+966555554444", "password": "123456"}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      var actual = await authNetworking.login(mockBody);
      expect(actual, response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await authNetworking.login(mockBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('verifyUser test cases', () {
    var response = {
      "access_token":
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Q665Vp7_fwDto0gSF8goIDutZp7anx2ADaZ4MMUQ6UU",
      "id": 1,
      "name": null,
      "mobile": "+966555554444",
      "type": "Admin",
      "confirmed": true
    };

    var mockBody = {
      "verification": {"confirmation_token": '123456'}
    };
    String url = authNetworking.verifyEndPoint('farmer', 1);

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: url, body: mockBody))
          .thenAnswer((_) => responseObject);
      var actual = await authNetworking.verifyUser('farmer', 1, mockBody);
      expect(actual, response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await authNetworking.login(mockBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: loginUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await authNetworking.login(mockBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('forgetPassword test cases', () {
    var response = {"mobile": "+966555554444", "reset_password_otp": "945768"};

    var mockBody = {"mobile": "+966555554444"};
    String mobile = '555554444';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: forgetPassUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      var actual = await authNetworking.forgetPassword(mobile);
      expect(actual, response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: forgetPassUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await authNetworking.forgetPassword(mobile);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: forgetPassUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await authNetworking.forgetPassword(mobile);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: forgetPassUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await authNetworking.forgetPassword(mobile);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: forgetPassUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await authNetworking.forgetPassword(mobile);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: forgetPassUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await authNetworking.forgetPassword(mobile);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('verifyOTP test cases', () {
    var response = {
      "reset_password_token":
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX21vYmlsZSI6Iis5NjY1NTU1NTQ0NDQifQ.IeFu9uTnQ8YK3x74WS4HYggRWq4YDhInD-Bw05uDPBA"
    };

    var mockBody = {"mobile": "+966557928165", "reset_password_otp": "83340"};

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: verifyOTPUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      var actual = await authNetworking.verifyOTP(mockBody);
      expect(actual, response);
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: verifyOTPUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await authNetworking.verifyOTP(mockBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: verifyOTPUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await authNetworking.verifyOTP(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: verifyOTPUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await authNetworking.verifyOTP(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: verifyOTPUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await authNetworking.verifyOTP(mockBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: verifyOTPUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await authNetworking.verifyOTP(mockBody);
      } catch (e) {
        expect(e, exception);
      }
    });
  });
}
