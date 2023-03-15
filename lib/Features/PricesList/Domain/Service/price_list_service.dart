import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';

import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Data/Repositories/cities_repo_impl.dart';
import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/Repositories/markets_repo_impl.dart';
import '../../../SystemManagement/SubFeatures/UnitTypes/Data/Repositories/unit_types_repo_impl.dart';
import '../../Data/Repositories/price_list_repository.dart';
import '../Models/price_item_model.dart';
import '../Models/price_list_model.dart';

abstract class IPriceListBL {
  Future<PriceListModel> getPriceList(PriceListModel model);
  Future<PriceItemModel?> updatePriceList(PriceItemModel model);
  Future<List<Cities>> getCities();
  Future<List<Market>> getMarkets(int cityId);
  Future<List<UnitType>> getUnitTypes();
  Future<PriceItemModel?> createPriceList(PriceItemModel model);
  Future<void> deletePriceList(int pricedItemId);
}

class PriceListBL implements IPriceListBL {
  final IPriceListRepo _priceListRepo;
  final ICitiesRepository _cityRepo;
  final IUnitTypeRepository _unitTypeRepo;
  final IMarketsRepository _marketRepo;
  PriceListBL(
    this._priceListRepo,
    this._cityRepo,
    this._marketRepo,
    this._unitTypeRepo,
  );

  @override
  Future<PriceListModel> getPriceList(PriceListModel model) async {
    try {
      return await _priceListRepo.getPriceList(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Cities>> getCities() async {
    try {
      return await _cityRepo.getCities();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Market>> getMarkets(int cityId) async {
    try {
      return await _marketRepo.getMarkets(cityId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UnitType>> getUnitTypes() async {
    try {
      return await _unitTypeRepo.getUnitType();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PriceItemModel?> updatePriceList(PriceItemModel model) async {
    try {
      return await _priceListRepo.updatePriceList(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PriceItemModel?> createPriceList(PriceItemModel model) async {
    try {
      return await _priceListRepo.createPriceList(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePriceList(int pricedItemId) async {
    try {
      await _priceListRepo.deletePriceList(pricedItemId);
    } on Exception {
      rethrow;
    }
  }
}
