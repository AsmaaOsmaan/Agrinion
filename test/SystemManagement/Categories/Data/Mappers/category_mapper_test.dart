import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_errors.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Categories fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "name_ar": "اسم",
      "name_en": "Name",
      "active": false,
      "published": false,
    };
    Categories response = Categories(
      name: "اسم",
      nameEn: "Name",
      id: 1,
      isActive: false,
      isPublished: false,
    );
    test('fromJson takes json returns object of Category', () {
      var fromJson = CategoriesMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns city with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      CategoriesError error = CategoriesError(nameAr: "already been taken");
      var fromJson = CategoriesMapper.fromJson(json);
      expect(fromJson.errors, error);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        CategoriesMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    Categories category = Categories(
      name: 'إسم',
      nameEn: 'Categories',
      isActive: false,
      isPublished: false,
    );

    test('toCategoryJson takes Object and return Json', () {
      Map<String, dynamic> categoryJson = {
        "category": {
          'name_ar': 'إسم',
          'name_en': 'Categories',
          'active': false,
          'published': false,
          'category_group_id': null,
          'color': null
        }
      };
      var fromJson = CategoriesMapper.toCategoryJson(category);
      expect(fromJson, categoryJson);
    });
    test('toCategoryGroupJson takes Object and return Json', () {
      Map<String, dynamic> categoryGroupJson = {
        "category_group": {
          'name_ar': 'إسم',
          'name_en': 'Categories',
          'active': false,
          'published': false,
          'color': null
        }
      };
      var fromJson = CategoriesMapper.toCategoryGroupJson(category);
      expect(fromJson, categoryGroupJson);
    });
  });
}
