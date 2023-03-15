import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Data/Mappers/sales_return_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sales return fromjson test cases', () {
    Map<String, dynamic> json = {
      'id': 1,
      'invoice_generated': true,
      'created_at': '',
      'invoice_id': 1,
      "conversation_id": 1,
      "creator": {"id": 1, "name": "", "type": ""},
      'quantity': 1,
      'conversation': {
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
      }
    };
    SalesReturn response = SalesReturn(
      id: 1,
      createdAt: '',
      conversationId: 1,
      creator: Creator(id: 1, name: '', type: ''),
      quantity: 1,
      invoiceGenerated: true,
      conversation: Conversation(
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
      ),
      invoiceId: 1,
    );
    test('fromJson takes json returns object of offer', () {
      var fromJson = SalesReturnMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        SalesReturnMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    SalesReturn model = SalesReturn(
      conversationId: 1,
      quantity: 1,
    );
    Map<String, dynamic> json = {
      'sales_returns': {
        "conversation_id": 1,
        "quantity": 1,
      }
    };
    test('toJson takes Object and return Json', () {
      var fromJson = SalesReturnMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
