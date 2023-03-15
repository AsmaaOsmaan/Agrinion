import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_error.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit type fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "name_ar": "اسم",
      "name_en": "Name",
    };
    UnitType response = UnitType(
      nameAr: "اسم",
      nameEn: "Name",
      id: 1,
    );
    test('fromJson takes json returns object of Category', () {
      var fromJson = UnitTypeMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns city with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      UnitTypeError error = UnitTypeError(nameAr: "already been taken");
      var fromJson = UnitTypeMapper.fromJson(json);
      expect(fromJson.error, error);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        UnitTypeMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('Unit type fromPrJson test cases', () {
    Map<String, dynamic> json = {
      "unit_type_id": 1,
      "name_ar": "اسم",
      "name_en": "Name",
    };
    UnitType response = UnitType(
      nameAr: "اسم",
      nameEn: "Name",
      id: 1,
    );
    test('fromJson takes json returns object of unit type', () {
      var fromJson = UnitTypeMapper.fromPriceListJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns unittype with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      UnitTypeError error = UnitTypeError(nameAr: "already been taken");
      var fromJson = UnitTypeMapper.fromPriceListJson(json);
      expect(fromJson.error, error);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        UnitTypeMapper.fromPriceListJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    UnitType unitType = UnitType(
      nameAr: 'إسم',
      nameEn: 'UnitType',
    );

    test('toJson takes Object and return Json', () {
      Map<String, dynamic> json = {
        'name_ar': 'إسم',
        'name_en': 'UnitType',
      };
      var fromJson = UnitTypeMapper.toJson(unitType);
      expect(fromJson, json);
    });
  });
}
