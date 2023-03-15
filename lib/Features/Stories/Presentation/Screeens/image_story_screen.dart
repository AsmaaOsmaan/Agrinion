import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/Stories/Presentation/widget/story_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Domain/Entites/story_model.dart';
import '../ViewLogic/story_vl.dart';
import '../widget/multimedia_text_field.dart';

class ImageStoryScreen extends StatefulWidget {
  const ImageStoryScreen({Key? key}) : super(key: key);

  @override
  State<ImageStoryScreen> createState() => _ImageStoryScreenState();
}

class _ImageStoryScreenState extends State<ImageStoryScreen> {
  final TextEditingController textContentController = TextEditingController();

  @override
  void dispose() {
    textContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryVL>(builder: (context, storyVL, child) {
      return WillPopScope(
        onWillPop: () {
          context.read<StoryVL>().image = null;

          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: ColorManager.black,
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: ColorManager.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Stack(
            children: [
              storyVL.image == null
                  ? const SizedBox()
                  : Center(
                      child: Image.file(
                        storyVL.image!,
                        fit: BoxFit.contain,
                      ),
                    ),
              MultimediaTextField(
                textEditingController: textContentController,
              ),
            ],
          ),
          floatingActionButton: StoryFAB(
            onTap: () {
              storyVL.addStory(StoryModel(
                multimediaFile: storyVL.image,
                textContent: textContentController.text,
                storyType: "image",
              ));
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }
}
