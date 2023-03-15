import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/Screens/comments_screen.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/Features/Swalif/Presentation/widgets/write_comment_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Utilities/utils.dart';
import 'pop_menu_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostWidget extends StatelessWidget {
  final SwalifPostModel swalifPostModel;

  final int userId;
  final Function deleteFunction;
  final int? index;
  const PostWidget(
      {Key? key,
      required this.swalifPostModel,
      required this.userId,
      required this.deleteFunction,
        this.index,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoute().navigate(
            context: context,
            route: CommentsScreen(
              postId: swalifPostModel.postId!,
              fromNotification: false,
              index: index,
            ));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 2,
                color: Colors.grey.shade100,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage:
                              ExactAssetImage(AppImages.photoProfile),
                          radius: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              swalifPostModel.creator!.name!,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              Utils.calculateTheTime(
                                  swalifPostModel.createdAt!),
                              style: getBoldStyle(
                                size: 12,
                                fontColor: ColorManager.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Consumer<SwalifVL>(builder: (context, swalifVl, _) {
                      return Visibility(
                        visible: (userId == swalifPostModel.creator!.id!),
                        child: PopMenuWidget(
                          swalifPostModel: swalifPostModel,
                          deleteFunction: (){
                            deleteFunction();
                          },
                        ),
                      );
                    }),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: Text(
                              swalifPostModel.content!,
                              style: TextStyle(
                                  color: Colors.grey.shade900, fontSize: 15),
                            ),
                            width: SizeConfig.defaultSize! * 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${swalifPostModel.likesCount} ${tr(LocaleKeys.like)}"),
                      Text(
                          "${swalifPostModel.commentsCount} ${tr(LocaleKeys.comment)}"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<SwalifVL>(builder: (context, swalifVl, _) {
                  return Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                swalifVl.managePostLikes(
                                  swalifPostModel.postId!,
                                  swalifPostModel.liked!,
                                );
                              },
                              child: FaIcon(
                                FontAwesomeIcons.thumbsUp,
                                color: swalifPostModel.liked!
                                    ? Colors.blue
                                    : Colors.black,
                              ))),
                      WriteCommentWidget(postId: swalifPostModel.postId!,swalifPostModel: swalifPostModel),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
