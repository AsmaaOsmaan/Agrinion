import 'package:agriunion/Features/Stories/Presentation/widget/story_color_picker.dart';
import 'package:agriunion/Features/Stories/Presentation/widget/story_fab.dart';
import 'package:agriunion/Features/Stories/Presentation/widget/story_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../Domain/Entites/story_model.dart';
import '../ViewLogic/story_vl.dart';

class TextStoryScreen extends StatefulWidget {
  const TextStoryScreen({Key? key}) : super(key: key);

  @override
  State<TextStoryScreen> createState() => _TextStoryScreenState();
}

class _TextStoryScreenState extends State<TextStoryScreen> {
  final TextEditingController textContentController = TextEditingController();

  @override
  void initState() {
    context.read<StoryVL>().setRandomColor();
    super.initState();
  }

  @override
  void dispose() {
    textContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryVL>(builder: (context, storyVL, child) {
      return Scaffold(
        backgroundColor: storyVL.storyColor,
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.color_lens,
                color: ColorManager.white,
                size: 30,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const StoryColorPicker();
                  },
                );
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorManager.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: StoryTextFormField(
            textEditingController: textContentController,
            fillColor: storyVL.storyColor,
          ),
        ),
        floatingActionButton: StoryFAB(onTap: () async {
          await context.read<StoryVL>().addStory(
                StoryModel(
                  textContent: textContentController.text,
                  storyType: "text_content",
                  textBackgroundColor: storyVL.storyColor,
                ),
              );
          Navigator.pop(context);
        }),
      );
    });
  }
}
