import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('broker fromJson test cases', () {
    Map<String, dynamic> json = {
      'id': 1,
      'name': 'name',
      'type': 'type',
    };

    Broker response = Broker(id: 1, nameAr: 'name', type: 'type');
    test('fromJson takes json returns object', () {
      var fromJson = BrokersMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        BrokersMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('broker fromRequestJson test cases', () {
    Map<String, dynamic> requestJson = {
      'id': 1,
      'name': 'اسم',
      'name_en': 'name',
      'type': "type",
      'mobile': "555555555",
      'confirmed': true
    };

    Broker response = Broker(
      id: 1,
      nameAr: 'اسم',
      type: 'type',
      confirmed: true,
      mobile: '555555555',
      nameEn: 'name',
    );
    test('fromJson takes json returns object', () {
      var fromJson = BrokersMapper.fromRequestJson(requestJson);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        BrokersMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });

  group('toJson function test cases', () {
    Broker model = Broker(
      id: 1,
      nameAr: 'اسم',
      type: 'broker',
      confirmed: true,
      mobile: '555555555',
      nameEn: 'name',
    );
    Map<String, dynamic> json = {
      'name_ar': 'اسم',
      'name_en': 'name',
      'type': "broker",
      'mobile': "555555555",
      'confirmed': true
    };
    test('toJson takes Object and return Json', () {
      var toJson = BrokersMapper.toJson(model);
      expect(toJson, json);
    });
  });
}
