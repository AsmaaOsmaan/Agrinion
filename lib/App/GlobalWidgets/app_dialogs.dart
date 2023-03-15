import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  BuildContext context;
  AppDialogs(this.context);
  showContent({required Widget content}) {
    showDialog(context: context, builder: (_) => MainDialog(content: content));
  }

  showDelete({required Widget content}) {
    showDialog(
      context: context,
      builder: (_) => MainDialog(
        content: content,
        height: SizeConfig.screenHeight! * .2,
      ),
    );
  }
}

class MainDialog extends StatelessWidget {
  const MainDialog({Key? key, required this.content, this.height})
      : super(key: key);
  final Widget content;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height ?? SizeConfig.screenHeight! * .4,
              width: SizeConfig.screenWidth! * .85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: content,
            ),
            Positioned(
              top: -15,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: ColorManager.lightGrey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
