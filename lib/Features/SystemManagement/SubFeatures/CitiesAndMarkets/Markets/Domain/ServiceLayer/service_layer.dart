import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/Repositories/markets_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';

abstract class IMarketsService {
  Future<List<Market>> getMarkets(int cityId);
  Future<Market> addMarket(Market market, int cityId);
  Future<Market> editMarket(Market market, int cityId);
  Future<void> deleteMarket(int id, int cityId);
}

class MarketsService implements IMarketsService {
  final IMarketsRepository _repo;
  MarketsService(this._repo);

  @override
  Future<List<Market>> getMarkets(int cityId) async {
    return await _repo.getMarkets(cityId);
  }

  @override
  Future<Market> addMarket(Market market, int cityId) async {
    return await _repo.addMarket(market, cityId);
  }

  @override
  Future<Market> editMarket(Market market, int cityId) async {
    return await _repo.editMarket(market, cityId);
  }

  @override
  Future<void> deleteMarket(int id, int cityId) async {
    await _repo.deleteMarket(id, cityId);
  }
}
