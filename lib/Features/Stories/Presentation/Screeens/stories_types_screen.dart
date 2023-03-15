import 'package:agriunion/Features/Stories/Presentation/Screeens/text_story_screen.dart';
import 'package:agriunion/Features/Stories/Presentation/widget/add_story_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../ViewLogic/story_vl.dart';
import 'image_story_screen.dart';

class StoriesTypesScreen extends StatelessWidget {
  const StoriesTypesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("add_to_story"),
          style: getBoldStyle(fontColor: ColorManager.black, size: 25),
        ),
        backgroundColor: ColorManager.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * .07,
        ),
        child: Consumer<StoryVL>(builder: (context, storyVL, child) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  AddStoryCard(
                    title: tr("text"),
                    widget: Text(
                      "Aa",
                      style:
                          getBoldStyle(fontColor: ColorManager.black, size: 25),
                    ),
                    onTap: () => AppRoute().navigate(
                      context: context,
                      route: const TextStoryScreen(),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * .02,
                  ),
                  AddStoryCard(
                    title: tr("image"),
                    widget: const Icon(
                      Icons.camera_alt,
                      size: 35,
                      color: ColorManager.black,
                    ),
                    onTap: () {
                      storyVL.getStoryImage();
                      AppRoute().navigate(
                        context: context,
                        route: const ImageStoryScreen(),
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * .02,
                  ),
                  AddStoryCard(
                    title: tr("video"),
                    widget: const Icon(
                      Icons.video_call_rounded,
                      size: 35,
                      color: ColorManager.black,
                    ),
                    onTap: () {
                      storyVL.getStoryVideo();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
