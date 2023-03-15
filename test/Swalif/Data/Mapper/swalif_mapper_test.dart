import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Swalif/Data/mapper/swalif_post_mapper.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('swalif from json test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "body": "body",
      "liked?": true,
      "likes_count": 5,
      "comments_count": 5,
    };

    SwalifPostModel response = SwalifPostModel(
        liked: true,
        postId: 1,
        likesCount: 5,
        commentsCount: 5,
        content: "body");
    test('fromJson takes json returns object of post model', () {
      var fromJson = SwalifPostMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        SwalifPostMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    SwalifPostModel model = SwalifPostModel(content: "body");
    Map<String, dynamic> json = {
      'post': {
        'body': 'body',
      }
    };

    test('toJson takes Object and return Json', () {
      var fromJson = SwalifPostMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
