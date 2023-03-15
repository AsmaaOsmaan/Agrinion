import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../App/Errors/exceptions.dart';
import '../../../../../../../../App/Network/network_helper.dart';

abstract class IBrokerManagementNetworking {
  Future<dynamic> assignBrokerToMarket(Map<String, dynamic> body);
  Future<dynamic> getBrokerMarkets(int brokerId);
  Future<dynamic> unLinkBrokerMarket(int brokerId, int marketId);
  Future<dynamic> getUnlikedBrokerMarkets(int brokerId, int cityId);
}

class BrokerManagementNetworking implements IBrokerManagementNetworking {
  BrokerManagementNetworking(this.networking);
  final NetworkHelper networking;
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),


      };

  @override
  Future<dynamic> assignBrokerToMarket(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: brokerMarketRequest,
        headers: headers(),
        body: body,
      );

      var data = response.data;
      return data;
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
  Future<dynamic> getBrokerMarkets(int brokerId) async {
    try {
      final response = await networking.get(
        url: '$marketsUrl/$brokerMarketsUrl?broker_id=$brokerId',
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
  Future<dynamic> unLinkBrokerMarket(int brokerId, int marketId) async {
    try {
      final response = await networking.patch(
        url: getUnLinkBrokerMarketUrl(brokerId, marketId),
        headers: headers(),
      );
      return response.data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 401) {
          throw UnAuthorizeException();
        }
        if (e.response!.statusCode == 422 ) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  String getUnLinkBrokerMarketUrl(int brokerId, int marketId) {
    String url =
        '$marketsUrl/$unlinkBrokerMarketUrl?broker_id=$brokerId&market_id=$marketId';
    return url;
  }

  @override
  Future<dynamic> getUnlikedBrokerMarkets(int brokerId, int cityId) async {
    try {
      final response = await networking.get(
        url: getUnlinkedMarketsUrl(brokerId, cityId),
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      }
    }
  }

  String getUnlinkedMarketsUrl(int brokerId, int cityId) {
    String url =
        "$marketsUrl/$unlinkedBrokerMarketUrl?broker_id=$brokerId&city_id=$cityId";
    return url;
  }
}
