import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Notification/Data/DataSource/notification_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late NotificationNetworking notificationNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };

  setUp(
    () {
      notificationNetworking = NotificationNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );

  group('get notification test cases', () {
    test('Happy case scenario', () async {
      var response = {
        "notifications": [
          {
            "id": 13,
            "user_id": 1,
            "message": "you have a new like on your post",
            "read?": false,
            "read_at": null,
            "created_at": "2023-01-30T09:41:59.212Z",
            "notifiable_id": 4,
            "notifiable_type": "Like",
            "notification_handler": "like_on_post"
          },
        ],
        "pagination_data": {
          "current_page": 2,
          "total_count": 2,
          "total_pages": 2,
        },
      };
      when(helper.get(headers: headers, url: '$notificationUrl?page=2'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await notificationNetworking.getAllNotification(2);

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$notificationUrl/2/2'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await notificationNetworking.getAllNotification(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$notificationUrl/2/2'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await notificationNetworking.getAllNotification(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: '$notificationUrl/2/2'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await notificationNetworking.getAllNotification(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: '$notificationUrl/2/2'))
          .thenThrow(exception);
      try {
        await notificationNetworking.getAllNotification(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('read notification test cases', () {
    var response = {"msg": "Notification has been read"};
    String url = '$notificationUrl/1';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.patch(headers: headers, url: url))
          .thenAnswer((_) => responseObject);
      var actual = await notificationNetworking.readNotification(1);
      expect(actual, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(headers: headers, url: url))
          .thenThrow(const SocketException("HEllo"));
      try {
        await notificationNetworking.readNotification(1);
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
        await notificationNetworking.readNotification(1);
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
        await notificationNetworking.readNotification(1);
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
        await notificationNetworking.readNotification(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
