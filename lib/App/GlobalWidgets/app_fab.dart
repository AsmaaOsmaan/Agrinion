import 'package:flutter/material.dart';

import '../Resources/assets_manager.dart';
import '../Resources/color_manager.dart';

class AppFAB extends StatelessWidget {
  const AppFAB({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onTap(),
      child: Image.asset(
        AppIcons.add,
        color: Colors.white,
        height: 22,
      ),
      backgroundColor: ColorManager.primary,
    );
  }
}
