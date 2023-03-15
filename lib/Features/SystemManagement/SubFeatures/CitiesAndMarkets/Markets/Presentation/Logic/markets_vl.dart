import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/ServiceLayer/service_layer.dart';
import 'package:flutter/material.dart';

class MarketsVL extends ChangeNotifier {
  final IMarketsService _marketsService;
  MarketsVL(this._marketsService);

  List<Market> markets = [];
  bool isLoading = false;
  getMarkets(int cityId) async {
    isLoading = true;
    markets = await _marketsService.getMarkets(cityId);
    isLoading = false;

    notifyListeners();
  }

  Market? addingMarket;
  addMarket(int cityId) async {
    addingMarket = await _marketsService.addMarket(addingMarket!, cityId);
    notifyListeners();
  }

  manageAddingMarket(BuildContext context, int cityId) async {
    await addMarket(cityId);
    if (addingMarket!.errors == null) {
      markets.add(addingMarket!);
      Navigator.pop(context);
    }
  }

  editMarket(Market market, int cityId, int index) async {
    final editedCity = await _marketsService.editMarket(market, cityId);
    markets[index] = editedCity;
    notifyListeners();
  }

  deleteMarket(Market market, int cityId) async {
    await _marketsService.deleteMarket(market.id!, cityId);
    markets.remove(market);
    notifyListeners();
  }
}
