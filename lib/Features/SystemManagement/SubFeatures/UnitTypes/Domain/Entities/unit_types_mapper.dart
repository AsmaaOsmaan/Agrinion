import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_error.dart';

class UnitTypeMapper {
  static UnitType fromJson(Map<String, dynamic> json) {
    try {
      return UnitType(
        id: json['id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        error: json['errors'] != null ? UnitTypeError.fromJson(json) : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static UnitType fromPriceListJson(Map<String, dynamic> json) {
    try {
      return UnitType(
        id: json['unit_type_id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        error: json['errors'] != null ? UnitTypeError.fromJson(json) : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(UnitType unitType) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = unitType.nameAr;
    data['name_en'] = unitType.nameEn;

    return data;
  }
}
