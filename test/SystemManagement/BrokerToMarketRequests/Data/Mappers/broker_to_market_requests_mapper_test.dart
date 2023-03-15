import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Data/Mappers/broker_to_market_request_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/broker_to_market_requests_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('broker to market requests fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      'market': {'name_ar': "اسم", 'name_en': "Name", 'id': 1},
      'broker': {'name': "اسم", 'name_en': "Name", 'type': "parent", 'id': 1},
      'status': "pending"
    };
    BrokerToMarketRequest response = BrokerToMarketRequest(
      broker: Broker(nameAr: 'اسم', nameEn: 'Name', type: "parent", id: 1),
      market: Market(nameAr: 'اسم', nameEn: 'Name', id: 1),
      status: 'pending',
      id: 1,
    );
    test('fromJson takes json returns object of Broker request', () {
      var fromJson = BrokerToMarketRequestMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        BrokerToMarketRequestMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
