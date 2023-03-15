import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class PriceCell extends StatelessWidget {
  const PriceCell({
    Key? key,
    required this.state,
    required this.price,
  }) : super(key: key);
  final String state;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: SizeConfig.screenHeight! * .05,
            color: ColorManager.lightGrey1,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(state, style: getMediumStyle(fontSize: 12)),
            ),
          ),
        ),
        const SizedBox(width: 1),
        Expanded(
          child: Container(
            height: SizeConfig.screenHeight! * .05,
            color: ColorManager.lightGrey1,
            child: Center(
              child: Text(
                "$price",
                style: getBoldStyle(size: 13),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
