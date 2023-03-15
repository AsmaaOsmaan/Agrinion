import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Account/Data/DataSource/profile_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late ProfileNetworking profileNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      profileNetworking = ProfileNetworking(helper);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );

  group('post resetPassword test cases', () {
    var functionBody = {"old_password": "000000"};
    var response = {"reset_password_token": "..lll"};

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(
              headers: headers, url: resetPasswordUrl, body: functionBody))
          .thenAnswer((_) => responseObject);
      var actual = await profileNetworking.resetPassword(functionBody);
      expect(actual, response);
    });

    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: resetPasswordUrl, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await profileNetworking.resetPassword(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });

    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: resetPasswordUrl, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await profileNetworking.resetPassword(functionBody);
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
              headers: headers, url: resetPasswordUrl, body: functionBody))
          .thenThrow(exception);
      try {
        await profileNetworking.resetPassword(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('post setNewPassword test cases', () {
    var functionBody = {
      "password": {
        "password_verification_otp":
            "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2LCJ1c2VyX21vYmlsZSI6Iis5NjY1NTc5MjgxNjUifQ.89B9bO7_ku9lRwrlZ1ivoUDqYGKsDzOnVoYdYODhJJ0",
        "password": "000000",
        "password_confirmation": "000000"
      }
    };
    var response = {"msg": "Password has been updated"};

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(
              headers: headers, url: setPasswordUrl, body: functionBody))
          .thenAnswer((_) => responseObject);
      var actual = await profileNetworking.setPassword(functionBody);
      expect(actual, response);
    });

    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: setPasswordUrl, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await profileNetworking.setPassword(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });

    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: setPasswordUrl, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await profileNetworking.setPassword(functionBody);
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
              headers: headers, url: setPasswordUrl, body: functionBody))
          .thenThrow(exception);
      try {
        await profileNetworking.setPassword(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
