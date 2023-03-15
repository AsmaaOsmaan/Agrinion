import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/cities_errors.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/cities_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('cities fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "name_ar": "مدينة",
      "name_en": "City",
    };
    Cities response = Cities(
      nameAr: "مدينة",
      nameEn: "City",
      id: 1,
    );
    test('fromJson takes json returns object of City', () {
      var fromJson = CitiesMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns city with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      CitiesErrors error = CitiesErrors(nameAr: "already been taken");
      var fromJson = CitiesMapper.fromJson(json);
      expect(fromJson.errors, error);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        CitiesMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    Cities city = Cities(nameAr: 'مدينة', nameEn: 'Cities');
    Map<String, dynamic> json = {
      "name_ar": "مدينة",
      "name_en": "Cities",
    };
    test('toJson takes Object and return Json', () {
      var fromJson = CitiesMapper.toJson(city);
      expect(fromJson, json);
    });
  });
}
