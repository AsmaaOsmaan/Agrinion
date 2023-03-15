import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../../App/GlobalWidgets/app_small_button.dart';
import '../../../App/Resources/color_manager.dart';
import '../../../App/constants/values.dart';

class ManagementLargeTile extends StatelessWidget {
  const ManagementLargeTile({
    Key? key,
    required this.content,
    required this.onDelete,
    this.onTap,
    required this.sheetContent,
  }) : super(key: key);
  final Widget content;
  final Widget sheetContent;
  final Function onDelete;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        height: SizeConfig.screenHeight! * .1,
        decoration: BoxDecoration(
          borderRadius: radius8,
          border: Border.all(color: ColorManager.lightGrey),
          color: ColorManager.lightGrey1,
        ),
        child: Row(
          children: [
            content,
            const Spacer(),
            AppSmallButton(
              onTap: () => BottomSheetHelper(
                context: context,
                content: sheetContent,
              ).openFullSheet(),
              title: "تعديل",
              color: ColorManager.grey,
            ),
            const SizedBox(width: 10),
            AppSmallButton(
              onTap: () => onDelete(),
              title: "حذف",
              color: ColorManager.favRed,
            ),
          ],
        ),
      ),
    );
  }
}
