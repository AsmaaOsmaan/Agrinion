import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Utilities/api_handler.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/Features/Account/Data/Models/set_password_model.dart';
import 'package:agriunion/Features/Account/Presentation/Screens/complete_profile.dart';
import 'package:agriunion/Features/Authentication/Domain/service_layer.dart';
import 'package:agriunion/Features/Authentication/Presentation/Screens/auth_screen.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:agriunion/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/constants/keys.dart';
import '../../../Home/Presentation/Screens/home_screen.dart';
import '../../Domain/Models/user_entity.dart';
import '../../Domain/Models/user_request_model.dart';
import '../Screens/set_password_screen.dart';
import '../Widgets/otp_screen.dart';

class AuthVL extends ChangeNotifier {
  IAuthService service;
  AuthVL(this.service);
  User? user;
  login(LoginRequest model, BuildContext context) async {
    LoadingDialog.showLoadingDialog();

    try {
      user = await service.login(model);

      if (user != null) {
        EasyLoading.dismiss();

        AppRoute()
            .navigateAndRemove(context: context, route: const HomeScreen());
      } else {
        LoadingDialog.showSimpleToast("Something went wrong");
        EasyLoading.dismiss();
      }
    } on Exception catch (e) {
      EasyLoading.dismiss();
      if (e is UnAuthorizeException) {
        LoadingDialog.showSimpleToast(tr(LocaleKeys.credentialsError));
      } else {
        APIHandler.handleExceptions(e);
      }
    }
  }

  RegisterResponse? registeredAccount;
  register(RegisterRequest user, BuildContext context) async {
    LoadingDialog.showLoadingDialog();

    registeredAccount = await service.register (user).catchError((e) {
      EasyLoading.dismiss();
      APIHandler.handleExceptions(e);
    });
    EasyLoading.dismiss();
    if (registeredAccount?.errors == null) {
      AppRoute().navigate(
        context: context,
        route: OTPVerification(
          role: user.role,
          id: registeredAccount!.id!,
        ),
      );
    }
    notifyListeners();
  }

  verifyUser(String role, int id, String code, BuildContext context) async {
    LoadingDialog.showLoadingDialog();

    User result = await service.verify(role, id, code).catchError((e) {
      EasyLoading.dismiss();
      APIHandler.handleExceptions(e);
    });
    User.saveUser(result);
    User.saveUserSession(result);
    EasyLoading.dismiss();
    CachHelper.saveData(value: result.phone, key: kPhone);

    AppRoute().navigateAndRemove(
      context: context,
      route: const CompleteProfile(),
    );
    return result;
  }

  ForgetPasswordRes? forgetPasswordRes;
  String? forgetErrorText;
  Future<void> forgetPassword(String mobile) async {
    forgetPasswordRes = await service.forgetPassword(mobile);
    if (forgetPasswordRes!.errors == null) {
      AppRoute().navigate(
        context: navKey.currentState!.context,
        route: const OTPVerification(),
      );
    } else {
      forgetErrorText = forgetPasswordRes!.errors!.mobile;
    }
    notifyListeners();
  }

  VerifyOTPRes? verifyOTPRes;
  Future<void> verifyOTP(BuildContext context, String otpCode) async {
    if (otpCode == forgetPasswordRes!.otpCode) {
      verifyOTPRes = await service.verifyOTP(forgetPasswordRes!);
      if (verifyOTPRes!.errors == null) {
        AppRoute().navigate(
            context: context,
            route: const SetPasswordScreen(
              fromForgetPassword: true,
            ));
      }
      notifyListeners();
    } else {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.otp_not_correct));
    }
  }

  Future<void> setPassword(String password, String confirmedPassword) async {
    LoadingDialog.showLoadingDialog();

    var response = await service.setNewPassword(SetPasswordModel(
        newPassword: password,
        passwordConfirmation: confirmedPassword,
        passwordVerificationOtp: verifyOTPRes!.passwordToken!));
    if (response.msg != null) {
      LoadingDialog.showSimpleToast(response.msg);
      AppRoute().navigateAndRemove(
        context: navKey.currentState!.context,
        route: const AuthScreen(),
      );
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();

    notifyListeners();
  }

  manageOTPRoute(String code, BuildContext context, [String? role, int? id]) {
    if (role == null) {
      verifyOTP(context, code);
    } else {
      verifyUser(role, id!, code, context);
    }
  }

  void rememberMe(bool remember) {
    if (remember) {
      CachHelper.saveData(key: kRemember, value: remember);
    }
  }
}
