import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Orders/Data/Mappers/create_order_mapper.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('create orders fromjson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "commercial_profile_id": 1,
      "creator": {"id": 1, "name": "", "type": ""},
    };
    CreateOrderModel response = CreateOrderModel(
      orderId: 1,
      commercialProfileId: 1,
      creator: Creator(id: 1, name: '', type: ''),
    );
    test('fromJson takes json returns object of ordercreator', () {
      var fromJson = CreateOrderMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        CreateOrderMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('creator fromjson test cases', () {
    Map<String, dynamic> json = {"id": 1, "name": "", "type": ""};
    Creator response = Creator(id: 1, name: '', type: '');
    test('fromJson takes json returns object of ordercreator', () {
      var fromJson = CreatorMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        CreatorMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    CreateOrderModel model = CreateOrderModel(
      commercialProfileId: 1,
    );
    Map<String, dynamic> json = {
      'order': {
        "commercial_profile_id": 1,
      }
    };
    test('toJson takes Object and return Json', () {
      var fromJson = CreateOrderMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
