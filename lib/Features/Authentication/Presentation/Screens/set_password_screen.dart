import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Account/Data/Models/set_password_model.dart';
import 'package:agriunion/Features/Account/Presentation/ViewLogic/users_vl.dart';
import 'package:agriunion/Features/Authentication/Presentation/ViewLogic/auth_view_logic.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key, required this.fromForgetPassword})
      : super(key: key);
  final bool fromForgetPassword;
  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _newPasswordcontroller = TextEditingController();
  final TextEditingController _conPasswordcontroller = TextEditingController();
  @override
  void dispose() {
    _newPasswordcontroller.dispose();
    _conPasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersVL>(
      builder: (context, user, child) {
        return Scaffold(
          appBar: AppBar(title: Text(tr(LocaleKeys.change_password))),
          body: ModalProgressHUD(
            inAsyncCall: user.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _key,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight! * .05),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _newPasswordcontroller,
                      decoration:
                          InputDecoration(hintText: tr(LocaleKeys.new_pass)),
                      validator: (value) =>
                          Validator().validatePassword(value!),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _conPasswordcontroller,
                      decoration: InputDecoration(
                          hintText: tr(LocaleKeys.confirm_pass)),
                      validator: (value) => Validator().validatePasswordConfirm(
                          value!,
                          pass: _newPasswordcontroller.text),
                    ),
                    const Spacer(),
                    AppButton(
                      title: tr(LocaleKeys.save),
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          if (widget.fromForgetPassword == true) {
                            context.read<AuthVL>().setPassword(
                                  _newPasswordcontroller.text,
                                  _conPasswordcontroller.text,
                                );
                          } else {
                            context.read<UsersVL>().setNewPassword(
                                SetPasswordModel(
                                    newPassword: _newPasswordcontroller.text,
                                    passwordConfirmation:
                                        _conPasswordcontroller.text,
                                    passwordVerificationOtp:
                                        user.resetPassword.resetPasswordToken
                                    // widget.passwordVerificationOtp
                                    ),
                                context);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
