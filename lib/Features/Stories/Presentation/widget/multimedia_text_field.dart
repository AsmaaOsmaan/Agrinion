import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class MultimediaTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  const MultimediaTextField({required this.textEditingController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: SizedBox(
        width: SizeConfig.screenWidth! * 0.8,
        child: TextField(
          controller: textEditingController,
          cursorColor: ColorManager.lightGrey,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorManager.grey,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.grey,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[600]!,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintStyle:
                getBoldStyle(size: 25, fontColor: ColorManager.lightGrey),
          ),
        ),
      ),
    );
  }
}
