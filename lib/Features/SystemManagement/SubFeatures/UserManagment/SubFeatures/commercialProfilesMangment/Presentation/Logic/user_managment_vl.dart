import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import 'package:flutter/foundation.dart';

import '../../Domain/ServiceLayer/service_layer.dart';

class UserManagementVL extends ChangeNotifier {
  final IUserManagementService userManagmentService;
  UserManagementVL(this.userManagmentService);
  List<CommercialProfileModel> commercialProfiles = [];
  List<CommercialProfileModel> commercialProfilesList = [];
  bool isLoading = false;

// commercial profile module

  getCommercialProfiles() async {
    isLoading = true;
    commercialProfiles = await userManagmentService.getCommercialProfiles();
    commercialProfilesList = commercialProfiles;
    isLoading = false;
    notifyListeners();
  }

  addCommercialProfile(CommercialProfileModel commercialProfile) async {
    final addedCommercialProfile =
        await userManagmentService.addCommercialProfile(commercialProfile);
    commercialProfiles.add(addedCommercialProfile);
    notifyListeners();
  }

  editCommercialProfile(CommercialProfileModel profile, int index) async {
    final editedCommercialProfile =
        await userManagmentService.editCommercialProfile(profile);
    commercialProfiles[index] = editedCommercialProfile;
    notifyListeners();
  }

  deleteCommercialProfile(CommercialProfileModel commercialProfile) async {
    await userManagmentService.deleteCommercialProfile(commercialProfile.id!);
    commercialProfiles.remove(commercialProfile);
    notifyListeners();
  }

  bool isSearch = false;
  void changeSearchState() {
    isSearch = !isSearch;
    notifyListeners();
  }

  filterCommercialProfile(String value) {
    if (value != '') {
      commercialProfiles = commercialProfilesList
          .where((element) =>
              element.profileName!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    } else {
      commercialProfiles = commercialProfilesList;
    }
    notifyListeners();
  }
}
