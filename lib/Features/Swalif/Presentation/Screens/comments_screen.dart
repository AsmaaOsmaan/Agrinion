import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/Features/Swalif/Presentation/widgets/comment_widget.dart';
import 'package:agriunion/Features/Swalif/Presentation/widgets/post_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/constants/keys.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen(
      {Key? key,
      required this.postId,
      required this.fromNotification,
      this.index})
      : super(key: key);
  final int postId;
  final bool fromNotification;
  final int? index;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  int? userId;
  @override
  void initState() {
    context.read<SwalifVL>().showSwalifPost(widget.postId);
    userId = CachHelper.getData(key: kId);
    context.read<SwalifVL>().updateInShowPostVal(true);
    super.initState();
  }

  @override
  void deactivate() {
    context.read<SwalifVL>().updateInShowPostVal(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(tr(LocaleKeys.comments)),
      ),
      body: Consumer<SwalifVL>(builder: (context, vl, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: vl.loading || vl.postModel == null
              ? const LoadingView()
              : Column(
                  children: [
                    PostWidget(
                        swalifPostModel: vl.postModel!,
                        userId: userId!,
                        deleteFunction: widget.fromNotification
                            ? () {
                                vl.deletePostWithNavigation(
                                    vl.postModel!, context);
                              }
                            : () {
                                vl.deletePostWithNavigationAndRemoveFromList(
                                    vl.postModel!, context, widget.index!);
                              }),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 3,
                      child: const Divider(),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: vl.comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CommentWidget(
                            commentModel: vl.comments[index],
                            postId: widget.postId,
                            index: index,
                            userId: userId!,
                          );
                        },
                        separatorBuilder: (ctx, index) => const SizedBox(
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
        );
      }),
    );
  }
}
