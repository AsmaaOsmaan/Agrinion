import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/News/Data/DataSource/news_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper mockHelper = MockNetworkHelper();
  late NewsNetworking _networking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.uCYgbgK7ss_IGq_6nOQ38-4TAdCyZQO-eXf3pvcRYCQ'
  };

  setUp(
    () {
      _networking = NewsNetworking(mockHelper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );

  group('create news test cases', () {
    var functionBody = {
      "title_ar": "news title in arabic",
      "title_en": "news title in english",
      "body_ar": "news body in arabic",
      "body_en": "news body in english",
      "published": true,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI"
              "6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--05a640e"
              "2a1de1539f64949a971441a1f02cbd8d1/IMG_20230124_141923.jpg"
    };

    var mockBody = {
      "title_ar": "news title in arabic",
      "title_en": "news title in english",
      "body_ar": "news body in arabic",
      "body_en": "news body in english",
      "published": true,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI"
              "6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--05a640e"
              "2a1de1539f64949a971441a1f02cbd8d1/IMG_20230124_141923.jpg"
    };

    var response = {
      "id": 7,
      "creator_id": 1,
      "title_ar": "news title in arabic",
      "title_en": "news title in english",
      "body_ar": "news body in arabic",
      "body_en": "news body in english",
      "published": true,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93e48b8983aaad8e253a075b9088859b1dbbc118/IMG_20230124_141923.jpg",
      "created_at": "2023-02-01T17:16:23.120Z",
      "updated_at": "2023-02-01T17:16:23.149Z"
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(mockHelper.postMedia(headers: headers, url: newsUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.createNews(functionBody),
        response,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(mockHelper.postMedia(headers: headers, url: newsUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await _networking.createNews(functionBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(mockHelper.postMedia(headers: headers, url: newsUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.createNews(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mockHelper.postMedia(headers: headers, url: newsUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.createNews(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mockHelper.postMedia(headers: headers, url: newsUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.createNews(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mockHelper.postMedia(headers: headers, url: newsUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await _networking.createNews(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('list all news test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 7,
          "creator_id": 1,
          "title_ar": "news title in arabic",
          "title_en": "news title in english",
          "body_ar": "news body in arabic",
          "body_en": "news body in english",
          "published": true,
          "image":
              "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93e48b8983aaad8e253a075b9088859b1dbbc118/IMG_20230124_141923.jpg",
          "created_at": "2023-02-01T17:16:23.120Z",
          "updated_at": "2023-02-01T17:16:23.149Z"
        },
      ];
      when(mockHelper.get(headers: headers, url: newsUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await _networking.listAllNews();

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: newsUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.listAllNews();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: newsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.listAllNews();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: newsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.listAllNews();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mockHelper.get(headers: headers, url: newsUrl)).thenThrow(exception);
      try {
        await _networking.listAllNews();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('list all news for home screen test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 7,
          "creator_id": 1,
          "title_ar": "news title in arabic",
          "title_en": "news title in english",
          "body_ar": "news body in arabic",
          "body_en": "news body in english",
          "published": true,
          "image":
              "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93e48b8983aaad8e253a075b9088859b1dbbc118/IMG_20230124_141923.jpg",
          "created_at": "2023-02-01T17:16:23.120Z",
          "updated_at": "2023-02-01T17:16:23.149Z"
        },
      ];
      when(mockHelper.get(headers: headers, url: newsUrl + '?is_home=true'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await _networking.homeListAllNews();

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: newsUrl + '?is_home=true'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.homeListAllNews();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: newsUrl + '?is_home=true'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.homeListAllNews();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: newsUrl + '?is_home=true'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.homeListAllNews();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mockHelper.get(headers: headers, url: newsUrl + '?is_home=true'))
          .thenThrow(exception);
      try {
        await _networking.homeListAllNews();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('show specific news test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 7,
          "creator_id": 1,
          "title_ar": "news title in arabic",
          "title_en": "news title in english",
          "body_ar": "news body in arabic",
          "body_en": "news body in english",
          "published": true,
          "image":
              "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93e48b8983aaad8e253a075b9088859b1dbbc118/IMG_20230124_141923.jpg",
          "created_at": "2023-02-01T17:16:23.120Z",
          "updated_at": "2023-02-01T17:16:23.149Z"
        },
      ];
      when(mockHelper.get(headers: headers, url: '$newsUrl/2'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await _networking.showSpecificNews(2);

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: '$newsUrl/2'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.showSpecificNews(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: '$newsUrl/2'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.showSpecificNews(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mockHelper.get(headers: headers, url: '$newsUrl/2'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.showSpecificNews(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mockHelper.get(headers: headers, url: '$newsUrl/2'))
          .thenThrow(exception);
      try {
        await _networking.showSpecificNews(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('edit news test cases', () {
    var functionBody = {
      "title_ar": "news title in arabic",
      "title_en": "news title in english",
      "body_ar": "news body in arabic",
      "body_en": "news body in english",
      "published": true,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI"
              "6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--05a640e"
              "2a1de1539f64949a971441a1f02cbd8d1/IMG_20230124_141923.jpg"
    };

    var mockBody = {
      "title_ar": "news title in arabic",
      "title_en": "news title in english",
      "body_ar": "news body in arabic",
      "body_en": "news body in english",
      "published": true,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI"
              "6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--05a640e"
              "2a1de1539f64949a971441a1f02cbd8d1/IMG_20230124_141923.jpg"
    };

    var response = {
      "id": 7,
      "creator_id": 1,
      "title_ar": "news title in arabic",
      "title_en": "news title in english",
      "body_ar": "news body in arabic",
      "body_en": "news body in english",
      "published": true,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--93e48b8983aaad8e253a075b9088859b1dbbc118/IMG_20230124_141923.jpg",
      "created_at": "2023-02-01T17:16:23.120Z",
      "updated_at": "2023-02-01T17:16:23.149Z"
    };
    test('Happy case scenario', () async {
      when(mockHelper.patchMedia(
        headers: headers,
        url: '$newsUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(await _networking.editNews(functionBody, 1), response);
    });
    test('SocketException Bad case scenario', () async {
      when(mockHelper.patchMedia(
              headers: headers, url: '$newsUrl/1', body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.editNews(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mockHelper.patchMedia(
              headers: headers, url: '$newsUrl/1', body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.editNews(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mockHelper.patchMedia(
              headers: headers, url: '$newsUrl/1', body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.editNews(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mockHelper.patchMedia(
              headers: headers, url: '$newsUrl/1', body: mockBody))
          .thenThrow(exception);
      try {
        await _networking.editNews(functionBody, 1);
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('delete news test cases', () {
    test('Happy case scenario', () async {
      when(mockHelper.delete(headers: headers, url: newsUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await _networking.deleteNews(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(mockHelper.delete(headers: headers, url: newsUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.deleteNews(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(mockHelper.delete(headers: headers, url: newsUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.deleteNews(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(mockHelper.delete(headers: headers, url: newsUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.deleteNews(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(mockHelper.delete(headers: headers, url: newsUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await _networking.deleteNews(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
