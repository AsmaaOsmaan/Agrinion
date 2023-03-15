import '../../Domain/Entities/commercial_profile_entity.dart';
import '../DataSourse/user_managment_network.dart';
import '../Mappers/commercial_profile_mapper.dart';

abstract class IUserManagementRepository {
  Future<List<CommercialProfileModel>> getCommercialProfiles();
  Future<List<CommercialProfileModel>> getMerchantsCommercialProfiles();
  Future<List<CommercialProfileModel>> getFarmersCommercialProfiles();
  Future<List<CommercialProfileModel>> getAllMerchantCommercialProfiles();
  Future<CommercialProfileModel> addCommercialProfile(
      CommercialProfileModel model);
  Future<CommercialProfileModel> editCommercialProfile(
      CommercialProfileModel model);
  Future<void> deleteCommercialProfile(int id);
}

class UserManagementRepository implements IUserManagementRepository {
  IUserManagementNetworking userManagmentNetworking;
  UserManagementRepository(this.userManagmentNetworking);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<CommercialProfileModel> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse
        .map((e) => CommercialProfileMapper.fromJson(e))
        .toList();
  }

  CommercialProfileModel convertToModel(Map<String, dynamic> jsonResponse) {
    return CommercialProfileMapper.fromJson(jsonResponse);
  }

  @override
  Future<List<CommercialProfileModel>> getCommercialProfiles() async {
    final response = await userManagmentNetworking.getAllCommercialProfiles();
    final jsonResponse = convertToListJson(response);
    final commercialProfiles = convertToListModel(jsonResponse);
    return commercialProfiles;
  }

  @override
  Future<List<CommercialProfileModel>>
      getAllMerchantCommercialProfiles() async {
    final response =
        await userManagmentNetworking.getAllMerchantCommercialProfiles();
    final jsonResponse = convertToListJson(response);
    final commercialProfiles = convertToListModel(jsonResponse);

    return commercialProfiles;
  }

  @override
  Future<List<CommercialProfileModel>> getMerchantsCommercialProfiles() async {
    final response =
        await userManagmentNetworking.getMerchantsCommercialProfiles();
    final jsonResponse = convertToListJson(response);
    final commercialProfiles = convertToListModel(jsonResponse);
    return commercialProfiles;
  }

  @override
  Future<List<CommercialProfileModel>> getFarmersCommercialProfiles() async {
    final response =
        await userManagmentNetworking.getFarmersCommercialProfiles();
    final jsonResponse = convertToListJson(response);
    final commercialProfiles = convertToListModel(jsonResponse);
    return commercialProfiles;
  }

  // @override
  // Future<List<CommercialProfileModel>> getAllMerchantCommercialProfiles() async {
  //  final response = await userManagmentNetworking.getAllMerchantCommercialProfiles();
  // final jsonResponse = convertToListJson(response);
  // final commercialProfiles = convertToListModel(jsonResponse);

  //  return commercialProfiles;
  // }

  @override
  Future<CommercialProfileModel> addCommercialProfile(
      CommercialProfileModel model) async {
    final response = await userManagmentNetworking.addCommercialProfile(
        CommercialProfileMapper.toJson(model), model.type!);

    final jsonResponse = convertToJson(response);
    final commercialProfile = convertToModel(jsonResponse);
    return commercialProfile;
  }

  @override
  Future<CommercialProfileModel> editCommercialProfile(
      CommercialProfileModel model) async {
    final response = await userManagmentNetworking.editCommercialProfile(
        CommercialProfileMapper.toJson(model), model.id!);
    final jsonResponse = convertToJson(response.data);
    final commercialProfile = convertToModel(jsonResponse);
    return commercialProfile;
  }

  @override
  Future<void> deleteCommercialProfile(int id) async {
    await userManagmentNetworking.deleteCommercialProfile(id);
  }
}
