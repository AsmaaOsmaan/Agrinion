import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/values.dart';

class NegotiatableContainer extends StatelessWidget {
  const NegotiatableContainer({
    Key? key,
    this.fontSize = 10,
    this.padding = 3,
  }) : super(key: key);
  final double fontSize, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: radius20,
          color: ColorManager.yellow,
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          "قابل للتفاوض",
          style: fontSize == 10
              ? getMediumStyle(
                  fontSize: fontSize, fontColor: ColorManager.black)
              : getBoldStyle(size: 14),
        ));
  }
}
