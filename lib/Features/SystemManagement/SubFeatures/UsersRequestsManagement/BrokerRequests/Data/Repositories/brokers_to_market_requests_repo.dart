import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Data/Mappers/broker_to_market_request_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/broker_to_market_requests_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/rejection_reason_model.dart';

import '../DataSource/broker_requests_networking.dart';

abstract class IBrokerToMarketRequestsRepository {
  Future<List<BrokerToMarketRequest>> getPendingRequests();
  Future<List<BrokerToMarketRequest>> getApprovedRequests();
  Future<List<BrokerToMarketRequest>> getRejectedRequests();
  Future<List<BrokerToMarketRequest>> getUnlinkedRequests();
  Future<void> approveRequest(int id);
  Future<void> rejectRequest(int id,RejectionReasonModel reasonModel);
  Future<void> unLinkRequest(int id);
  Future<void> cancelRequest(int id);
  Future<BrokerToMarketRequest> showSpecificBrokersMarketRequest(int id);
}

class BrokerToMarketRequestRepository
    implements IBrokerToMarketRequestsRepository {
  final IBorkerToMarketRequestsNetworking _networking;

  BrokerToMarketRequestRepository(this._networking);
  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  BrokerToMarketRequest convertToModel(Map<String, dynamic> jsonResponse) {
    return BrokerToMarketRequestMapper.fromJson(jsonResponse);
  }

  List<BrokerToMarketRequest> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse
        .map((e) => BrokerToMarketRequestMapper.fromJson(e))
        .toList();
  }

  @override
  Future<List<BrokerToMarketRequest>> getPendingRequests() async {
    return await getRequestsByStatus("pending");
  }

  Future<List<BrokerToMarketRequest>> getRequestsByStatus(String status) async {
    final response = await _networking.getRequestsByStatus(status);
    final jsonResponse = convertToListJson(response);
    final requests = convertToListModel(jsonResponse);
    return requests;
  }

  @override
  Future<List<BrokerToMarketRequest>> getApprovedRequests() async {
    return await getRequestsByStatus("approved");
  }
  @override
  Future<List<BrokerToMarketRequest>> getUnlinkedRequests() async {
    return await getRequestsByStatus("expired");
  }

  @override
  Future<List<BrokerToMarketRequest>> getRejectedRequests() async {
    return await getRequestsByStatus("rejected");
  }
  @override
  Future<void> unLinkRequest(int id) async {
    await _networking.unLinkRequest(id);
  }




  @override
  Future<void> cancelRequest(int id) async {
    await _networking.cancelRequest(id);
  }
  @override
  Future<void> approveRequest(int id) async {
    await _networking.approveRequest(id);
  }


  @override
  Future<BrokerToMarketRequest> showSpecificBrokersMarketRequest(int id) async {
    final response = await _networking.showSpecificBrokersMarketRequest(id);
    final jsonResponse = convertToJson(response);
    final brokerRequest = convertToModel(jsonResponse);
    return brokerRequest;
  }

  @override
  Future<void> rejectRequest(int id,RejectionReasonModel reasonModel) async {
    await _networking.rejectRequest(id,RejectionReasonModelMapper.toJson(reasonModel));
  }
}
