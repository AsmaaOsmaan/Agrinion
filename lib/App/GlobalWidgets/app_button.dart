import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';

import '../Utilities/size_config.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      child: Text(title, style: getBoldStyle(fontColor: ColorManager.white)),
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(SizeConfig.screenWidth!, 40),
      ),
    );
  }
}
