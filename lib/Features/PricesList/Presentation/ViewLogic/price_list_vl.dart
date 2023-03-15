import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/Features/PricesList/Domain/Models/price_item_model.dart';
import 'package:agriunion/Features/PricesList/Domain/Service/price_list_service.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/PriceListManagement/Presentation/Screens/manage_product_prices.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../App/Utilities/app_route.dart';
import '../../Domain/Models/price_list_model.dart';
import '../Screens/prices_list_screen.dart';

class PriceListVL extends ChangeNotifier {
  final IPriceListBL _priceListBL;
  PriceListVL(this._priceListBL);
  List<PriceItemModel> priceableList = [];
  List<Product> notPricedList = [];
  List<Cities> cities = [];
  List<Market> markets = [];
  List<UnitType> unitTypes = [];
  bool isLoading = false;
  PriceListModel? priceItemModel;
  fillModel(String? date) {
    priceItemModel = PriceListModel(
      marketId: market?.id,
      priceDate: date,
    );
  }

  bool checkIfTheDataFilled() {
    if (market == null) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.fill_in_the_required_fields));
      return false;
    } else {
      return true;
    }
  }

  PriceListModel? priceList;
  void getPriceList(String? date) async {
    fillModel(date);
    isLoading = true;
    priceList = await _priceListBL.getPriceList(priceItemModel!);
    priceableList = priceList!.priceList!;
    notPricedList = priceList!.notPricedList!;
    isLoading = false;
    notifyListeners();
  }

  bool isSearch = false;
  void changeSearchState() {
    isSearch = !isSearch;
    notifyListeners();
  }

  filterPriceList(String value) {
    if (value != '') {
      priceableList = priceableList
          .where((element) => element.product!.nameAr.contains(value))
          .toList();
    } else {
      priceableList = priceList!.priceList!;
    }
    notifyListeners();
  }

  void filterAndGetPrices(String date, BuildContext context, bool isAdmin) {
    if (!checkIfTheDataFilled()) {
      return;
    }
    fillModel(date);
    getPriceList(date);
    AppRoute().navigate(
      context: context,
      route: isAdmin ? ManageProductsPrices(date: date) : PriceListScreen(),
    );
  }

  clearFilters() {
    selectCity(null);
    selectMarket(null);
    selectUnitType(null);
  }

  Cities? city;
  void selectCity(Cities? city) {
    this.city = city;
    whenCitySelected(city);
    notifyListeners();
  }

  void whenCitySelected(Cities? city) {
    if (city != null) {
      getMarkets(city.id!);
    }
  }

  void getCities() async {
    cities = await _priceListBL.getCities();
    notifyListeners();
  }

  Market? market;
  void selectMarket(Market? market) {
    this.market = market;
    notifyListeners();
  }

  void getMarkets(int cityId) async {
    markets = await _priceListBL.getMarkets(cityId);
    notifyListeners();
  }

  UnitType? unitType;
  void selectUnitType(UnitType? unitType) {
    this.unitType = unitType;
    notifyListeners();
  }

  void getUnitTypes() async {
    unitTypes = await _priceListBL.getUnitTypes();
    notifyListeners();
  }

  void createPriceList(PriceItemModel model) async {
    LoadingDialog.showLoadingDialog();
    PriceItemModel? priceItemModel = await _priceListBL.createPriceList(model);
    EasyLoading.dismiss();
    if (priceItemModel != null) {
      notPricedList.remove(model.product);
      priceableList.add(priceItemModel);
    } else {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
    }
    notifyListeners();
  }

  Future<void> deletePriceList(PriceItemModel model) async {
    LoadingDialog.showLoadingDialog();
    try {
      await _priceListBL.deletePriceList(model.id!);
      EasyLoading.dismiss();
      priceableList.remove(model);
      notPricedList.add(model.product!);
      LoadingDialog.showSimpleToast(tr("successDelete"));
      notifyListeners();
    } on Exception {
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
    }
  }

  void updatePriceList(PriceItemModel model, int index) async {
    LoadingDialog.showLoadingDialog();
    PriceItemModel? result = await _priceListBL.updatePriceList(model);
    EasyLoading.dismiss();
    if (result != null) {
      priceableList[index] = result;
    } else {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
    }

    notifyListeners();
  }
}
