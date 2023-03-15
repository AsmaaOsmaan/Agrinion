import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';

import '../../../../App/Network/network_helper.dart';
import '../../../Ads/Data/Mappers/ad_mapper.dart';
import '../../Domain/Entities/conversation_entity.dart';
import 'offers_mapper.dart';

class ConversationMapper {
  static Conversation fromJson(Map<String, dynamic> json) {
    List<Offer> offers = [];

    if (json['offers'] != null) {
      json['offers'].forEach((v) {
        offers.add(OffersMapper.fromJson(v, json['ad']));
      });
    }
    List<int> buyers = [];

    if (json['buyer_group'] != null) {
      json['buyer_group'].forEach((v) {
        if (v != null) {
          buyers.add(v.toInt());
        }
      });
    }
    List<int> sellers = [];

    if (json['seller_group'] != null) {
      json['seller_group'].forEach((v) {
        if (v != null) {
          sellers.add(v.toInt());
        }
      });
    }
    try {
      return Conversation(
        id: json['id'],
        orderId: json['order_id'],
        adId: json['ad_id'],
        status: json['status'],
        offersCount: json['offers_count'],
        lastOffer: json['last_offer'] != null
            ? OffersMapper.fromJson(json['last_offer'], json['ad'])
            : null,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        ad: json['ad'] != null ? AdMapper.fromJson(json['ad']) : null,
        offers: offers,
        buyerGroup: buyers,
        sellerGroup: sellers,
        managerName:
            (json['ad'] != null) ? json['ad']['manager']['name'] : null,
        invoiceId: json['invoice_id'],
        salesReturnsCount: json['sales_returns_count'] ?? 0,
        image: json['image'] != null
            ? NetworkHelper.apiBaseUrl! + json['image']
            : null,
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, order_id: 1, ad_id: 1, created_at: , invoice_id: 1, buyer_group: [1, 1], last_offer: {id: 1, price: 1.0, quantity: 1.0, ad_id: 1, conversation_id: 1, creator_id: 1}} , but found this : $json");
    }
  }

  static Map<String, dynamic> negotiationsToJson(Offer offer, int orderId) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ad_id'] = offer.adId;
    data['quantity'] = offer.quantity;
    data['price'] = offer.price;
    data['notes'] = offer.note;

    return {
      'ad_id': offer.adId,
      "order_id": orderId,
      "offers_attributes": [data]
    };
  }
}
