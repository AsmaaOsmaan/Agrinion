import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({Key? key, this.userId, this.index}) : super(key: key);
  final int? userId;
  final int? index;

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final StoryController controller = StoryController();

  List<StoryItem> storyItems = [];

  @override
  void initState() {
    context.read<StoryVL>().initStoryPageItem(controller);

    super.initState();
  }

  @override
  void deactivate() {
    context.read<StoryVL>().updateValues();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryVL>(
      builder: (context, storyVL, child) {
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
                inline: true,
                controller: controller,
              ),
              Visibility(
                visible: storyVL.checkIfHasNextStory(widget.index!),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          storyVL.updateValues();
                          storyVL.getNextStories(widget.index!, context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: ColorManager.primary,
                        )),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
