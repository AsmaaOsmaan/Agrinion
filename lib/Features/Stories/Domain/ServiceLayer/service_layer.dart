import 'package:agriunion/Features/Stories/Data/Repositories/story_repo.dart';

import '../Entites/story_model.dart';

abstract class IStoryServiceLayer {
  Future<StoryModel> addStory(StoryModel storyModel);

  Future<List<StoryModel>> getAllStories();

  Future<List<StoryModel>> getSpecificUserStories(int userId);

  Future<void> deleteStory(int storyId);
}

class StoryServiceLayer implements IStoryServiceLayer {
  IStoryRepository storyRepo;

  StoryServiceLayer(this.storyRepo);

  @override
  Future<StoryModel> addStory(StoryModel storyModel) async {
    return await storyRepo.addStory(storyModel);
  }

  @override
  Future<List<StoryModel>> getAllStories() async {
    return await storyRepo.getAllStories();
  }

  @override
  Future<List<StoryModel>> getSpecificUserStories(int userId) async {
    return await storyRepo.getSpecificUserStories(userId);
  }

  @override
  Future<void> deleteStory(int storyId) async {
    await storyRepo.deleteStory(storyId);
  }
}
