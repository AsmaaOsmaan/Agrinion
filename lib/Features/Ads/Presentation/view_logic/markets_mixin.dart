import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';

import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import '../../Domain/BusinessLogic/service_layer.dart';

mixin MarketMixin {
  List<Market> markets = [];
  Market? market;

  getMarkets(Cities city, IAdService _service) async {
    markets = await _service.getMarkets(city.id!);
  }

  setAllMarketsWithFalse() {
    for (var x in markets) {
      x.isSelected = false;
    }
  }

  void setMarket(int index, Market market) {
    setAllMarketsWithFalse();
    markets[index].isSelected = true;
    this.market = market;
  }

  changeMarketStep(Market market, int index, String type) async {
    setMarket(index, market);
  }
}
