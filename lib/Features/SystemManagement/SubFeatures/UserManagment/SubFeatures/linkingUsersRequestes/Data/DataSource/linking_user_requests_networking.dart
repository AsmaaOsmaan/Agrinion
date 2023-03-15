import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

abstract class ILinkingUserRequestsNetworking {
  Future<dynamic> createLinkingUserRequest(Map<String, dynamic> body);
  Future<dynamic> getRequestsByStatus(String status);
  Future<dynamic> getAllRequests();
  Future<dynamic> getBrokerStatus();
  Future<void> approveRequest(int id);
  Future<void> rejectRequest(int id);
  Future<dynamic> cancelRequest(int id);
  Future<dynamic> unLinkRequest(int id);
  Future showLinkingUserRequest(int id);
}

class LinkingUserRequestsNetworking implements ILinkingUserRequestsNetworking {
  final NetworkHelper _helper;
  LinkingUserRequestsNetworking(this._helper);
  Map<String, String> _headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> createLinkingUserRequest(Map<String, dynamic> body) async {
    try {
      final response = await _helper.post(
        url: linkingUserRequests,
        headers: _headers(),
        body: body,
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
  Future getBrokerStatus() async {
    try {
      final response = await _helper.get(
        url: brokerStatus,
        headers: _headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  @override
  Future showLinkingUserRequest(int id) async {
    try {
      final response = await _helper.get(
        url: linkingUserRequests + '/$id',
        headers: _headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  @override
  Future getRequestsByStatus(String status) async {
    try {
      final response = await _helper.get(
        url: '$linkingUserRequests?status=$status',
        headers: _headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  @override
  Future getAllRequests() async {
    try {
      final response = await _helper.get(
        url: linkingUserRequests,
        headers: _headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  @override
  Future<dynamic> approveRequest(int id) async {
    try {
      final response = await _helper.patch(
        url: '$linkingUserRequests/$id/approve_request',
        headers: _headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> unLinkRequest(int id) async {
    try {
      final response = await _helper.patch(
        url: '$linkingUserRequests/$id/unlink_user',
        headers: _headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> cancelRequest(int id) async {
    try {
      final response = await _helper.patch(
        url: '$linkingUserRequests/$id/cancel_request',
        headers: _headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> rejectRequest(int id) async {
    try {
      final response = await _helper.patch(
        url: '$linkingUserRequests/$id/reject_request',
        headers: _headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }
}
