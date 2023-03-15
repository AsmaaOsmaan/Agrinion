import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/Stories/Data/mapper/story_mapper.dart';
import 'package:agriunion/Features/Stories/Domain/Entites/story_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(
    () {
      dotenv.testLoad(fileInput: File('.env.test').readAsStringSync());
    },
  );

  group('stories from json test cases', () {
    Map<String, dynamic> json = {
      "id": 172,
      "user_id": 1,
      "status": "running",
      "multimedia": null,
      "story_type": "image",
      "textContent": null,
      "article": "article",
      "text_background_color": "text_background_color",
    };

    StoryModel response = StoryModel(
      storyId: 172,
      userId: 1,
      storyType: "image",
      article: "article",
      multimedia: null,
      textContent: null,
      status: "running",
      textBackgroundColor: ColorManager.grey,
    );
    test('fromJson takes json returns object of Stories', () {
      var fromJson = StoryMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        StoryMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    StoryModel model = StoryModel(
      textContent: 'text_content',
      multimediaFile: null,
      storyType: 'text',
      textBackgroundColor: Colors.black,
    );
    Map<String, dynamic> json = {
      'story': {
        'text_content': 'text_content',
        'multimedia': null,
        'story_type': 'text',
        'text_background_color': Colors.black.toHex()
      }
    };

    test('toJson takes Object and return Json', () {
      var fromJson = StoryMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
