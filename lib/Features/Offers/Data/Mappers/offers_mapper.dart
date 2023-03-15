import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/cart/Domain/Entities/cart_item_errors_errors.dart';

class OffersMapper {
  static Offer fromJson(Map<String, dynamic> json,
      [Map<String, dynamic>? adJson]) {
    try {
      return Offer(
        id: json['id'],
        note: json['notes'],
        price: json['price'],
        quantity: json['quantity'],
        adId: json['ad_id'],
        conversationId: json['conversation_id'],
        creatorId: json['creator_id'],
        previousOfferId: json['previous_offer_id'],
        minimalOfferableQuantity: adJson?['minimal_offerable_quantity'] ?? 1,
        remainingQty: adJson?['remaining_quantity'],
        createdAt: json['created_at'],
        errors: json['errors'] != null ? CartItemsError.fromJson(json) : null,
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, price: 1.0, quantity: 1.0, ad_id: 1, conversation_id: 1, creator_id: 1} , but found this : $json");
    }
  }

  static Map<String, dynamic> toJson(Offer offer) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversation_id'] = offer.conversationId;
    data['previous_offer_id'] = offer.previousOfferId;
    data['quantity'] = offer.quantity;
    data['price'] = offer.price;
    data['notes'] = offer.note;

    return data;
  }
}
