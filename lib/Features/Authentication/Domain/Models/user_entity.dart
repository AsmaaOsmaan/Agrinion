import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/globale_state.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/auth_validation_errors.dart';

class User {
  final int id;
  final String phone;
  final String token;
  final String type;
  final AuthError? errors;
  final bool? parent;
  final bool? hasParent;

  const User({
    required this.id,
    required this.phone,
    required this.token,
    required this.type,
    this.errors,
    this.hasParent,
    this.parent,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          phone == other.phone &&
          token == other.token &&
          type == other.type &&
          parent == other.parent &&
          errors == other.errors &&
          hasParent == other.hasParent;

  @override
  int get hashCode => id.hashCode;

  static saveUser(User user) {
    CachHelper.saveData(value: user.phone, key: kPhone);
    CachHelper.saveData(value: user.token, key: kToken);
    CachHelper.saveData(value: user.type, key: kType);
    CachHelper.saveData(value: user.parent, key: kParent);
    CachHelper.saveData(value: user.hasParent, key: kHasParent);
    CachHelper.saveData(value: user.id, key: kId);
  }

  static saveUserSession(User user) {
    GlobalState.instance.set(kPhone, user.phone);
    GlobalState.instance.set(kToken, user.token);
    GlobalState.instance.set(kType, user.type);
    GlobalState.instance.set(kParent, user.parent);
    GlobalState.instance.set(kHasParent, user.hasParent);
    GlobalState.instance.set(kId, user.id);
  }
}

class RegisterResponse {
  final int? id;
  final String? mobile;
  final bool? confirmed;
  final AuthError? errors;

  RegisterResponse({
    this.id,
    this.mobile,
    this.confirmed,
    this.errors,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          mobile == other.mobile &&
          confirmed == other.confirmed &&
          errors == other.errors;

  @override
  int get hashCode => id.hashCode;
}

class ForgetPasswordRes {
  String? mobile;
  String? otpCode;
  AuthError? errors;
  ForgetPasswordRes({this.mobile, this.otpCode, this.errors});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgetPasswordRes &&
          runtimeType == other.runtimeType &&
          mobile == other.mobile &&
          otpCode == other.otpCode &&
          errors == other.errors;

  @override
  int get hashCode => mobile.hashCode;
}

class VerifyOTPRes {
  String? passwordToken;
  AuthError? errors;
  VerifyOTPRes({this.passwordToken, this.errors});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerifyOTPRes &&
          runtimeType == other.runtimeType &&
          passwordToken == other.passwordToken &&
          errors == other.errors;

  @override
  int get hashCode => passwordToken.hashCode;
}
