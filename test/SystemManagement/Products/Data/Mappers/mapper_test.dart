import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_errors.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('products fromManagementJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "name_ar": "منتج",
      "name_en": "Product",
      "category": {"id": 1},
      "image": null,
      "errors": null,
    };
    Product response = Product(
      nameAr: "منتج",
      nameEn: "Product",
      categoryId: 1,
      id: 1,
      image: AppImages.dummyImage,
    );
    test('fromManagementJson takes json returns object of products', () {
      var fromJson = ProductsMapper.fromManagementJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns product with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      ProductsError error = ProductsError(nameAr: "already been taken");
      var fromJson = ProductsMapper.fromManagementJson(json);
      expect(fromJson.errors, error);
    });
    test("test default case for image field", () {
      var jsonWithoutCategory = json;
      jsonWithoutCategory["image"] = null;
      var fromJson = ProductsMapper.fromManagementJson(jsonWithoutCategory);
      expect(fromJson.image, null);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        ProductsMapper.fromManagementJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('products fromJson test cases', () {
    Map<String, dynamic> json = {
      "product_id": 1,
      "name_ar": "منتج",
      "name_en": "Product",
      "priceable": true,
      "errors": null,
    };
    Product response = Product(
      nameAr: "منتج",
      nameEn: "Product",
      id: 1,
      priceable: true,
    );
    test('fromJson takes json returns object of products', () {
      var fromJson = ProductsMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns product with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      ProductsError error = ProductsError(nameAr: "already been taken");
      var fromJson = ProductsMapper.fromJson(json);
      expect(fromJson.errors, error);
    });

    test('fromJson takes wrong json throws exception', () {
      try {
        ProductsMapper.fromManagementJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    Product product = Product(
      nameAr: 'منتج',
      nameEn: 'Product',
      priceable: false,
    );
    Map<String, dynamic> json = {
      "name_ar": "منتج",
      "name_en": "Product",
      'category_id': null,
      'product_image': null,
      "priceable": false,
    };
    test('toJson takes Object and return Json', () {
      var fromJson = ProductsMapper.toJson(product);
      expect(fromJson, json);
    });
  });
}
