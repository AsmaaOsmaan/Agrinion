import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';
import '../constants/values.dart';
import 'app_small_button.dart';
import 'app_text_button.dart';
import 'delete_confirmation_dialog.dart';

class AppTile extends StatelessWidget {
  const AppTile({
    Key? key,
    required this.title,
    required this.onUdpate,
    required this.onDelete,
  }) : super(key: key);
  final String title;
  final Function onDelete;
  final Function onUdpate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.lightGrey),
        color: ColorManager.lightGrey1,
        borderRadius: radius8,
      ),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          AppSmallButton(
            title: "تعديل",
            onTap: () => onUdpate(),
            color: ColorManager.grey,
          ),
          const SizedBox(width: 10),
          AppSmallButton(
            title: "حذف",
            onTap: () => AppDialogs(context).showDelete(
                content: DeleteConfirmationDialog(onDelete: onDelete)),
            color: ColorManager.favRed,
          ),
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("هل تريد الحذف؟", style: getBoldStyle(size: 20)),
        Row(
          children: [
            // AppTextButton(
            //   text: "نعم",
            //   color: ColorManager.error,
            //   onTap: () => onDelete(),
            // ),
            AppTextButton(
              text: "نعم",
              color: ColorManager.error,
              onTap: () => onDelete(),
            ),
          ],
        ),
      ],
    );
  }
}
