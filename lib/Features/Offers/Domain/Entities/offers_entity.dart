import 'package:easy_localization/easy_localization.dart';

import '../../../cart/Domain/Entities/cart_item_errors_errors.dart';

class Offer {
  int? id;
  int? adId;
  double? quantity;
  double? price;
  String? note;
  int? conversationId;
  CartItemsError? errors;
  int? creatorId;
  int? previousOfferId;
  int? minimalOfferableQuantity;
  int? remainingQty;
  String? createdAt;

  Offer({
    this.id,
    this.errors,
    this.note,
    this.price,
    this.quantity,
    this.adId,
    this.conversationId,
    this.creatorId,
    this.previousOfferId,
    this.minimalOfferableQuantity,
    this.remainingQty,
    this.createdAt,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Offer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          adId == other.adId &&
          quantity == other.quantity &&
          price == other.price &&
          creatorId == other.creatorId &&
          conversationId == other.conversationId;

  @override
  int get hashCode => id.hashCode;
  String? valdiateQuantity() {
    if (quantity! < minimalOfferableQuantity!) {
      return tr("invalidQty");
    } else if (quantity! > remainingQty!) {
      return tr("invalidQty");
    } else {
      return null;
    }
  }
}
