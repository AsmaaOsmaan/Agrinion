import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/News/Data/Mapper/news_mapper.dart';
import 'package:agriunion/Features/News/Domain/Entites/news_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(
    () {
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );
  group('news fromjson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "title_ar": '',
      "title_en": '',
      "body_ar": '',
      "body_en": '',
      "published": true,
    };
    NewsModel response = const NewsModel(
      bodyAr: '',
      bodyEn: '',
      id: 1,
      published: true,
      titleAr: '',
      titleEn: '',
    );

    test('fromJson takes json returns object of news', () {
      var fromJson = NewsMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        NewsMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    Map<String, dynamic> json = {
      'news': {
        'title_ar': '',
        'title_en': '',
        'body_ar': '',
        'body_en': '',
        'published': true,
        'image': null
      }
    };
    NewsModel model = const NewsModel(
      bodyAr: '',
      bodyEn: '',
      published: true,
      titleAr: '',
      titleEn: '',
    );

    test('toJson takes Object and return Json', () {
      var fromJson = NewsMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
