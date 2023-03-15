import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/GlobalWidgets/delete_confirmation_dialog.dart';
import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Stories/Presentation/Screeens/view_my_story.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Utilities/app_route.dart';

class MyStoriesScreen extends StatefulWidget {
  const MyStoriesScreen({Key? key}) : super(key: key);

  @override
  State<MyStoriesScreen> createState() => _MyStoriesScreenState();
}

class _MyStoriesScreenState extends State<MyStoriesScreen> {
  @override
  void initState() {
    context.read<StoryVL>().getSpecificUserStories(
          CachHelper.getData(key: kId),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.my_stories))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
        child: Column(
          children: [
            Consumer<StoryVL>(
              builder: (context, storyVL, child) {
                return Expanded(
                  child: storyVL.loading
                      ? const LoadingView()
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .8,
                          ),
                          itemCount: storyVL.currentStories.length,
                          itemBuilder: (BuildContext context, index) {
                            return GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  AppRoute().navigate(
                                    context: context,
                                    route: ViewMyStory(
                                      myStory: storyVL.currentStories[index],
                                    ),
                                  );
                                },
                                child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: storyVL.currentStories[index]
                                              .textBackgroundColor ??
                                          ColorManager.white,
                                    ),
                                    child: storyVL.getMyStory(
                                      story: storyVL.currentStories[index],
                                    )),
                              ),
                              footer: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.black26,
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [.2, .9],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          AppDialogs(context).showDelete(
                                              content: DeleteConfirmationDialog(
                                                  onDelete: () => storyVL
                                                      .deleteStory(storyVL
                                                              .currentStories[
                                                          index])));
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
