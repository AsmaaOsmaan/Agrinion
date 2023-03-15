import 'package:agriunion/Features/Account/Data/Models/profile_model.dart';

import '../../../../App/Network/network_helper.dart';
import '../../../Orders/Data/Mappers/create_order_mapper.dart';

class ProfileMapper {
  static Profile fromJson(Map<String, dynamic> json) {
    return Profile(
        name: json['username'] ?? "",
        id: json['id'] ?? 0,
        bio: json['bio'] ?? "",
        profileName: json['profile_name'] ?? "",
        secondaryName:json['secondary_profile_name'] ?? "" ,
        address:json['address'] ?? "" ,
        commercialRegister: json['commercial_register'] ?? "",
        taxNumber: json['tax_number'] ?? "",
        email: json['email'] ?? "",
        creator: json['creator'] != null
            ? CreatorMapper.fromJson(json['creator'])
            : null,
        avatar: json['avatar'] != null
            ? NetworkHelper.apiBaseUrl! + json['avatar']
            : null,
        taxRate: json['applied_tax_rate'],
        street: json['street'] ?? "",
        city: json['city'] ?? "",
        neighbourhood: json['area'] ?? "",
        postalCode: json['postal_code'] ?? "",


    );

  }

  static Map<String, dynamic> toJson(Profile profile) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = profile.bio == "" ? null : profile.bio;
    data['name'] = profile.name == "" ? null : profile.name;
    data['profile_name'] = profile.profileName !.isEmpty ? null : profile.profileName;
    data['secondary_profile_name'] = profile.secondaryName!.isEmpty ? null : profile.secondaryName;
    data['address'] = profile.address!.isEmpty ? null : profile.address;
    data['city'] = profile.city!.isEmpty ? null : profile.city;
    data['area'] = profile.neighbourhood!.isEmpty ? null : profile.neighbourhood;
    data['postal_code'] = profile.postalCode!.isEmpty ? null : profile.postalCode;
    data['street'] = profile.street!.isEmpty ? null : profile.street;
    data['email'] = profile.email == "" ? null : profile.email;
    data['tax_number'] = profile.taxNumber == "" ? null : profile.taxNumber;
    data['commercial_register'] =
        profile.commercialRegister == "" ? null : profile.commercialRegister;
    data['avatar'] = profile.uploadedImage;
    data['applied_tax_rate'] = profile.taxRate != null ? profile.taxRate! : null;

    return {"profile": data};
  }

  static Map<String, dynamic> toCachJson(Profile profile) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = profile.bio == "" ? null : profile.bio;
    data['username'] = profile.name == "" ? null : profile.name;
    data['profile_name'] =
        profile.profileName == "" ? null : profile.profileName;
    data['email'] = profile.email == "" ? null : profile.email;
    data['tax_number'] = profile.taxNumber == "" ? null : profile.taxNumber;
    data['commercial_register'] =
        profile.commercialRegister == "" ? null : profile.commercialRegister;
    data['avatar'] = profile.avatar;
    return data;
  }
}
