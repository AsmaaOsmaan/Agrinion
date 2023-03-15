import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class StoryColorPicker extends StatelessWidget {
  const StoryColorPicker({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr("choose_color")),
      content: SingleChildScrollView(
        child: BlockPicker(
            pickerColor: ColorManager.primary,
            onColorChanged: (Color color) {
              context.read<StoryVL>().setStoryColor(color);
            }),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Text(tr(LocaleKeys.save)),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}
