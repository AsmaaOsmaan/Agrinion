import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/GlobalWidgets/app_small_button.dart';
import 'package:agriunion/App/GlobalWidgets/delete_confirmation_dialog.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ItemBuilderCP extends StatelessWidget {
  const ItemBuilderCP({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onUdpate,
    required this.onDelete,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final Function onDelete;
  final Function onUdpate;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: ColorManager.lightGrey1,
        child: Icon(Icons.person, color: ColorManager.grey),
      ),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSmallButton(
            title: tr(LocaleKeys.edit),
            onTap: () => onUdpate(),
            color: ColorManager.grey,
          ),
          const SizedBox(width: 10),
          AppSmallButton(
            title: tr(LocaleKeys.delete),
            onTap: () => AppDialogs(context).showDelete(
                content: DeleteConfirmationDialog(onDelete: onDelete)),
            color: ColorManager.favRed,
          ),
        ],
      ),
    );
  }
}
