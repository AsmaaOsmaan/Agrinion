import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/cities_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_market_entity.dart';

class BrokerMarketMapper {
  static BrokerMarket fromJson(Map<String, dynamic> json) {
    try {
      return BrokerMarket(
          city: CitiesMapper.fromJson(json['city']),
          market: MarketsMapper.fromJson(json['market']));
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
