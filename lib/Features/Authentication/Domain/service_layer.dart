import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/Features/Account/Data/Models/set_password_model.dart';
import 'package:agriunion/Features/Account/Data/Repositories/profile_repo.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/user_entity.dart';
import 'package:agriunion/Features/Authentication/Domain/Models/user_request_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/firebase_session.dart';

import '../../../App/constants/keys.dart';
import '../../Notification/Domain/ServiceLayer/notification_service_layer.dart';
import '../Data/Repositories/auth_repository.dart';

abstract class IAuthService {
  Future<User> login(LoginRequest model);

  Future<RegisterResponse> register(RegisterRequest model);

  Future<User> verify(String role, int id, String code);

  Future<ForgetPasswordRes> forgetPassword(String mobile);

  Future<VerifyOTPRes> verifyOTP(ForgetPasswordRes res);

  Future<SetPasswordModel> setNewPassword(SetPasswordModel setPasswordModel);
}

class AuthService implements IAuthService {
  IAuthRepository authRepository;
  IProfileRepository profileRepository;
  INotificationServiceLayer notification;

  AuthService(this.authRepository, this.profileRepository, this.notification);

  @override
  Future<User> login(LoginRequest model) async {
    try {
      var user = await authRepository.login(model);
      User.saveUser(user);
      User.saveUserSession(user);
      await notification
          .sendFcmToken(FirebaseSession(CachHelper.getData(key: kfcmToken)));
      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest model) async {
    try {
      var user = await authRepository.register(model);
      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<User> verify(String role, int id, String code) async {
    var user = await authRepository.verifyUser(role, id, code);
    User.saveUser(user);
    User.saveUserSession(user);

    await notification
        .sendFcmToken(FirebaseSession(CachHelper.getData(key: kfcmToken)));
    return user;
  }

  @override
  Future<ForgetPasswordRes> forgetPassword(String mobile) async {
    return await authRepository.forgetPassword(mobile);
  }

  @override
  Future<VerifyOTPRes> verifyOTP(ForgetPasswordRes res) async {
    return await authRepository.verifyOTP(res);
  }

  @override
  Future<SetPasswordModel> setNewPassword(
      SetPasswordModel setPasswordModel) async {
    return await profileRepository.setPassword(setPasswordModel);
  }
}
