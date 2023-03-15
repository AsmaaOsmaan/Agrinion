import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Data/Mappers/offers_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('offers fromjson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "price": 1.0,
      "quantity": 1.0,
      "ad_id": 1,
      "conversation_id": 1,
      "creator_id": 1,
    };
    Offer response = Offer(
      adId: 1,
      id: 1,
      conversationId: 1,
      creatorId: 1,
      quantity: 1,
      price: 1,
    );
    test('fromJson takes json returns object of offer', () {
      var fromJson = OffersMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        OffersMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    Offer model = Offer(
      conversationId: 1,
      previousOfferId: 1,
      quantity: 1,
      price: 1,
      note: "",
    );
    Map<String, dynamic> json = {
      "conversation_id": 1,
      "previous_offer_id": 1,
      "quantity": 1,
      "price": 1,
      "notes": "",
    };
    test('toJson takes Object and return Json', () {
      var fromJson = OffersMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
