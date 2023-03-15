import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/DataSourse/markets_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';

import '../../Domain/Entities/market_mapper.dart';

abstract class IMarketsRepository {
  Future<List<Market>> getMarkets(int cityId);
  Future<Market> addMarket(Market model, int cityId);
  Future<Market> editMarket(Market model, int cityId);
  Future<void> deleteMarket(int id, int cityId);
}

class MarketsRepository implements IMarketsRepository {
  final IMarketsNetworking marketsNetwork;

  MarketsRepository(this.marketsNetwork);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<Market> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => MarketsMapper.fromJson(e)).toList();
  }

  Market convertToModel(Map<String, dynamic> jsonResponse) {
    return MarketsMapper.fromJson(jsonResponse);
  }

  @override
  Future<List<Market>> getMarkets(int cityId) async {
    final response = await marketsNetwork.getMarkets(cityId);
    final jsonResponse = convertToListJson(response);
    final markets = convertToListModel(jsonResponse);
    return markets;
  }

  @override
  Future<Market> addMarket(Market model, int cityId) async {
    final response =
        await marketsNetwork.addMarket(MarketsMapper.toJson(model), cityId);
    final jsonResponse = convertToJson(response);
    final market = convertToModel(jsonResponse);
    return market;
  }

  @override
  Future<Market> editMarket(Market model, int cityId) async {
    final response = await marketsNetwork.editMarket(
        MarketsMapper.toJson(model), cityId, model.id!);
    final jsonResponse = convertToJson(response.data);
    final market = convertToModel(jsonResponse);
    return market;
  }

  @override
  Future<void> deleteMarket(int id, int cityId) async {
    await marketsNetwork.deleteMarket(cityId, id);
  }
}
