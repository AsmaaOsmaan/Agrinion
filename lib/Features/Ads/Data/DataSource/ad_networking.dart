import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Network/network_helper.dart';
import 'package:dio/dio.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_routes.dart';

abstract class IAdNetworking {
  Future<dynamic> getAds();
  Future<dynamic> getMyAds();
  Future<dynamic> getAdsByCategory(int categoryId);
  Future<dynamic> getAdsByCategoryGroup(int categoryGroupId);
  Future<dynamic> createAd(Map<String, dynamic> body);
  Future<dynamic> filterAds(String filters);
  Future<dynamic> updateAd(Map<String, dynamic> body, int adId);
  Future<dynamic> deleteAd(int adId);
  Future<dynamic> showAdDetails(int adId);
  Future<dynamic> favoriteAd(Map<String, dynamic> body);
  Future<dynamic> unFavoriteAd(int adId);
  Future<dynamic> getAllFavoriteAds();
}

class AdNetworking extends IAdNetworking {
  NetworkHelper helper;
  AdNetworking(this.helper);
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> createAd(Map<String, dynamic> body) async {
    try {
      var newVariable = await helper.postMedia(
          url: adsUrl, body: {'ad': body}, headers: headers());
      return newVariable.data['ad'];
    } catch (e) {
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
  Future<dynamic> favoriteAd(Map<String, dynamic> body) async {
    try {
      var response =
          await helper.post(url: favoriteAdUrl, body: body, headers: headers());

      return response.data;
    } catch (e) {
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
  Future<dynamic> unFavoriteAd(int adId) async {
    try {
      final response = await helper.delete(
        url: '$unfavoriteAdUrl?ad_id=$adId',
        headers: headers(),
      );
      return response;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getAllFavoriteAds() async {
    try {
      final response = await helper.get(
        url: favoriteAdUrl,
        headers: headers(),
      );
      var data = response.data;
      return data['ad'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getAds() async {
    try {
      final response = await helper.get(url: adsUrl, headers: headers());
      var data = response.data['ad'];
      return data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getMyAds() async {
    try {
      final response = await helper.get(url: myAdsUrl, headers: headers());

      var data = response.data['ad'];
      return data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getAdsByCategory(int categoryId) async {
    try {
      final response = await helper.get(
        url: adsByCategoryIdUrl(categoryId),
        headers: headers(),
      );

      var data = response.data['ad'];
      return data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> filterAds(String filters) async {
    try {
      final response = await helper.get(
        url: '$filterAdsUrl?$filters',
        headers: headers(),
      );
      var data = response.data;
      return data['ad'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  String adsByCategoryIdUrl(int categoryId) =>
      '$categoriesUrl/$categoryId/$adsUrl';

  @override
  Future<dynamic> getAdsByCategoryGroup(int categoryGroupId) async {
    try {
      final response = await helper.get(
        url: adsByCategoryGroupUrl(categoryGroupId),
        headers: headers(),
      );
      var data = response.data['ad'];
      return data;
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  String adsByCategoryGroupUrl(int categoryGroupId) =>
      'category_groups/$categoryGroupId/$adsUrl';

  @override
  Future<dynamic> deleteAd(int adId) async {
    try {
      await helper.delete(url: '$adsUrl/$adId', headers: headers());
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
        if (e.response!.statusCode == 401) {
          throw UnAuthorizeException(message: e.message);
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> showAdDetails(int adId) async {
    try {
      final response =
          await helper.get(url: '$adsUrl/$adId', headers: headers());
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
  Future updateAd(Map<String, dynamic> body, int adId) async {
    try {
      final response = await helper.patch(
          url: '$adsUrl/$adId', headers: headers(), body: body);
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
