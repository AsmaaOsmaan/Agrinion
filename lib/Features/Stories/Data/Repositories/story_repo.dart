import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Stories/Data/DataSource/story_networking.dart';
import 'package:agriunion/Features/Stories/Data/mapper/story_mapper.dart';
import 'package:agriunion/Features/Stories/Domain/Entites/story_model.dart';

abstract class IStoryRepository {
  Future<StoryModel> addStory(StoryModel model);

  Future<List<StoryModel>> getAllStories();

  Future<List<StoryModel>> getSpecificUserStories(int userId);

  Future<void> deleteStory(int storyId);
}

class StoryRepository implements IStoryRepository {
  IStoryNetworking storyNetworking;

  StoryRepository(this.storyNetworking);

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  StoryModel convertToModel(Map<String, dynamic> jsonResponse) {
    return StoryMapper.fromJson(jsonResponse);
  }

  List<StoryModel> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => StoryMapper.fromJson(e)).toList();
  }

  @override
  Future<StoryModel> addStory(StoryModel model) async {
    final response = await storyNetworking.addStory(StoryMapper.toJson(model));

    final jsonResponse = convertToJson(response);
    final story = convertToModel(jsonResponse);
    return story;
  }

  @override
  Future<List<StoryModel>> getAllStories() async {
    final response = await storyNetworking.getAllStories();
    final jsonResponse = Utils.convertToListJson(response);
    final stories = convertToListModel(jsonResponse);
    return stories;
  }

  @override
  Future<List<StoryModel>> getSpecificUserStories(int userId) async {
    final response = await storyNetworking.getSpecificUserStories(userId);
    final jsonResponse = Utils.convertToListJson(response);
    final stories = convertToListModel(jsonResponse);
    return stories;
  }

  @override
  Future<void> deleteStory(int storyId) async {
    await storyNetworking.deleteStory(storyId);
  }
}
