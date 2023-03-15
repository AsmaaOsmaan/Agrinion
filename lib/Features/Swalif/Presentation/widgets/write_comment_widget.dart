import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteCommentWidget extends StatelessWidget {
  WriteCommentWidget(
      {Key? key, required this.postId, required this.swalifPostModel})
      : super(key: key);
  final int postId;
  final SwalifPostModel swalifPostModel;

  final TextEditingController _commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: SizeConfig.defaultSize! * 30,
              maxWidth: SizeConfig.defaultSize! * 30,
            ),
            child: TextFormField(
              controller: _commentController,
              validator: (value) => Validator()
                  .validateEmpty(value!, message: tr("write_comment")),
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration(
                hintText: tr(LocaleKeys.write_comment),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      context.read<SwalifVL>().createComment(
                          CommentModel(content: _commentController.text),
                          swalifPostModel);

                      _commentController.clear();
                    }),
                filled: true,
                fillColor: Colors.grey.shade100,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
