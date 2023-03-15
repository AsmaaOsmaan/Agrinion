import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_mapper.dart';
//import 'package:agriunion/Features/Users/Brokers/Data/Mapper/broker_mapper.dart';

//import '../../../../UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_mapper.dart';
import '../../Domain/Entities/broker_to_market_requests_entity.dart';

class BrokerToMarketRequestMapper {
  static BrokerToMarketRequest fromJson(Map<String, dynamic> json) {
    try {
      return BrokerToMarketRequest(
        id: json['id'],
        status: json['status'],
        broker: json['broker'] != null
            ? BrokersMapper.fromRequestJson(json['broker'])
            : null,
        market: json['market'] != null
            ? MarketsMapper.fromJson(json['market'])
            : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
