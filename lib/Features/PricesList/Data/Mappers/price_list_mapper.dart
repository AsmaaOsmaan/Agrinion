import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/PricesList/Data/Mappers/price_item_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';

import '../../../SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import '../../Domain/Models/price_item_model.dart';
import '../../Domain/Models/price_list_model.dart';

class PriceListMapper {
  static PriceListModel fromJson(Map<String, dynamic> json) {
    return PriceListModel(
      id: json['id'],
      priceDate: json['price_date'],
      priceList: fillPriceList(json["price_list_items"]),
      notPricedList: fillNonPriceList(json['non_price_list_items']),
    );
  }

  static List<PriceItemModel>? fillPriceList(List<dynamic>? json) {
    if (json == null) return null;
    return json
        .map((e) => PriceItemMapper.fromJson(Utils.convertToJson(e)))
        .toList();
  }

  static List<Product>? fillNonPriceList(List<dynamic>? json) {
    if (json == null) return null;
    return json
        .map((e) => ProductsMapper.fromJson(Utils.convertToJson(e)))
        .toList();
  }

  static Map<String, dynamic> toJson(PriceListModel model) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['market_id'] = model.marketId;
    data['price_date'] = model.priceDate;

    return data;
  }
}
