import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';

class BrokerMarket {
  final Market? market;
  final Cities? city;

  BrokerMarket({this.market, this.city});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrokerMarket &&
          runtimeType == other.runtimeType &&
          market == other.market &&
          city == other.city;

  @override
  int get hashCode => market.hashCode;
}
