import 'package:flutter/material.dart';

import '../../../../../App/Resources/color_manager.dart';

class StoryFAB extends StatelessWidget {
  final Function? onTap;

  const StoryFAB({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.primary,
      onPressed: () => onTap!(),
      child: const Icon(Icons.send),
    );
  }
}
