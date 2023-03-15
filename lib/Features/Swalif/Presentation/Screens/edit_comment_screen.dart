import 'package:agriunion/App/GlobalWidgets/app_small_button.dart';
import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCommentScreen extends StatefulWidget {
  const EditCommentScreen(
      {Key? key,
      required this.postId,
      required this.comment,
      required this.index})
      : super(key: key);
  final int postId;
  final CommentModel comment;
  final int index;

  @override
  State<EditCommentScreen> createState() => _EditCommentScreenState();
}

class _EditCommentScreenState extends State<EditCommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _commentController.text = widget.comment.content!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.update_comment)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: SizeConfig.defaultSize! * 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.defaultSize!,
                      right: SizeConfig.defaultSize!),
                  child: const CircleAvatar(
                    backgroundImage: ExactAssetImage(AppImages.photoProfile),
                    radius: 20,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 100,
                          maxWidth: SizeConfig.defaultSize! * 32,
                        ),
                        child: TextFormField(
                          controller: _commentController,
                          validator: (value) => Validator().validateEmpty(
                              value!,
                              message: tr(LocaleKeys.write_comment)),
                          maxLines: 10,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: tr(LocaleKeys.write_comment),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.defaultSize! * 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSmallButton(
                  title: tr(LocaleKeys.edit),
                  onTap: () {
                    context.read<SwalifVL>().updateComment(
                          CommentModel(content: _commentController.text),
                          widget.postId,
                          context,
                          widget.index,
                          widget.comment.commentId!,
                        );
                  },
                  color: ColorManager.grey,
                ),
                const SizedBox(
                  width: 20,
                ),
                AppSmallButton(
                  title: tr(LocaleKeys.cancel1),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: ColorManager.favRed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
