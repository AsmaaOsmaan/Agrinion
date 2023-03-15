import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';
import '../Resources/text_themes.dart';
import 'app_text_button.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("هل تريد الحذف؟", style: getBoldStyle(size: 20)),
        const Spacer(),
        Row(
          children: [
            AppTextButton(
              text: "نعم",
              color: ColorManager.error,
              onTap: () async {
                await onDelete();
                Navigator.pop(context);
              },
              width: SizeConfig.screenWidth! * .3,
            ),
            const Spacer(),
            AppTextButton(
              text: "ﻻ",
              color: ColorManager.primary,
              onTap: () => Navigator.pop(context),
              width: SizeConfig.screenWidth! * .3,
            ),
          ],
        ),
      ],
    );
  }
}
