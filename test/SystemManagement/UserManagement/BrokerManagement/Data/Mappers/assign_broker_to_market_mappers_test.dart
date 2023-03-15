import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/assign_broker_market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/assign_broker_market_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('assign broker to market requests fromJson test cases', () {
    Map<String, dynamic> json = {
      'id': 1,
      'market_id': 1,
      'broker_id': 1,
      'status': "pending",
      'errors': null
    };
    AssignBrokerToMarketModel response = AssignBrokerToMarketModel(
      status: 'pending',
      id: 1,
      brokerId: 1,
      marketId: 1,
    );
    test('fromJson takes json returns object', () {
      var fromJson = AssignBrokerToMarketMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        AssignBrokerToMarketMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });

  group('toJson function test cases', () {
    AssignBrokerToMarketModel model = AssignBrokerToMarketModel(
      brokerId: 1,
      marketId: 1,
    );
    Map<String, dynamic> json = {
      'request': {
        "market_id": 1,
        "broker_id": 1,
      }
    };
    test('toJson takes Object and return Json', () {
      var fromJson = AssignBrokerToMarketMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
