import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/GlobalWidgets/delete_confirmation_dialog.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/Screens/edit_comment_screen.dart';
import 'package:provider/provider.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';

import '../../../../App/Resources/text_themes.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet(
      {Key? key,
      required this.commentModel,
      required this.postId,
      required this.index})
      : super(key: key);
  final CommentModel commentModel;
  final int postId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: SizeConfig.defaultSize!, right: SizeConfig.defaultSize!),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () => AppDialogs(context).showDelete(
                          content: DeleteConfirmationDialog(onDelete: () {
                        Navigator.pop(context);
                        context.read<SwalifVL>().deleteComment(
                            commentModel, postId, commentModel.commentId!);
                      })),
                  child: Text(tr(LocaleKeys.delete),
                      style: getBoldStyle(fontColor: ColorManager.favRed))),
               SizedBox(
                height: SizeConfig.defaultSize!*2,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  AppRoute().navigate(
                      context: context,
                      route: EditCommentScreen(
                        postId: postId,
                        comment: commentModel,
                        index: index,
                      ));
                },
                child: Text(tr(LocaleKeys.edit_comment), style: getBoldStyle()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
