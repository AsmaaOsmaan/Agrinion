import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Data/Mappers/conversation_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('conversation fromjson test cases', () {
    Map<String, dynamic> json = {
      'id': 1,
      'order_id': 1,
      'ad_id': 1,
      'created_at': '',
      'invoice_id': 1,
      'buyer_group': [1, 1],
      'last_offer': {
        "id": 1,
        "price": 1.0,
        "quantity": 1.0,
        "ad_id": 1,
        "conversation_id": 1,
        "creator_id": 1,
      }
    };
    Conversation response = Conversation(
      adId: 1,
      id: 1,
      buyerGroup: const [1, 1],
      offers: const [],
      sellerGroup: const [],
      createdAt: '',
      orderId: 1,
      lastOffer: Offer(
          id: 1,
          adId: 1,
          price: 1,
          conversationId: 1,
          creatorId: 1,
          quantity: 1),
      invoiceId: 1,
    );
    test('fromJson takes json returns object of offer', () {
      var fromJson = ConversationMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        ConversationMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    Offer model = Offer(
      adId: 1,
      quantity: 1,
      price: 1,
      note: "",
    );
    Map<String, dynamic> json = {
      "ad_id": 1,
      "order_id": 1,
      "offers_attributes": [
        {
          'ad_id': 1,
          'quantity': 1,
          'price': 1,
          'notes': '',
        }
      ],
    };
    test('toJson takes Object and return Json', () {
      var fromJson = ConversationMapper.negotiationsToJson(model, 1);
      expect(fromJson, json);
    });
  });
}
