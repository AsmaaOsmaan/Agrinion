class AdFilter {
  String? productSearchKey;
  String? categoryId;
  String? cityId;
  String? marketId;
  String? fromPrice;
  String? toPrice;
  String? fromDate;
  String? toDate;
  AdFilter({
    this.categoryId,
    this.cityId,
    this.fromDate,
    this.fromPrice,
    this.marketId,
    this.productSearchKey,
    this.toDate,
    this.toPrice,
  });
  String toUrl() {
    String url = "";
    if (productSearchKey != "") {
      url = url + "products_search_key=$productSearchKey&";
    }
    if (cityId != null) {
      url = url + "city_id=$cityId&";
    }
    if (categoryId != null) {
      url = url + "category_id=$categoryId&";
    }
    if (marketId != null) {
      url = url + "market_id=$marketId&";
    }
    if (fromPrice != "") {
      url = url + "from_price=$fromPrice&";
    }
    if (toPrice != "") {
      url = url + "to_price=$toPrice&";
    }
    if (fromDate != "") {
      url = url + "from_date=$fromDate&";
    }
    if (toDate != "") {
      url = url + "to_date=$toDate&";
    }
    return url;
  }
}
