import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../../App/Errors/exceptions.dart';
import '../../../../../../../App/Network/network_helper.dart';
import '../../../../../../../App/Network/network_routes.dart';

abstract class IOffersNetworking {
  Future<dynamic> addOffer(Map<String, dynamic> body, int convId);
  Future<dynamic> showConversations(int convId);
  Future<dynamic> getConversationsByOrder(int orderId);
  Future<dynamic> acceptOffer(Map<String, dynamic> body, int offerId);
  Future<dynamic> rejectOffer(Map<String, dynamic> body, int offerId);
}

class OffersNetworking implements IOffersNetworking {
  final NetworkHelper networking;
  OffersNetworking(this.networking);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> addOffer(Map<String, dynamic> body, int convId) async {
    try {
      final response = await networking.post(
        url: conversationUrl + "/$convId/" + offersUrl,
        headers: headers(),
        body: body,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getConversationsByOrder(int orderId) async {
    try {
      final response = await networking.get(
        url: '$ordersUrl/$orderId/$conversationUrl',
        headers: headers(),
      );
      var data = response.data['conversations'];
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> showConversations(int convId) async {
    try {
      final response = await networking.get(
        url: "$conversationUrl/$convId",
        headers: headers(),
      );
      var data = response.data['conversation'];
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> acceptOffer(Map<String, dynamic> body, int offerId) async {
    try {
      final response = await networking.patch(
        url: '$offersUrl/$offerId/approve_offer',
        headers: headers(),
        body: body,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> rejectOffer(Map<String, dynamic> body, int offerId) async {
    try {
      final response = await networking.patch(
        url: '$offersUrl/$offerId/reject_offer',
        headers: headers(),
        body: body,
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        } else if (e.response!.statusCode == 401) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }
}
