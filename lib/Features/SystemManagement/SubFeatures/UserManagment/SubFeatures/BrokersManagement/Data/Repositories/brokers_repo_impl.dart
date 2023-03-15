import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/DataSource/brokers_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_mapper.dart';

abstract class IBrokersRepository {
  Future<List<Broker>> getBrokers(int cityId);
  Future<Broker> addBroker(Broker model, int cityId);
  Future<void> deleteBroker(int id, int cityId);
  Future<List<Broker>> getAllBrokers();
  Future<List<Broker>> getAllParentableBrokers();
}

class BrokersRepository implements IBrokersRepository {
  final IBrokerNetworking _brokerNetwork;
  BrokersRepository(this._brokerNetwork);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<Broker> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => BrokersMapper.fromRequestJson(e)).toList();
  }

  List<Broker> convertToListModelToAll(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => BrokersMapper.fromRequestJson(e)).toList();
  }

  Broker convertToModel(Map<String, dynamic> jsonResponse) {
    return BrokersMapper.fromRequestJson(jsonResponse);
  }

  @override
  Future<List<Broker>> getAllBrokers() async {
    final response = await _brokerNetwork.getAllBrokers();
    final jsonResponse = convertToListJson(response);
    final broker = convertToListModelToAll(jsonResponse);
    return broker;
  }

  @override
  Future<List<Broker>> getAllParentableBrokers() async {
    final response = await _brokerNetwork.getAllParentableBrokers();
    final jsonResponse = convertToListJson(response);
    final broker = convertToListModel(jsonResponse);
    return broker;
  }

  @override
  Future<List<Broker>> getBrokers(int marketId) async {
    final response = await _brokerNetwork.getBrokers(marketId);
    final jsonResponse = convertToListJson(response);
    final brokers = convertToListModel(jsonResponse);
    return brokers;
  }

  @override
  Future<Broker> addBroker(Broker model, int cityId) async {
    final response =
        await _brokerNetwork.addBroker(BrokersMapper.toJson(model), cityId);
    final jsonResponse = convertToJson(response);
    final market = convertToModel(jsonResponse);
    return market;
  }

  @override
  Future<void> deleteBroker(int id, int cityId) async {
    await _brokerNetwork.deleteBroker(cityId, id);
  }
}
