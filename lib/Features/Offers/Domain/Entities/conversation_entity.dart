import 'package:agriunion/Features/Ads/Domain/Models/ad_model.dart';
import 'package:equatable/equatable.dart';

import 'offers_entity.dart';

// ignore: must_be_immutable
class Conversation extends Equatable {
  int? id;
  int? orderId;
  int? adId;
  String? status;
  int? offersCount;
  Offer? lastOffer;
  Offer? finalOffer;
  String? createdAt;
  String? updatedAt;
  AdModel? ad;
  List<Offer>? offers;
  List<int>? buyerGroup;
  List<int>? sellerGroup;
  String? managerName;
  int? invoiceId;
  bool selectedForInvoices;
  int? salesReturnsCount;
  String? image;

  Conversation({
    this.id,
    this.orderId,
    this.adId,
    this.status,
    this.offersCount,
    this.lastOffer,
    this.finalOffer,
    this.createdAt,
    this.updatedAt,
    this.ad,
    this.offers,
    this.buyerGroup,
    this.sellerGroup,
    this.managerName,
    this.invoiceId,
    this.selectedForInvoices = false,
    this.salesReturnsCount,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        ad,
        adId,
        status,
        offersCount,
        offers,
        lastOffer,
        finalOffer,
        createdAt,
        updatedAt,
        buyerGroup,
        sellerGroup,
        selectedForInvoices,
        managerName,
        invoiceId
      ];
}
