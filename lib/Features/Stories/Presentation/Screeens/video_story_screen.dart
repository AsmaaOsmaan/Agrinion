import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/Stories/Domain/Entites/story_model.dart';
import 'package:agriunion/Features/Stories/Presentation/widget/controls_overlay.dart';
import 'package:agriunion/Features/Stories/Presentation/widget/story_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../ViewLogic/story_vl.dart';
import '../widget/multimedia_text_field.dart';

class VideoStoryScreen extends StatefulWidget {
  const VideoStoryScreen({Key? key}) : super(key: key);

  @override
  State<VideoStoryScreen> createState() => _VideoStoryScreenState();
}

class _VideoStoryScreenState extends State<VideoStoryScreen> {
  VideoPlayerController? _controller;

  final TextEditingController textContentController = TextEditingController();

  @override
  void initState() {
    _controller = VideoPlayerController.file(
      context.read<StoryVL>().video!,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller?.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    textContentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<StoryVL>().video = null;

        return Future.value(true);
      },
      child: Consumer<StoryVL>(builder: (context, storyVL, child) {
        return Scaffold(
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
              Center(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller!),
                      ControlsOverlay(controller: _controller!),
                      VideoProgressIndicator(_controller!,
                          allowScrubbing: true),
                    ],
                  ),
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
                multimediaFile: storyVL.video,
                textContent: textContentController.text,
                storyType: "video",
              ));
              Navigator.pop(context);
            },
          ),
        );
      }),
    );
  }
}
