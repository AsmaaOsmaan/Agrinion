import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/Features/Home/Presentation/Widgets/home_imports.dart';
import 'package:agriunion/Features/Stories/Presentation/Screeens/stories_types_screen.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/constants/keys.dart';
import 'story_view.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      scrollDirection: Axis.horizontal,
      child: Consumer<StoryVL>(builder: (context, storyVL, child) {
        return Row(
          children: [
            Visibility(
              visible: CachHelper.getData(key: kType) == 'Admin' ? false : true,
              child: GestureDetector(
                onTap: () {
                  AppRoute().navigate(
                    context: context,
                    route: const StoriesTypesScreen(),
                  );
                },
                child: const CircleContainer(
                  icon: AppIcons.add,
                  padding: EdgeInsets.all(15),
                  color: ColorManager.black,
                ),
              ),
            ),
            ...List.generate(
              storyVL.stories.length,
              (index) => GestureDetector(
                onTap: () async {
                  await context
                      .read<StoryVL>()
                      .getSpecificUserStories(storyVL.stories[index].userId!);
                  AppRoute().navigate(
                      context: context,
                      route: StoryViewScreen(
                        userId: storyVL.stories[index].userId,
                        index: index,
                      ));
                },
                child: StoryContainer(
                    widget: storyVL.getStoryThumbnail(storyVL.stories[index])),
              ),
            ),
          ],
        );
      }),
    );
  }
}
