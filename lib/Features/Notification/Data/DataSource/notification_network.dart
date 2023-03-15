import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';

abstract class INotificationNetworking {
  Future<dynamic> getAllNotification(int page);
  Future readNotification(int notificationId);
  Future<dynamic> sendFcmToken(Map<String, dynamic> body);
}

class NotificationNetworking implements INotificationNetworking {
  NotificationNetworking(this.networking);
  final NetworkHelper networking;
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future getAllNotification(int page) async {
    try {
      final response = await networking.get(
        url: '$notificationUrl?page=$page',
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future readNotification(int notificationId) async {
    try {
      final response = await networking.patch(
        url: '$notificationUrl/$notificationId',
        headers: headers(),
      );
      return response.data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future sendFcmToken (Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: '$firebaseSessionUrl/',
        headers: headers(),
        body: body,
      );
      return response.data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }
}
