import 'package:agriunion/Features/Account/Data/Models/reset_password.dart';

class ResetPassWordMapper {
  static ResetPassword fromJson(Map<String, dynamic> json) {
    return ResetPassword(
      resetPasswordToken: json['reset_password_token'],
      errors: json['errors'] != null
          ? ResetPasswordErrorMapper.fromJson(json)
          : null,
    );
  }

  static Map<String, dynamic> toJson(String oldPassword) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    return data;
  }
}

class ResetPasswordErrorMapper {
  static ResetPasswordError fromJson(Map<String, dynamic> json) {
    return ResetPasswordError(
      error: json['errors'],
      // oldPassWord: json['oldPassWord'] ?? 0,
    );
  }

  static Map<String, dynamic> toJson(ResetPasswordError resetPasswordError) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = resetPasswordError.error;
    return data;
  }
}
