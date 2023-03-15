import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/Stories/Data/DataSource/story_networking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late StoryNetworking _networking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo4NH0.peh5YRi_BxYCT_Jxgt-udtzjuCT__-SdspF2bXpdAvs'
  };
  setUp(
    () {
      _networking = StoryNetworking(helper);
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('get stories test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 170,
          "user_id": 19,
          "status": "running",
          "article": "vvvv",
          "story_type": "text_content",
          "text_background_color": "text_background_color",
        },
      ];
      when(helper.get(headers: headers, url: storyUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await _networking.getAllStories();

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: storyUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.getAllStories();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: storyUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.getAllStories();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: storyUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.getAllStories();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: storyUrl)).thenThrow(exception);
      try {
        await _networking.getAllStories();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('get  specific users stories  test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 170,
          "user_id": 19,
          "status": "running",
          "article": "vvvv",
          "story_type": "text_content",
          "text_background_color": "text_background_color"
        },
      ];
      when(helper.get(headers: headers, url: userStoriesUrl + '?user_id=2'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await _networking.getSpecificUserStories(2);

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: userStoriesUrl + '?user_id=2'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.getSpecificUserStories(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: userStoriesUrl + '?user_id=2'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.getSpecificUserStories(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: userStoriesUrl + '?user_id=2'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.getSpecificUserStories(2);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: userStoriesUrl + '?user_id=2'))
          .thenThrow(exception);
      try {
        await _networking.getSpecificUserStories(2);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('create story test cases', () {
    var functionBody = {
      'story': {
        "multimedia": 5,
        "story_type": "image",
        "text_content": "text_content",
      }
    };

    var mockBody = {
      'story': {
        "multimedia": 5,
        "story_type": "image",
        "text_content": "text_content"
      }
    };

    var response = {
      "id": 35,
      "user_id": 22,
      "image":
          "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBIZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b93fd00ffbc8146931eba6f9b3b5362ad2ae22b7/test_image.jpg",
      "status": "running",
      "text_content": "text_content",
    };

    test('Happy case scenario', () async {
      Response res = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: response,
      );
      var responseObject = Future.value(res);
      when(helper.postMedia(headers: headers, url: storyUrl, body: mockBody))
          .thenAnswer((_) => responseObject);
      expect(
        await _networking.addStory(functionBody),
        response,
      );
    });
    test('validation fail case scenario', () async {
      Response validationRes = Response(
        requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
        data: {},
        statusCode: 422,
      );
      when(helper.postMedia(headers: headers, url: storyUrl, body: mockBody))
          .thenThrow(
        DioError(
          requestOptions: validationRes.requestOptions,
          response: validationRes,
        ),
      );
      var actual = await _networking.addStory(functionBody);
      expect(actual, validationRes.data);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.postMedia(headers: headers, url: storyUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.addStory(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.postMedia(headers: headers, url: storyUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.addStory(functionBody);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.postMedia(headers: headers, url: storyUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.addStory(functionBody);
      } catch (e) {
        expect(e, ConnectivityException);
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.postMedia(headers: headers, url: storyUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await _networking.addStory(functionBody);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete story test cases', () {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo4NH0.peh5YRi_BxYCT_Jxgt-udtzjuCT__-SdspF2bXpdAvs'
    };
    test('Happy case scenario', () async {
      when(helper.delete(headers: headers2, url: storyUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await _networking.deleteStory(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: storyUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await _networking.deleteStory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: storyUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await _networking.deleteStory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(headers: headers, url: storyUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await _networking.deleteStory(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(headers: headers, url: storyUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await _networking.deleteStory(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
