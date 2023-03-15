import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';

class AddNewImageIcon extends StatelessWidget {
  const AddNewImageIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.camera_alt_outlined,
            color: ColorManager.grey,
            size: 28,
          ),
          const SizedBox(height: 10),
          Text(
            tr("add_image"),
            style: getRegularStyle(
              fontSize: 16,
              fontColor: ColorManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}
