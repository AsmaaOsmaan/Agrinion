import 'package:agriunion/Features/Stories/Domain/Entites/story_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../ViewLogic/story_vl.dart';

class ViewMyStory extends StatefulWidget {
  final StoryModel myStory;

  const ViewMyStory({required this.myStory, Key? key}) : super(key: key);

  @override
  State<ViewMyStory> createState() => _ViewMyStoryState();
}

class _ViewMyStoryState extends State<ViewMyStory> {
  final StoryController controller = StoryController();

  @override
  void initState() {
    context.read<StoryVL>().controlStoryItems(controller, widget.myStory);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryVL>(builder: (context, storyVL, child) {
      return Scaffold(
        body: Stack(
          children: [
            StoryView(
              storyItems: storyVL.myStoryItemsList,
              onStoryShow: (s) {},
              onComplete: () {
                Navigator.pop(context);
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              inline: false,
              controller: controller,
            ),
          ],
        ),
      );
    });
  }
}
