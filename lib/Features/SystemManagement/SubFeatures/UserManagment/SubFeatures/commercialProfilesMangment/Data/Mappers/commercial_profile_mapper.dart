import 'package:agriunion/App/Errors/exceptions.dart';

import '../../../../../../../Orders/Data/Mappers/create_order_mapper.dart';
import '../../Domain/Entities/commercial_profile_entity.dart';

class CommercialProfileMapper {
  static CommercialProfileModel fromJson(Map<String, dynamic> json) {
    try {
      return CommercialProfileModel(
        id: json['id'],
        bio: json['bio'] ?? "",
        address: json['address'] ?? "",
        profileName: json['profile_name'] ?? "",
        secondaryName: json['secondary_profile_name'] ?? "",
        commercialRegister: json['commercial_register'] ?? "",
        taxNumber: json['tax_number'] ?? "",
        email: json['email'] ?? "",
        creator: json['creator'] != null
            ? CreatorMapper.fromJson(json['creator'])
            : null,
        street: json['street'] ?? "",
        city: json['city'] ?? "",
        neighbourhood: json['area'] ?? "",
        postalCode: json['postal_code'] ?? "",
        type: json['type'] ?? "",
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(CommercialProfileModel profile) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = profile.bio;
    data['address'] = profile.address;
    data['profile_name'] = profile.profileName;
    data['secondary_profile_name'] = profile.secondaryName;
    data['email'] = profile.email!.isEmpty ? null : profile.email;
    data['type'] = profile.type;
    data['tax_number'] = profile.taxNumber;
    data['commercial_register'] = profile.commercialRegister;
    data['city'] = profile.city;
    data['area'] = profile.neighbourhood;
    data['postal_code'] = profile.postalCode;
    data['street'] = profile.street;
    return data;
  }
}
