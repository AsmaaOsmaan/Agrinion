import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/PricesList/Data/Mappers/price_item_mapper.dart';
import 'package:agriunion/Features/PricesList/Domain/Models/price_item_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('price list fromjson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "min_price": 27.0,
      "max_price": 200.0,
      "product": {"product_id": 1, "name_ar": "تفاح", "name_en": "apple"},
      "unit_type": {"unit_type_id": 1, "name_ar": "كيلو جرام", "name_en": "Kg"},
    };
    PriceItemModel response = PriceItemModel(
        id: 1,
        minPrice: 27.0,
        maxPrice: 200.0,
        unitType: UnitTypeMapper.fromPriceListJson(json['unit_type']),
        product: ProductsMapper.fromJson(json['product']));
    test('fromJson takes json returns object of pricelist', () {
      var fromJson = PriceItemMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        PriceItemMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    PriceItemModel model = PriceItemModel(
      product: Product(nameAr: 'name', nameEn: 'name', id: 1),
      weight: 50,
      maxPrice: 50,
      minPrice: 50,
      priceListId: 1,
      unitType: UnitType(nameAr: '', nameEn: 'name', id: 1),
      marketId: 1,
    );
    Map<String, dynamic> json = {
      'price_list_item': {
        "market_id": 1,
        "product_id": 1,
        "unit_type_id": 1,
        "price_list_id": 1,
        'min_price': 50,
        'max_price': 50,
        'weight': 50,
      }
    };
    test('toJson takes Object and return Json', () {
      var fromJson = PriceItemMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
