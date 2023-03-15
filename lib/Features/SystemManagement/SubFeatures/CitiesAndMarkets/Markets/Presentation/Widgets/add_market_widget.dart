import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../../../../App/Resources/color_manager.dart';
import '../../../../../../../App/Resources/text_themes.dart';

class AddMarketWidget extends StatelessWidget {
  const AddMarketWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: DottedBorder(
        radius: const Radius.circular(20),
        color: ColorManager.lightGrey,
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Text(
            "إضافة سوق جديد",
            style: getRegularStyle(fontColor: ColorManager.grey),
          ),
        ),
      ),
    );
  }
}
