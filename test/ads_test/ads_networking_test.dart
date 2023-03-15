import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Ads/Data/DataSource/ad_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late AdNetworking adsNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      adsNetworking = AdNetworking(helper);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  var listResponse = [
    {
      "id": 2,
      "price": 1.0,
      "negotiable": false,
      "quantity": 1,
      "unit_weight": 1.0,
      "minimal_offerable_quantity": null,
      "notes": null,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e71b3f7640fcee8dc952d19303b03aa7e1c13c53/IMG_20221020_160711.jpg",
      "unit_type": {"unit_type_id": 1, "name_ar": "كيلو جرام", "name_en": "Kg"},
      "category": {"id": 1, "name_ar": "فواكة", "name_en": "fruits"},
      "product": {"product_id": 2, "name_ar": "بطيخ", "name_en": "watermelon"},
      "city": {"id": 1, "name_ar": "جدة", "name_en": "Jeddah"},
      "market": {"id": 1, "name_ar": "سوق جدة", "name_en": "jeddah market"}
    }
  ];

  group('get ads test cases', () {
    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'ad': listResponse},
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: adsUrl))
          .thenAnswer((_) => responseObject);
      var actual = await adsNetworking.getAds();
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: adsUrl))
          .thenThrow(const SocketException("Hello"));
      try {
        await adsNetworking.getAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: adsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.getAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: adsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.getAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: adsUrl)).thenThrow(exception);
      try {
        await adsNetworking.getAds();
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('get my ads test cases', () {
    test('Happy case scenario', () async {
      when(helper.get(headers: headers, url: myAdsUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: {'ad': listResponse},
        );
        res.data = {'ad': listResponse};
        return Future.value(res);
      }));
      var actual = await adsNetworking.getMyAds();
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: myAdsUrl))
          .thenThrow(const SocketException("Hello"));
      try {
        await adsNetworking.getMyAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: myAdsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.getMyAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: myAdsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.getMyAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: myAdsUrl)).thenThrow(exception);
      try {
        await adsNetworking.getMyAds();
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('get ads by categories test cases', () {
    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'ad': listResponse},
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: 'category/1/$adsUrl'))
          .thenAnswer((_) => responseObject);
      var actual = await adsNetworking.getAdsByCategory(1);
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: 'category/1/$adsUrl'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await adsNetworking.getAdsByCategory(1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: 'category/1/$adsUrl'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.getAdsByCategory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: 'category/1/$adsUrl'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.getAdsByCategory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: 'category/1/$adsUrl'))
          .thenThrow(exception);
      try {
        await adsNetworking.getAdsByCategory(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('get ads by category group test cases', () {
    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'ad': listResponse},
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: 'category_groups/1/$adsUrl'))
          .thenAnswer((_) => responseObject);
      var actual = await adsNetworking.getAdsByCategoryGroup(1);
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: 'category_groups/1/$adsUrl'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await adsNetworking.getAdsByCategoryGroup(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: 'category_groups/1/$adsUrl'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.getAdsByCategoryGroup(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: 'category_groups/1/$adsUrl'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.getAdsByCategoryGroup(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: 'category_groups/1/$adsUrl'))
          .thenThrow(exception);
      try {
        await adsNetworking.getAdsByCategoryGroup(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('create ad test cases', () {
    var functionBody = {
      "ad_image": 5, //File('path.png'),
      "commercial_profile_id": 10,
      "broker_id": 31,
      "market_id": 22,
      "category_id": 49,
      "product_id": 14,
      "price": 1.03,
      "negotiable": true,
      "quantity": 1,
      "unit_weight": 1.0,
      "unit_type_id": 12,
      "minimal_offerable_quantity": 1,
      "notes": "THIS AD CREATED WITH POSTMAN"
    };

    var mockBody = {
      'ad': {
        "ad_image": 5, //File('path.png'),
        "commercial_profile_id": 10,
        "broker_id": 31,
        "market_id": 22,
        "category_id": 49,
        "product_id": 14,
        "price": 1.03,
        "negotiable": true,
        "quantity": 1,
        "unit_weight": 1.0,
        "unit_type_id": 12,
        "minimal_offerable_quantity": 1,
        "notes": "THIS AD CREATED WITH POSTMAN"
      }
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'ad': listResponse.first},
      );
      var responseObject = Future.value(res);
      when(helper.postMedia(headers: headers, url: adsUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      expect(
        await adsNetworking.createAd(functionBody),
        listResponse.first,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.postMedia(headers: headers, url: adsUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await adsNetworking.createAd(functionBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.postMedia(headers: headers, url: adsUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await adsNetworking.createAd(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.postMedia(headers: headers, url: adsUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.createAd(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.postMedia(headers: headers, url: adsUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.createAd(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.postMedia(headers: headers, url: adsUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await adsNetworking.createAd(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('get my favoriteAds test cases', () {
    test('Happy case scenario', () async {
      when(helper.get(headers: headers, url: favoriteAdUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: {'ad': listResponse},
        );
        res.data = {'ad': listResponse};
        return Future.value(res);
      }));
      var actual = await adsNetworking.getAllFavoriteAds();
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: favoriteAdUrl))
          .thenThrow(const SocketException("Hello"));
      try {
        await adsNetworking.getAllFavoriteAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: favoriteAdUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.getAllFavoriteAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: favoriteAdUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.getAllFavoriteAds();
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: favoriteAdUrl))
          .thenThrow(exception);
      try {
        await adsNetworking.getAllFavoriteAds();
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('create favoriteAd test cases', () {
    var functionBody = {
      "favorite_ad": {"ad_id": 1}
    };

    var response = {"msg": "Ad has been favorited"};

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(
              headers: headers, url: favoriteAdUrl, body: functionBody))
          .thenAnswer((_) => responseObject);
      expect(
        await adsNetworking.favoriteAd(functionBody),
        response,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(
              headers: headers, url: favoriteAdUrl, body: functionBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await adsNetworking.favoriteAd(functionBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: favoriteAdUrl, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await adsNetworking.favoriteAd(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: favoriteAdUrl, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.favoriteAd(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: favoriteAdUrl, body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.favoriteAd(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(
              headers: headers, url: favoriteAdUrl, body: functionBody))
          .thenThrow(exception);
      try {
        await adsNetworking.favoriteAd(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('unFavoriteAd test cases', () {
    test('Happy case scenario', () async {
      when(helper.delete(
              headers: headers, url: unfavoriteAdUrl + '?ad_id=' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await adsNetworking.unFavoriteAd(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(
              headers: headers, url: unfavoriteAdUrl + '?ad_id=' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await adsNetworking.unFavoriteAd(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(
              headers: headers, url: unfavoriteAdUrl + '?ad_id=' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await adsNetworking.unFavoriteAd(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(
              headers: headers, url: unfavoriteAdUrl + '?ad_id=' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await adsNetworking.unFavoriteAd(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(
              headers: headers, url: unfavoriteAdUrl + '?ad_id=' + '1'))
          .thenThrow(exception);
      try {
        await adsNetworking.unFavoriteAd(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
