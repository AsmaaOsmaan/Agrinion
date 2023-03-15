import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/widgets/edit_post_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PopMenuWidget extends StatelessWidget {
  final SwalifPostModel swalifPostModel;
  final Function deleteFunction;

  const PopMenuWidget(
      {Key? key, required this.swalifPostModel, required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopOutMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopOutMenu>(
              value: PopOutMenu.delete, child: Text(tr(LocaleKeys.delete))),
          PopupMenuItem<PopOutMenu>(
              value: PopOutMenu.update, child: Text(tr(LocaleKeys.edit))),
        ];
      },
      onSelected: (PopOutMenu menu) async {
        if (menu == PopOutMenu.delete) {
          //context.read<SwalifVL>().deletePost(swalifPostModel,context);
          deleteFunction();
        } else {
          BottomSheetHelper(
            context: context,
            content: EditPostScreen(
              swalifPostModel: swalifPostModel,
            ),
          ).openFullSheet();
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}

enum PopOutMenu { delete, update }
