import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/cities_errors.dart';

import 'city_entity.dart';

class CitiesMapper {
  static Cities fromJson(Map<String, dynamic> json) {
    try {
      return Cities(
        id: json['id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        errors: json['errors'] != null ? CitiesErrors.fromJson(json) : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(Cities city) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = city.nameAr;
    data['name_en'] = city.nameEn;

    return data;
  }
}
