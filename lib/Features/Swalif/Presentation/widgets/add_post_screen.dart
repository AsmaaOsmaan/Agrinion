import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                hintText: tr(LocaleKeys.post_hint)),
          ),
        ),
        // SizedBox(height: 20,),
        AppButton(
            title: tr(LocaleKeys.post),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.read<SwalifVL>().addSwalifPost(
                    SwalifPostModel(content: _contentController.text), context);
              }
            })
      ],
    );
  }
}
