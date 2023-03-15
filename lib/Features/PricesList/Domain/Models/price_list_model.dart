import 'package:agriunion/Features/PricesList/Domain/Models/price_item_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';

class PriceListModel {
  int? id;
  List<PriceItemModel>? priceList;
  List<Product>? notPricedList;
  String? priceDate;
  int? marketId;

  PriceListModel({
    this.id,
    this.priceDate,
    this.marketId,
    this.notPricedList,
    this.priceList,
  });
  String toUrl() {
    String url = "";
    if (marketId != null) {
      url = url + "market_id=$marketId&";
    }
    if (priceDate != "") {
      url = url + "price_date=$priceDate&";
    }
    return url;
  }
}
