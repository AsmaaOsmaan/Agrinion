import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_helper.dart';
import 'package:dio/dio.dart';

import '../../../../../../../App/Errors/exceptions.dart';
import '../../../../../../../App/Network/network_routes.dart';

abstract class IBorkerToMarketRequestsNetworking {
  Future<dynamic> getRequestsByStatus(String status);
  Future<void> approveRequest(int id);
  Future<void> rejectRequest(int id, Map<String, dynamic> reasonModel);
  Future<dynamic> cancelRequest(int id);
  Future<dynamic> unLinkRequest(int id);
  Future showSpecificBrokersMarketRequest(int id);
}

class BrokerToMarketRequestsNetworking
    implements IBorkerToMarketRequestsNetworking {
  final NetworkHelper _helper;
  BrokerToMarketRequestsNetworking(this._helper);
  Map<String, String> _headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future getRequestsByStatus(String status) async {
    try {
      final response = await _helper.get(
        url: '$brokerRequestsUrl?status=$status',
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
        url: '$brokerRequestsUrl/$id/approve_request',
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
  Future<dynamic> rejectRequest(
      int id, Map<String, dynamic> reasonModel) async {
    try {
      final response = await _helper.patch(
          url: '$brokerRequestsUrl/$id/reject_request',
          headers: _headers(),
          body: reasonModel);
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
        url: '$brokerRequestsUrl/$id/unlink',
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
        url: '$brokerRequestsUrl/$id/cancel_request',
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
  Future showSpecificBrokersMarketRequest(int id) async {
    try {
      final response = await _helper.get(
        url: brokerRequestsUrl+'/$id',
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
}
