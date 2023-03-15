import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class DimmingContainer extends StatelessWidget {
  const DimmingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * .18,
      decoration: BoxDecoration(
        color: ColorManager.black.withOpacity(
          .7,
        ),
      ),
      child: Center(
        child: Text(
          tr('waitingForResponse'),
          style: getBoldStyle(fontColor: ColorManager.white, size: 18),
        ),
      ),
    );
  }
}
