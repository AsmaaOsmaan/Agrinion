import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_market_entity.dart';

import '../../../../../CitiesAndMarkets/Markets/Domain/Entities/market_mapper.dart';
import '../../Domain/Entities/assign_broker_market_entity.dart';
import '../mappers/assign_broker_market_mapper.dart';
import '../DataSource/broker_management_network.dart';

abstract class IBrokerManagementRepository {
  Future<AssignBrokerToMarketModel> assignBrokerToMarket(
      AssignBrokerToMarketModel model);
  Future<List<BrokerMarket>> getBrokerMarkets(int brokerId);
  Future<void> unLinkBrokerMarket(int brokerId,int marketId);
  Future<List<Market>> getUnlikedBrokerMarkets(int brokerId,int cityId);
}

class BrokerManagementRepository implements IBrokerManagementRepository {
  IBrokerManagementNetworking brokeruserManagementNetworking;
  BrokerManagementRepository(this.brokeruserManagementNetworking);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  AssignBrokerToMarketModel convertToModelBrokerTMarker(
      Map<String, dynamic> jsonResponse) {
    return AssignBrokerToMarketMapper.fromJson(jsonResponse);
  }

  List<BrokerMarket> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => BrokerMarketMapper.fromJson(e)).toList();
  }


  List<Market> convertToListMarketModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => MarketsMapper.fromJson(e)).toList();
  }

  @override
  Future<AssignBrokerToMarketModel> assignBrokerToMarket(
      AssignBrokerToMarketModel model) async {
    final response = await brokeruserManagementNetworking
        .assignBrokerToMarket(AssignBrokerToMarketMapper.toJson(model));
    final jsonResponse = convertToJson(response);
    final brokerMange = convertToModelBrokerTMarker(jsonResponse);
    return brokerMange;
  }

  @override
  Future<List<BrokerMarket>> getBrokerMarkets(int brokerId) async {
    final response = await brokeruserManagementNetworking.getBrokerMarkets(brokerId);
    final jsonResponse = Utils.convertToListJson(response);
    final brokerMarkets = convertToListModel(jsonResponse);
    return brokerMarkets;
  }

  @override
  Future<void> unLinkBrokerMarket(int brokerId,int marketId) async {
    await brokeruserManagementNetworking.unLinkBrokerMarket(brokerId,marketId);
  }

  @override
  Future<List<Market>> getUnlikedBrokerMarkets(int brokerId,int cityId) async {

    final response = await brokeruserManagementNetworking.getUnlikedBrokerMarkets(brokerId,cityId);
    final jsonResponse = convertToListJson(response);
    final markets = convertToListMarketModel(jsonResponse);
    return markets;
  }
}
