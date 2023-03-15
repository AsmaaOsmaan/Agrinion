import 'package:flutter/material.dart';

import '../Resources/assets_manager.dart';
import '../Resources/color_manager.dart';
import '../Resources/text_themes.dart';
import '../Utilities/utils.dart';

class LogoWithTime extends StatelessWidget {
  const LogoWithTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.logoText,
          color: ColorManager.black,
          height: 40,
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "التاريخ : ${Utils.slashFormat(DateTime.now())}",
              style: getMediumStyle(
                fontSize: 12,
                fontColor: ColorManager.grey,
              ),
            ),
            Text(
              "الوقت : ${Utils.timeFormat(DateTime.now())}",
              style: getMediumStyle(
                fontSize: 12,
                fontColor: ColorManager.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
