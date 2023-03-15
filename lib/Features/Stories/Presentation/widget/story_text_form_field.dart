import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../App/Resources/color_manager.dart';
import '../../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/validator.dart';

class StoryTextFormField extends StatefulWidget {
  final Color? fillColor;
  final TextEditingController? textEditingController;

  const StoryTextFormField(
      {required this.textEditingController, required this.fillColor, Key? key})
      : super(key: key);

  @override
  State<StoryTextFormField> createState() => _StoryTextFormFieldState();
}

class _StoryTextFormFieldState extends State<StoryTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      cursorColor: ColorManager.lightGrey,
      cursorWidth: 3,
      cursorHeight: 35,
      style: const TextStyle(fontSize: 20, color: Colors.white),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        focusColor: widget.fillColor,
        filled: true,
        fillColor: widget.fillColor,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: tr("tap_to_type"),
        hintStyle: getBoldStyle(size: 25, fontColor: ColorManager.lightGrey),
      ),
      validator: (value) => Validator().validateEmpty(value!),
    );
  }
}
