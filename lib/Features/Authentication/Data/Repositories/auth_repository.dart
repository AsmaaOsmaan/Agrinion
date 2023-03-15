import 'package:agriunion/Features/Authentication/Data/DataSource/auth_network.dart';

import '../../../../App/Utilities/utils.dart';
import '../../Domain/Models/user_entity.dart';
import '../../Domain/Models/user_request_model.dart';
import '../Mappers/auth_mapper.dart';

abstract class IAuthRepository {
  Future<User> login(LoginRequest model);
  Future<RegisterResponse> register(RegisterRequest model);
  Future<User> verifyUser(String role, int id, String code);
  Future<ForgetPasswordRes> forgetPassword(String mobile);
  Future<VerifyOTPRes> verifyOTP(ForgetPasswordRes res);
}

class AuthRepository implements IAuthRepository {
  IAuthNetworking authNetwork;
  AuthRepository(this.authNetwork);

  User convertToModel(Map<String, dynamic> jsonResponse) {
    return AuthMapper.userFromJson(jsonResponse);
  }

  RegisterResponse convertRegisterToModel(Map<String, dynamic> jsonResponse) {
    return AuthMapper.registerFromJson(jsonResponse);
  }

  ForgetPasswordRes convertForgetToModel(Map<String, dynamic> jsonResponse) {
    return AuthMapper.forgetPasswordFromJson(jsonResponse);
  }

  VerifyOTPRes convertVerifyToModel(Map<String, dynamic> jsonResponse) {
    return AuthMapper.verifyOTPFromJson(jsonResponse);
  }

  @override
  Future<User> login(LoginRequest model) async {
    try {
      final response = await authNetwork.login(AuthMapper.loginToJson(model));
      final jsonResponse = Utils.convertToJson(response);
      final user = convertToModel(jsonResponse);
      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest model) async {

    final response = await authNetwork.register(
      model.role,
      AuthMapper.registerToJson(model),
    );
    final jsonResponse = Utils.convertToJson(response);
    final user = convertRegisterToModel(jsonResponse);
    return user;
  }

  @override
  Future<User> verifyUser(String role, int id, String code) async {
    final response = await authNetwork.verifyUser(role, id, {
      "verification": {"confirmation_token": code}
    });
    final jsonResponse = Utils.convertToJson(response);
    final user = convertToModel(jsonResponse);
    return user;
  }

  @override
  Future<ForgetPasswordRes> forgetPassword(String mobile) async {
    final response = await authNetwork.forgetPassword(mobile);
    final jsonResponse = Utils.convertToJson(response);
    final forgetResponse = convertForgetToModel(jsonResponse);
    return forgetResponse;
  }

  @override
  Future<VerifyOTPRes> verifyOTP(ForgetPasswordRes res) async {
    final response =
        await authNetwork.verifyOTP(AuthMapper.forgetPasswordToJson(res));
    final jsonResponse = Utils.convertToJson(response);
    final result = convertVerifyToModel(jsonResponse);
    return result;
  }
}
