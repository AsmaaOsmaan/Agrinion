import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({
    Key? key,
    required this.swalifPostModel,
  }) : super(key: key);
  final SwalifPostModel swalifPostModel;

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _contentController.text = widget.swalifPostModel.content!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            validator: (value) => Validator().validateEmpty(value!),
            controller: _contentController,
            maxLines: 20,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                hintText: tr("write_comments")),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: AppButton(
                  title: tr(LocaleKeys.edit),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SwalifVL>().updateSwalifPost(
                          SwalifPostModel(content: _contentController.text),
                          widget.swalifPostModel.postId!,
                          context);
                    }
                  }),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: AppButton(
                  color: Colors.red,
                  title: tr(LocaleKeys.cancel1),
                  onTap: () {
                    _contentController.text = widget.swalifPostModel.content!;
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
