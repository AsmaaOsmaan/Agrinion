import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Authentication/Data/Mappers/auth_mapper.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/auth_validation_errors.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/user_entity.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/user_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('auth fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "mobile": "",
      "access_token": "",
      "type": "",
      "has_parent": false,
      "parent": false,
      "errors": null,
    };
    User response = const User(
      id: 1,
      phone: '',
      token: '',
      type: '',
      hasParent: false,
      parent: false,
    );
    test('userFromJson takes json returns object of User', () {
      var fromJson = AuthMapper.userFromJson(json);
      expect(fromJson, response);
    });
    test('userFromJson takes json returns user with error', () {
      json['errors'] = {
        'errors': {
          "mobile": ["error"]
        }
      };
      AuthError error = AuthError(mobile: "error");
      var fromJson = AuthMapper.userFromJson(json);
      expect(fromJson.errors, error);
    });
    test('userFromJson takes wrong json returns null', () {
      try {
        AuthMapper.userFromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });

    Map<String, dynamic> registerJson = {
      "id": 1,
      "mobile": "",
      "confirmed": true,
      "errors": null,
    };
    RegisterResponse registerRes =
        RegisterResponse(id: 1, confirmed: true, errors: null, mobile: '');
    test('registerFromJson takes json returns object of register response', () {
      var fromJson = AuthMapper.registerFromJson(registerJson);
      expect(fromJson, registerRes);
    });
    test('registerFromJson takes json returns register Res with error', () {
      registerJson['errors'] = {
        "mobile": ["error"]
      };
      AuthError error = AuthError(mobile: "error");
      var fromJson = AuthMapper.registerFromJson(registerJson);
      expect(fromJson.errors, error);
    });
    test('registerFromJson takes wrong json returns null', () {
      try {
        AuthMapper.registerFromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
    Map<String, dynamic> forgetPasswordJson = {
      "mobile": "",
      "reset_password_otp": '',
      "errors": null,
    };
    ForgetPasswordRes forgetRes =
        ForgetPasswordRes(errors: null, mobile: '', otpCode: '');
    test('forgetPasswordFromJson takes json returns object of forget response',
        () {
      var fromJson = AuthMapper.forgetPasswordFromJson(forgetPasswordJson);
      expect(fromJson, forgetRes);
    });
    test('forgetPasswordFromJson takes json returns forgetPass with error', () {
      forgetPasswordJson['errors'] = "error";
      AuthError error = AuthError(mobile: "error");
      var fromJson = AuthMapper.forgetPasswordFromJson(forgetPasswordJson);
      expect(fromJson.errors, error);
    });
    test('forgetPasswordFromJson takes wrong json returns null', () {
      try {
        AuthMapper.forgetPasswordFromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });

    Map<String, dynamic> verifyOTPJson = {
      "reset_password_token": '',
      "errors": null,
    };
    VerifyOTPRes verifyOTPRes = VerifyOTPRes(errors: null, passwordToken: '');
    test('verifyOTPFromJson takes json returns object of verify', () {
      var fromJson = AuthMapper.verifyOTPFromJson(verifyOTPJson);
      expect(fromJson, verifyOTPRes);
    });
    test('verifyOTPFromJson takes json returns verify with error', () {
      verifyOTPJson['errors'] = {
        "mobile": ["error"]
      };
      AuthError error = AuthError(mobile: "error");
      var fromJson = AuthMapper.verifyOTPFromJson(verifyOTPJson);
      expect(fromJson.errors, error);
    });
    test('verifyOTPFromJson takes wrong json returns null', () {
      try {
        AuthMapper.verifyOTPFromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });

  group('toJson function test cases', () {
    test('loginToJson takes Object and return Json', () {
      LoginRequest login =
          const LoginRequest(phone: '555555555', password: '123456');
      Map<String, dynamic> json = {
        'session': {
          "mobile": "+966555555555",
          "password": "123456",
        }
      };
      var fromJson = AuthMapper.loginToJson(login);
      expect(fromJson, json);
    });
    test('toJson takes Object and return Json', () {
      RegisterRequest register = const RegisterRequest(
        phone: '555555555',
        password: '123456',
        passwordConfirmation: '123456',
        role: 'farmers',
      );
      Map<String, dynamic> json = {
        Utils.substring(register.role): {
          "mobile": "+966555555555",
          "password": "123456",
          'password_confirmation': '123456',
        }
      };
      var fromJson = AuthMapper.registerToJson(register);
      expect(fromJson, json);
    });
    test('forgetPassword takes Object and return Json', () {
      ForgetPasswordRes forget =
          ForgetPasswordRes(mobile: '555555555', otpCode: '123456');
      Map<String, dynamic> json = {
        "mobile": "555555555",
        "reset_password_otp": "123456",
      };
      var fromJson = AuthMapper.forgetPasswordToJson(forget);
      expect(fromJson, json);
    });
  });
}
