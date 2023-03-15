import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';

import '../../Data/Repositories/user_managment_repo_impl.dart';

abstract class IUserManagementService {
  Future<List<CommercialProfileModel>> getCommercialProfiles();
  Future<CommercialProfileModel> addCommercialProfile(
      CommercialProfileModel commercialProfile);
  Future<CommercialProfileModel> editCommercialProfile(
      CommercialProfileModel commercialProfile);
  Future<void> deleteCommercialProfile(int id);
}

class UserManagmentService implements IUserManagementService {
  IUserManagementRepository userManagmentRepo;

  UserManagmentService(this.userManagmentRepo);

  @override
  Future<List<CommercialProfileModel>> getCommercialProfiles() async {
    return await userManagmentRepo.getCommercialProfiles();
  }

  @override
  Future<CommercialProfileModel> addCommercialProfile(
      CommercialProfileModel commercialProfile) async {
    return await userManagmentRepo.addCommercialProfile(commercialProfile);
  }

  @override
  Future<CommercialProfileModel> editCommercialProfile(
      CommercialProfileModel commercialProfile) async {
    return await userManagmentRepo.editCommercialProfile(commercialProfile);
  }

  @override
  Future<void> deleteCommercialProfile(int id) async {
    await userManagmentRepo.deleteCommercialProfile(id);
  }
}
