import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';

class BrokerToMarketRequest {
  int? id;
  String? status;
  Market? market;
  Broker? broker;

  BrokerToMarketRequest({
    this.id,
    this.status,
    this.broker,
    this.market,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrokerToMarketRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          market == other.market &&
          broker == other.broker;

  @override
  int get hashCode => id.hashCode;
}
