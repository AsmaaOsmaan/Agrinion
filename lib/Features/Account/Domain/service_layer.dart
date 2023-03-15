import 'package:agriunion/Features/Account/Data/Models/profile_model.dart';
import 'package:agriunion/Features/Account/Data/Repositories/profile_repo.dart';

import '../Data/Models/reset_password.dart';
import '../Data/Models/set_password_model.dart';

abstract class IProfileService {
  Future<Profile> updateProfile(Profile model);
  Future<Profile> getProfile();
  Future<ResetPassword> resetPassword(String oldPassword);
  Future<SetPasswordModel> setPassword(SetPasswordModel setPasswordModel);
}

class ProfileService implements IProfileService {
  IProfileRepository profileRepository;
  ProfileService(this.profileRepository);

  @override
  Future<Profile> updateProfile(Profile model) async {
    return await profileRepository.updateProfile(model);
  }

  @override
  Future<ResetPassword> resetPassword(String oldPassword) async {
    return await profileRepository.resetPassword(oldPassword);
  }

  @override
  Future<SetPasswordModel> setPassword(
      SetPasswordModel setPasswordModel) async {
    return await profileRepository.setPassword(setPasswordModel);
  }

  @override
  Future<Profile> getProfile() async {
    return await profileRepository.getProfile();
  }
}
