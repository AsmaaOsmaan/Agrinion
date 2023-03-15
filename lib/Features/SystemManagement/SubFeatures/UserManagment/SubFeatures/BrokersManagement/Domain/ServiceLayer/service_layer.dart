import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_market_entity.dart';

import '../../../../../CitiesAndMarkets/Cities/Data/Repositories/cities_repo_impl.dart';
import '../../../../../CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import '../../../../../CitiesAndMarkets/Markets/Data/Repositories/markets_repo_impl.dart';
import '../../../../../CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import '../../Data/Repositories/broker_management_repo_impl.dart';
import '../../Data/Repositories/brokers_repo_impl.dart';
import '../Entities/assign_broker_market_entity.dart';

abstract class IBrokerManagementService {
  Future<List<Broker>> getAllBroker();
  Future<List<Cities>> getCities();
  Future<AssignBrokerToMarketModel> assignBrokerToMarket(
      AssignBrokerToMarketModel assignBrokerToMarketModel);
  Future<List<BrokerMarket>> getBrokerMarkets(int brokerId);
  Future<void> unLinkBrokerMarket(int brokerId, int marketId);
  Future<List<Market>> getUnlikedBrokerMarkets(int brokerId, int cityId);
}

class BrokerManagementService implements IBrokerManagementService {
  IBrokerManagementRepository brokerManagementRepo;
  IMarketsRepository marketManagementRepo;
  ICitiesRepository cityRepo;
  final IBrokersRepository _brokersRepo;
  BrokerManagementService(
    this.brokerManagementRepo,
    this.marketManagementRepo,
    this._brokersRepo,
    this.cityRepo,
  );

// get AllBrokers from RepoBroker
  @override
  Future<List<Broker>> getAllBroker() async {
    return await _brokersRepo.getAllBrokers();
  }

  @override
  Future<List<Cities>> getCities() async {
    return await cityRepo.getCities();
  }

  @override
  Future<List<Market>> getUnlikedBrokerMarkets(int brokerId, int cityId) async {
    return await brokerManagementRepo.getUnlikedBrokerMarkets(brokerId, cityId);
  }

  @override
  Future<AssignBrokerToMarketModel> assignBrokerToMarket(
      AssignBrokerToMarketModel assignBrokerToMarketModel) async {
    return await brokerManagementRepo
        .assignBrokerToMarket(assignBrokerToMarketModel);
  }

  @override
  Future<List<BrokerMarket>> getBrokerMarkets(int brokerId) async {
    return await brokerManagementRepo.getBrokerMarkets(brokerId);
  }

  @override
  Future<void> unLinkBrokerMarket(int brokerId, int marketId) async {
    await brokerManagementRepo.unLinkBrokerMarket(brokerId, marketId);
  }
}
