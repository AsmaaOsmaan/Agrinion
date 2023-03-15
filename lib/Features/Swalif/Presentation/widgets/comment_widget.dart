import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'bttom_sheet_comment.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {Key? key,
      required this.commentModel,
      required this.postId,
      required this.index,
      required this.userId})
      : super(key: key);
  final CommentModel commentModel;
  final int postId;
  final int index;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: commentModel.creator!.id == userId
          ? () {
              BottomSheetHelper(
                context: context,
                content: CommentSheet(
                    commentModel: commentModel, postId: postId, index: index),
              ).openSizedSheet(height: SizeConfig.screenHeight! * .25);
            }
          : null,
      child: Row(children: [
        const CircleAvatar(
          backgroundImage: ExactAssetImage(AppImages.photoProfile),
          radius: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: SizeConfig.defaultSize! * 30,
              decoration: const BoxDecoration(
                color: ColorManager.lightGrey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentModel.creator!.name!,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    commentModel.content!,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<SwalifVL>(builder: (context, swalifVl, _) {
              return SizedBox(
                width: SizeConfig.defaultSize! * 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        swalifVl.manageCommentsLikes(commentModel.commentId!,
                            commentModel.liked!, index);
                      },
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 18,
                            color: commentModel.liked!
                                ? Colors.blue
                                : Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              "${commentModel.likesCount} ${tr(LocaleKeys.like)}"),
                        ],
                      ),
                    ),
                    Text(
                      Utils.calculateTheTime(commentModel.createdAt!),
                      style: getBoldStyle(
                        size: 12,
                        fontColor: ColorManager.grey,
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ]),
    );
  }
}
