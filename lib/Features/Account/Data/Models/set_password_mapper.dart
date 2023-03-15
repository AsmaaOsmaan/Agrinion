import 'package:agriunion/Features/Account/Data/Models/reset_password.dart';
import 'package:agriunion/Features/Account/Data/Models/set_password_model.dart';


class SetPassWordMapper {
  static SetPasswordModel fromJson(Map<String, dynamic> json) {
    return SetPasswordModel(
      msg:json['msg'] ,
      errors: json['errors'] != null ? SetPasswordErrorMapper.fromJson(json['errors']) : null,

      // oldPassWord: json['oldPassWord'] ?? 0,

    );
  }

  static Map<String, dynamic> toJson(SetPasswordModel setPasswordModel) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = setPasswordModel.newPassword;
    data['password_confirmation'] = setPasswordModel.passwordConfirmation;
    data['password_verification_otp'] = setPasswordModel.passwordVerificationOtp;
    return {"password": data};
  }
}


class SetPasswordErrorMapper{
  static SetPasswordErrors fromJson(Map<String, dynamic> json) {
    return SetPasswordErrors(
      passwordConfirmation: json['password_confirmation'] [0],
      // oldPassWord: json['oldPassWord'] ?? 0,

    );
  }

  static Map<String, dynamic> toJson(ResetPasswordError resetPasswordError) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = resetPasswordError.error;
    return data;
  }
}
