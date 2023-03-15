import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_mapper.dart';

import '../../Domain/Models/price_item_model.dart';

class PriceItemMapper {
  static PriceItemModel fromJson(Map<String, dynamic> json) {
    return PriceItemModel(
        id: json['id'],
        minPrice: json['min_price'],
        maxPrice: json['max_price'],
        weight: json['weight'] ?? 1,
        product: json['product'] != null
            ? ProductsMapper.fromJson(json['product'])
            : null,
        unitType: json['unit_type'] != null
            ? UnitTypeMapper.fromPriceListJson(json['unit_type'])
            : null);
  }

  static Map<String, dynamic> toJson(PriceItemModel model) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_price'] = model.minPrice;
    data['max_price'] = model.maxPrice;
    data['market_id'] = model.marketId;
    data['price_list_id'] = model.priceListId;
    data['product_id'] = model.product?.id;
    data['unit_type_id'] = model.unitType?.id;
    data['weight'] = model.weight;
    return {"price_list_item": data};
  }
}
