import 'dart:io';
import 'dart:math';

import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Stories/Domain/Entites/story_model.dart';
import 'package:agriunion/Features/Stories/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/Stories/Presentation/Screeens/story_view.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:story_view/story_view.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../main.dart';
import '../Screeens/video_story_screen.dart';

class StoryVL extends ChangeNotifier {
  final IStoryServiceLayer storyServiceLayer;

  StoryVL(this.storyServiceLayer);

  List<StoryModel> stories = [];
  List<StoryModel> currentStories = [];
  int currentStoryIndex = 0;
  bool loading = false;

  addStory(StoryModel storyModel) async {
     try {
      LoadingDialog.showLoadingDialog();
       await storyServiceLayer.addStory(storyModel);
      getAllStories();
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(tr(LocaleKeys.story_added_successfully));
    } catch (e) {
      LoadingDialog.showSimpleToast(tr("something_error"));
      EasyLoading.dismiss();
    }
  }

  File? image;

  void getStoryImage() async {
    image = await Utils.getImage();
    notifyListeners();
  }

  File? video;

  void getStoryVideo() async {
    video = await Utils.getVideo();
    if (video != null) {
      AppRoute().navigate(
          context: navKey.currentContext!, route: const VideoStoryScreen());
    }
    notifyListeners();
  }

  void getAllStories() async {
    stories = await storyServiceLayer.getAllStories();

    notifyListeners();
  }

  Future<void> getSpecificUserStories(int userId) async {
    loading = true;
    currentStories = await storyServiceLayer.getSpecificUserStories(userId);
    loading = false;
    notifyListeners();
  }

  void updateValues() {
    currentStories = [];
    currentStoryIndex = 0;
    storyItems = [];
    myStoryItemsList = [];
  }

  deleteStory(StoryModel story) async {
    LoadingDialog.showLoadingDialog();
    await storyServiceLayer.deleteStory(story.storyId!);
    currentStories.remove(story);
    stories.remove(story);
    EasyLoading.dismiss();
    LoadingDialog.showSimpleToast(tr(LocaleKeys.story_deleted_successfully));
    notifyListeners();
  }

  List<StoryItem> storyItems = [];

  void initStoryPageItem(StoryController controller) {
    for (int i = 0; i < currentStories.length; i++) {
      controlStoryItems(controller, currentStories[i]);
    }
  }

  List<StoryItem> myStoryItemsList = [];

  void controlStoryItems(StoryController controller, StoryModel myStory) {
    if (myStory.storyType == "text_content") {
      initStoryPageText(myStory, myStoryItemsList);
    } else if (myStory.multimedia != null) {
      initStoryPageMultimedia(controller, myStory, myStoryItemsList);
    }
  }

  void initStoryPageText(StoryModel currentStories, List<StoryItem> storyList) {
    if (currentStories.article != null) {
      setTextSize(currentStories.article!.length.toDouble());
      storyList.add(
        StoryItem.text(
            title: currentStories.article!,
            backgroundColor: currentStories.textBackgroundColor != null
                ? currentStories.textBackgroundColor!
                : ColorManager.grey,
            duration: const Duration(seconds: 5),
            textStyle:
                TextStyle(fontSize: textSize, color: ColorManager.white)),
      );
    }
  }

  void initStoryPageMultimedia(StoryController controller,
      StoryModel currentStories, List<StoryItem> storyList) {
    if (currentStories.storyType == "image") {
      initStoryPageImage(controller, currentStories, storyList);
    } else if (currentStories.storyType == "video") {
      initStoryPageVideo(controller, currentStories, storyList);
    }
  }

  void initStoryPageImage(StoryController controller, StoryModel currentStories,
      List<StoryItem> storyList) {
    storyList.add(
      StoryItem.pageImage(
        duration: const Duration(seconds: 5),
        url: currentStories.multimedia!,
        caption: currentStories.article,
        controller: controller,
      ),
    );
  }

  void initStoryPageVideo(StoryController controller, StoryModel currentStories,
      List<StoryItem> storyList) {
    storyList.add(StoryItem.pageVideo(currentStories.multimedia!,
        caption:
            currentStories.article != null ? currentStories.article! : null,
        duration: const Duration(minutes: 5),
        controller: controller));
  }

  void getNextStories(int index, BuildContext context) async {
    if (index < stories.length - 1) {
      index++;
      await getSpecificUserStories(stories[index].userId!);
      AppRoute().navigate(
          context: context,
          route: StoryViewScreen(index: index),
          withReplace: true);
    }
  }

  bool checkIfHasNextStory(int index) {
    if (index < stories.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  Widget getStoryThumbnail(StoryModel? story) {
    if (story!.storyType == "text_content") {
      return Text(
        "${story.textContent}",
      );
    }
    if (story.multimedia == null) {
      return Image.asset(
        AppImages.videoDefaultImage,
        height: 27,
        width: 27,
        fit: BoxFit.cover,
      );
    }
    if (story.storyType == "image") {
      Image.network(
        story.multimedia!,
        height: 27,
        width: 27,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      AppImages.videoDefaultImage,
      height: 27,
      width: 27,
      fit: BoxFit.cover,
    );
  }

  Widget getMyStory({StoryModel? story}) {
    if (story!.storyType == "text_content") {
      return Text(
        story.article!,
        style: getMediumStyle(fontColor: Colors.black, fontSize: 18),
      );
    } else if (story.multimedia != null && story.storyType == "image") {
      return Image.network(
        story.multimedia!,
        fit: BoxFit.cover,
      );
    } else if (story.multimedia != null && story.storyType == "video") {
      return Image.asset(
        AppImages.videoDefaultImage,
        fit: BoxFit.cover,
      );
    }
    return const SizedBox();
  }

  Color? storyColor;

  setStoryColor(Color color) {
    storyColor = color;
    notifyListeners();
  }

  double? textSize;

  setTextSize(double length) {
    if (length <= 20) {
      textSize = 50;
    } else if (20 < length && length <= 30) {
      textSize = 45;
    } else if (30 < length && length <= 40) {
      textSize = 40;
    } else if (40 < length && length <= 50) {
      textSize = 35;
    } else if (50 < length && length <= 60) {
      textSize = 30;
    } else if (60 < length && length <= 70) {
      textSize = 25;
    } else if (70 < length && length <= 80) {
      textSize = 22;
    } else if (80 < length && length <= 90) {
      textSize = 20;
    } else if (90 < length && length <= 100) {
      textSize = 18;
    } else {
      textSize = 16;
    }
  }

  List<Color> list = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  void setRandomColor() {
    storyColor = list[Random().nextInt(list.length)];
  }
}
