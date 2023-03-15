import 'dart:io';

class AddAdModel {
  AddAdModel({
    this.commercialProfileId,
    this.brokerId,
    required this.marketId,
    required this.categoryId,
    required this.productId,
    required this.price,
    this.negotiable,
    required this.quantity,
    required this.unitWeight,
    required this.unitTypeId,
    this.minimalQuantity,
    this.notes,
    this.image,
  });
  final File? image;
  final int? commercialProfileId;
  final int? brokerId;
  final int marketId;
  final int categoryId;
  final int productId;
  final double? price;
  final bool? negotiable;
  final int quantity;
  final double unitWeight;
  final int unitTypeId;
  final int? minimalQuantity;
  final String? notes;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['commercial_profile_id'] = commercialProfileId;
    _data['ad_image'] = image;
    _data['broker_id'] = brokerId;
    _data['market_id'] = marketId;
    _data['category_id'] = categoryId;
    _data['product_id'] = productId;
    _data['price'] = price;
    _data['negotiable'] = negotiable;
    _data['quantity'] = quantity;
    _data['unit_weight'] = unitWeight;
    _data['unit_type_id'] = unitTypeId;
    _data['minimal_offerable_quantity'] = minimalQuantity;
    _data['notes'] = notes;
    return _data;
  }
}
