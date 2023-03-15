import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';
import '../Resources/text_themes.dart';
import '../constants/values.dart';

class AppSmallButton extends StatelessWidget {
  const AppSmallButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color = ColorManager.primary,
  }) : super(key: key);
  final String title;
  final Function onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius20,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(title,
            style: getMediumStyle(
              fontColor: Colors.white,
              fontSize: 11,
            )),
      ),
    );
  }
}
