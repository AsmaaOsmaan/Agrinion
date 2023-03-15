import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_market_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('broker market fromJson test cases', () {
    Map<String, dynamic> json = {
      "city": {'id': 1, 'name_ar': "اسم", 'name_en': "name"},
      "market": {'id': 1, 'name_ar': "اسم", 'name_en': "name"},
    };
    BrokerMarket response = BrokerMarket(
      city: Cities(nameAr: 'اسم', nameEn: 'name', id: 1),
      market: Market(nameAr: 'اسم', nameEn: 'name', id: 1),
    );
    test('fromJson takes json returns object', () {
      var fromJson = BrokerMarketMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        BrokerMarketMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
