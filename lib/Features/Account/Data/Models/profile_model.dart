import 'dart:convert';
import 'dart:io';

import '../../../../App/Utilities/cache_helper.dart';
import '../../../../App/constants/keys.dart';
import '../../../Orders/Domain/Entities/create_order_model.dart';
import 'profile_mapper.dart';

class Profile {
  int? id;
  String? bio;
  String? name;
  String? profileName;
  String? secondaryName;
  String? address;
  String? city;
  String? neighbourhood;
  String? postalCode;
  String? street;
  String? email;
  String? taxNumber;
  String? commercialRegister;
  Creator? creator;
  File? uploadedImage;
  String? avatar;
  double? taxRate;

  Profile(
      {this.bio,
      this.name,
      this.profileName,
      this.secondaryName,
      this.address,
      this.city,
      this.neighbourhood,
      this.postalCode,
      this.street,
      this.email,
      this.taxNumber,
      this.commercialRegister,
      this.creator,
      this.id,
      this.avatar,
      this.uploadedImage,
      this.taxRate});

  static Profile? stored() {
    String cachedResponse = CachHelper.getData(key: kProfile);
    var json = jsonDecode(cachedResponse);
    var profile = ProfileMapper.fromJson(json);
    return profile;
  }

  static void cachProfile(Profile profile) {
    Map<String, dynamic> profileMap = ProfileMapper.toCachJson(profile);
    String profileEncoded = jsonEncode(profileMap);
    CachHelper.saveData(key: kProfile, value: profileEncoded);
  }
}
