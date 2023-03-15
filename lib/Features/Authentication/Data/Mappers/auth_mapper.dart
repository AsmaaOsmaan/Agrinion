import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/auth_validation_errors.dart';

import '../../../../App/Utilities/utils.dart';
import '../../Domain/Models/user_entity.dart';
import '../../Domain/Models/user_request_model.dart';

class AuthMapper {
  static Map<String, dynamic> loginToJson(LoginRequest model) {
    return {
      "session": {
        "mobile": "+966" + model.phone,
        "password": model.password,
      }
    };
  }

  static Map<String, dynamic> registerToJson(RegisterRequest model) {
    return {
      Utils.substring(model.role): {
        "mobile": "+966" + model.phone,
        "password": model.password,
        "password_confirmation": model.passwordConfirmation,
      }
    };
  }

  static User userFromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'],
        phone: json['mobile'],
        token: json['access_token'],
        type: json['type'],
        parent: json['parent'],
        hasParent: json['has_parent'],
        errors:
            json['errors'] != null ? AuthError.fromJson(json['errors']) : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, mobile: , access_token: , type: , has_parent: false, parent: false, errors: null} , but found this : $json");
    }
  }

  static RegisterResponse registerFromJson(Map<String, dynamic> json) {
    try {
      return RegisterResponse(
        id: json['id'],
        mobile: json['mobile'],
        confirmed: json['confirmed'],
        errors: json['errors'] != null ? AuthError.fromJson(json) : null,
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, mobile: , confirmed: true, errors: null}, but found this : $json");
    }
  }

  static ForgetPasswordRes forgetPasswordFromJson(Map<String, dynamic> json) {
    try {
      return ForgetPasswordRes(
        mobile: json['mobile'],
        otpCode: json['reset_password_otp'],
        errors: json['errors'] != null ? AuthError.fromForgetJson(json) : null,
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{mobile: , reset_password_otp: , errors: null}, but found this : $json");
    }
  }

  static Map<String, dynamic> forgetPasswordToJson(ForgetPasswordRes response) {
    Map<String, dynamic> _data = <String, dynamic>{};
    _data['mobile'] = response.mobile;
    _data['reset_password_otp'] = response.otpCode;
    return _data;
  }

  static VerifyOTPRes verifyOTPFromJson(Map<String, dynamic> json) {
    try {
      return VerifyOTPRes(
        passwordToken: json['reset_password_token'],
        errors: json['errors'] != null ? AuthError.fromJson(json) : null,
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{reset_password_token: , errors: null}, but found this : $json");
    }
  }
}
