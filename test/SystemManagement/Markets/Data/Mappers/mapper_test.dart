import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/markets_errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Markets fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "name_ar": "سوق",
      "name_en": "Market",
      "errors": null,
    };
    Market response = Market(
      nameAr: "سوق",
      nameEn: "Market",
      id: 1,
    );
    test('fromJson takes json returns object of Market', () {
      var fromJson = MarketsMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json returns Market with error', () {
      json['errors'] = {
        "name_ar": ["already been taken"]
      };
      MarketsError error = MarketsError(nameAr: "already been taken");
      var fromJson = MarketsMapper.fromJson(json);
      expect(fromJson.errors, error);
    });

    test('fromJson takes wrong json throws exception', () {
      try {
        MarketsMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });

  group('toJson function test cases', () {
    Market product = Market(
      nameAr: 'سوق',
      nameEn: 'Market',
    );
    Map<String, dynamic> json = {
      "name_ar": "سوق",
      "name_en": "Market",
    };
    test('toJson takes Object and return Json', () {
      var fromJson = MarketsMapper.toJson(product);
      expect(fromJson, json);
    });
  });
}
