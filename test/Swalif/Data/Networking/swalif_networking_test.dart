import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Swalif/Data/DataSource/swalif_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late SwalifNetworking _networking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      _networking = SwalifNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );

  var listResponse = [
    {
      "id": 5,
      "body": "sssaaaaaaa",
      "creator": {"id": 13, "name": "Mr. Priscila Crona", "type": "Merchant"},
      "likes_count": 1,
      "comments_count": 0,
      "liked?": true,
      "created_at": "2023-01-16T14:35:47.644Z",
      "updated_at": "2023-01-16T14:35:47.644Z",
      "updated?": false
    },
  ];

  group('get posts test cases', () {
    var postsUrl = swalifUrl + '?posts=all';

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'posts': listResponse},
      );
      var responseObject = Future.value(res);
      when(helper.get(headers: headers, url: postsUrl))
          .thenAnswer((_) => responseObject);
      var actual = await _networking.getAllSwalifPosts('all');
      expect(actual, listResponse);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: postsUrl))
          .thenThrow(const SocketException("Hello"));
      try {
        await _networking.getAllSwalifPosts('all');
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: adsUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.getAllSwalifPosts('all');
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: postsUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.getAllSwalifPosts('all');
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: postsUrl)).thenThrow(exception);
      try {
        await _networking.getAllSwalifPosts('all');
      } catch (e) {
        expect(e, exception);
      }
    });
  });

  group('create post test cases', () {
    var functionBody = {
      "post": {"body": "Hello this is a swalif post body"}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'post': listResponse.first},
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: swalifUrl, body: functionBody))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.addSwalifPost(functionBody),
        listResponse.first,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: swalifUrl, body: functionBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await _networking.addSwalifPost(functionBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.postMedia(
              headers: headers, url: swalifUrl, body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.addSwalifPost(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.postMedia(
              headers: headers, url: swalifUrl, body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.addSwalifPost(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.postMedia(
              headers: headers, url: swalifUrl, body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.addSwalifPost(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.postMedia(
              headers: headers, url: swalifUrl, body: functionBody))
          .thenThrow(exception);
      try {
        await _networking.addSwalifPost(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('like post test cases', () {
    var likeUrl = '$swalifUrl/2/$likesUrl';
    var response = {"msg": "post has been likeded"};

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.likeSwalifPost(2),
        response,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: likeUrl, body: {})).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await _networking.likeSwalifPost(2);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.likeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.likeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.likeSwalifPost(2);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(exception);
      try {
        await _networking.likeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('dislike post test cases', () {
    var likeUrl = '$swalifUrl/2/$likesUrl';

    test('Happy case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await _networking.disLikeSwalifPost(2),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.disLikeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.disLikeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.disLikeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(headers: headers, url: likeUrl)).thenThrow(exception);
      try {
        await _networking.disLikeSwalifPost(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('update post test cases', () {
    var functionBody = {
      "post": {"body": "Hello this is a swalif post body"}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'post': listResponse.first},
      );
      var responseObject = Future.value(res);
      when(helper.patch(
              headers: headers, url: swalifUrl + '/4', body: functionBody))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.updateSwalifPost(functionBody, 4),
        listResponse.first,
      );
    });

    test('SocketException Bad case scenario', () async {
      when(helper.patch(
              headers: headers, url: swalifUrl + '/4', body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.updateSwalifPost(functionBody, 4);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(
              headers: headers, url: swalifUrl + '/4', body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.updateSwalifPost(functionBody, 4);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(
              headers: headers, url: swalifUrl + '/4', body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.updateSwalifPost(functionBody, 4);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(
              headers: headers, url: swalifUrl + '/4', body: functionBody))
          .thenThrow(exception);
      try {
        await _networking.updateSwalifPost(functionBody, 4);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete post test cases', () {
    test('Happy case scenario', () async {
      when(helper.delete(headers: headers, url: swalifUrl + '/4'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await _networking.deleteSwalifPost(4),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: swalifUrl + '/4'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.deleteSwalifPost(4);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: swalifUrl + '/4'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.deleteSwalifPost(4);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: swalifUrl + '/4'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.deleteSwalifPost(4);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(headers: headers, url: swalifUrl + '/4'))
          .thenThrow(exception);
      try {
        await _networking.deleteSwalifPost(4);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('create comment test cases', () {
    var functionBody = {
      "comment": {"body": "Hello this is a swalif post body"}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'comment': listResponse.first},
      );
      var responseObject = Future.value(res);
      when(helper.post(
              headers: headers,
              url: '$swalifUrl/1/$commentsUrl',
              body: functionBody))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.createComment(functionBody, 1),
        listResponse.first,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(
              headers: headers,
              url: '$swalifUrl/1/$commentsUrl',
              body: functionBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await _networking.createComment(functionBody, 1);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.postMedia(
              headers: headers,
              url: '$swalifUrl/1/$commentsUrl',
              body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.createComment(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.postMedia(
              headers: headers,
              url: '$swalifUrl/1/$commentsUrl',
              body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.createComment(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.postMedia(
              headers: headers,
              url: '$swalifUrl/1/$commentsUrl',
              body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.createComment(functionBody, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.postMedia(
              headers: headers,
              url: '$swalifUrl/1/$commentsUrl',
              body: functionBody))
          .thenThrow(exception);
      try {
        await _networking.createComment(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('like comment test cases', () {
    var likeUrl = '$commentsUrl/2/$likesUrl';
    var response = {"msg": "post has been likeded"};

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.likeComment(2),
        response,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.post(headers: headers, url: likeUrl, body: {})).thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await _networking.likeComment(2);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.likeComment(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.likeComment(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.likeComment(2);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(headers: headers, url: likeUrl, body: {}))
          .thenThrow(exception);
      try {
        await _networking.likeComment(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('dislike comment test cases', () {
    var likeUrl = '$commentsUrl/2/$likesUrl';

    test('Happy case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await _networking.disLikeComment(2),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.disLikeComment(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.disLikeComment(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: likeUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.disLikeComment(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(headers: headers, url: likeUrl)).thenThrow(exception);
      try {
        await _networking.disLikeComment(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('update comment test cases', () {
    var functionBody = {
      "comment": {"body": "Hello this is a swalif post body"}
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {'comment': listResponse.first},
      );
      var responseObject = Future.value(res);
      when(helper.patch(
              headers: headers,
              url: '$swalifUrl/4/$commentsUrl/1',
              body: functionBody))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.updateComment(functionBody, 4, 1),
        listResponse.first,
      );
    });

    test('SocketException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$swalifUrl/4/$commentsUrl/1',
              body: functionBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.updateComment(functionBody, 4, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$swalifUrl/4/$commentsUrl/1',
              body: functionBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.updateComment(functionBody, 4, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(
              headers: headers,
              url: '$swalifUrl/4/$commentsUrl/1',
              body: functionBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.updateComment(functionBody, 4, 1);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(
              headers: headers,
              url: '$swalifUrl/4/$commentsUrl/1',
              body: functionBody))
          .thenThrow(exception);
      try {
        await _networking.updateComment(functionBody, 4, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete comment test cases', () {
    test('Happy case scenario', () async {
      when(helper.delete(headers: headers, url: '$swalifUrl/4/$commentsUrl/1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await _networking.deleteComment(4, 1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: '$swalifUrl/4/$commentsUrl/1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.deleteComment(4, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: '$swalifUrl/4/$commentsUrl/1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.deleteComment(4, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: '$swalifUrl/4/$commentsUrl/1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.deleteComment(4, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(headers: headers, url: '$swalifUrl/4/$commentsUrl/1'))
          .thenThrow(exception);
      try {
        await _networking.deleteComment(4, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
