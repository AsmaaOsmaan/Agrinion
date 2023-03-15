import 'package:agriunion/Features/Account/Data/DataSource/profile_networking.dart';
import 'package:agriunion/Features/Account/Data/Models/profile_mapper.dart';
import 'package:agriunion/Features/Account/Data/Models/profile_model.dart';
import 'package:agriunion/Features/Account/Data/Models/reset_password.dart';
import 'package:agriunion/Features/Account/Data/Models/reset_password_mapper.dart';

import '../../../../App/Utilities/utils.dart';
import '../Models/set_password_mapper.dart';
import '../Models/set_password_model.dart';

abstract class IProfileRepository {
  Future<Profile> updateProfile(Profile data);
  Future<Profile> getProfile();
  Future<ResetPassword> resetPassword(String data);
  Future<SetPasswordModel> setPassword(SetPasswordModel setPasswordModel);
}

class ProfileRepository implements IProfileRepository {
  IProfileNetworking profileNetworking;
  ProfileRepository(this.profileNetworking);

  Profile convertToModel(Map<String, dynamic> jsonResponse) {
    return ProfileMapper.fromJson(jsonResponse);
  }

  ResetPassword convertToModelResetPassword(Map<String, dynamic> jsonResponse) {
    return ResetPassWordMapper.fromJson(jsonResponse);
  }

  SetPasswordModel convertToModelSetPassword(
      Map<String, dynamic> jsonResponse) {
    return SetPassWordMapper.fromJson(jsonResponse);
  }

  @override
  Future<Profile> updateProfile(Profile data) async {
    final response = await profileNetworking.updateCommercialProfile(
      ProfileMapper.toJson(data),
    );
    final jsonResponse = Utils.convertToJson(response.data);
    final profile = convertToModel(jsonResponse);
    return profile;
  }

  @override
  Future<ResetPassword> resetPassword(String oldPassword) async {
    final response = await profileNetworking.resetPassword(
      ResetPassWordMapper.toJson(oldPassword),
    );
    final jsonResponse = Utils.convertToJson(response);
    final resetPasswordResponse = convertToModelResetPassword(jsonResponse);
    return resetPasswordResponse;
  }

  @override
  Future<SetPasswordModel> setPassword(
      SetPasswordModel setPasswordModel) async {
    final response = await profileNetworking.setPassword(
      SetPassWordMapper.toJson(setPasswordModel),
    );
    final jsonResponse = Utils.convertToJson(response);
    final setPasswordResponse = convertToModelSetPassword(jsonResponse);
    return setPasswordResponse;
  }

  @override
  Future<Profile> getProfile() async {
    final response = await profileNetworking.getProfile();
    final jsonResponse = Utils.convertToJson(response);
    final profile = convertToModel(jsonResponse);
    return profile;
  }
}
