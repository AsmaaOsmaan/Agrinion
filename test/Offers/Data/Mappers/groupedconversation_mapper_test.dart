import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Data/Mappers/grouped_conv_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/grouped_conversation.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('conversation fromjson test cases', () {
    Map<String, dynamic> json = {
      'name': "",
      "conversations": [
        {
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
      ]
    };
    GroupedConversation response = GroupedConversation(
      managerName: '',
      conversations: [
        Conversation(
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
        )
      ],
    );
    test('fromJson takes json returns object of offer', () {
      var fromJson = GroupedConversationMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        GroupedConversationMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
