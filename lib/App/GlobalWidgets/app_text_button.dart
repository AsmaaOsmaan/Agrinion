import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';
import '../Resources/text_themes.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onTap,
    this.width = 50,
  }) : super(key: key);
  final String text;
  final Color color;
  final Function onTap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),
      style: TextButton.styleFrom(
        fixedSize: Size(width!, 15),
        shape: const StadiumBorder(),
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: getBoldStyle(fontColor: ColorManager.white, size: 15),
      ),
    );
  }
}
