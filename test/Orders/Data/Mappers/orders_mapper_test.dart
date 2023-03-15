import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Orders/Data/Mappers/order_mapper.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('orders fromjson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "commercial_profile_id": 1,
      "created_at": '',
      "reference_number": '',
      "direct_order": false,
      "creator": {"id": 1, "name": "", "type": ""},
    };
    Order response = Order(
      id: 1,
      commercialProfileId: 1,
      createdAt: '',
      creator: Creator(id: 1, name: '', type: ''),
      isDirectOder: false,
      referenceNumber: '',
    );
    test('fromJson takes json returns object of order', () {
      var fromJson = OrderMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        OrderMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
