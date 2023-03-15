import 'package:agriunion/Features/Authentication/Presentation/Screens/set_password_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/validator.dart';
import '../ViewLogic/users_vl.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  TextEditingController oldPasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersVL>(builder: (context, user, child) {
      return Scaffold(
        appBar: AppBar(title: Text(tr("change_password"))),
        body: ModalProgressHUD(
          inAsyncCall: user.isLoading,
          child: Container(
            padding: EdgeInsets.only(top: SizeConfig.defaultSize! * 3),
            margin: EdgeInsets.symmetric(
                vertical: SizeConfig.defaultSize! * 2,
                horizontal: SizeConfig.defaultSize! * 2),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    controller: oldPasswordController,
                    decoration: InputDecoration(hintText: tr("current_pass")),
                    validator: (value) => Validator().validateEmpty(value!),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2,
                  ),
                  AppButton(
                    title: tr("send"),
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        await user.resetUserPassword(
                          oldPasswordController.text,
                        );
                        user.resetPassword.errors != null
                            ? LoadingDialog.showSimpleToast(
                                user.resetPassword.errors!.error)
                            : AppRoute().navigate(
                                context: context,
                                route: const SetPasswordScreen(
                                  fromForgetPassword: false,
                                  // passwordVerificationOtp:
                                  //     user.resetPassword.resetPasswordToken,
                                ));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
