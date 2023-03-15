import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Authentication/Presentation/ViewLogic/auth_view_logic.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.forgot_pass))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * .05),
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.phone_number),
                  errorText: context.watch<AuthVL>().forgetErrorText,
                ),
                validator: (value) => Validator().validatePhone(value!),
              ),
              const Spacer(),
              AppButton(
                title: tr(LocaleKeys.next),
                onTap: () {
                  if (_key.currentState!.validate()) {
                    context.read<AuthVL>().forgetPassword(_controller.text);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
