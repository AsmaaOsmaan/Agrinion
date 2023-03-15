import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/rejection_reason_model.dart';

import '../../Data/Repositories/brokers_to_market_requests_repo.dart';
import '../Entities/broker_to_market_requests_entity.dart';

abstract class IBrokerRequestsBL {
  Future<List<BrokerToMarketRequest>> getApprovedRequests();
  Future<List<BrokerToMarketRequest>> getPendingRequests();
  Future<List<BrokerToMarketRequest>> getRejectedRequests();
  Future<List<BrokerToMarketRequest>> getUnlinkedRequests();
  Future<void> approveRequest(int id);
  Future<void> rejectRequest(int id,RejectionReasonModel reasonModel);
  Future<void> unLinkRequest(int id);
  Future<void> cancelRequest(int id);
  Future<BrokerToMarketRequest> showSpecificBrokersMarketRequest(int id );
}

class BrokerToMarketRequestsBL implements IBrokerRequestsBL {
  final IBrokerToMarketRequestsRepository _repo;
  BrokerToMarketRequestsBL(this._repo);

  @override
  Future<void> approveRequest(int id) async {
    await _repo.approveRequest(id);
  }
  @override
  Future<void> unLinkRequest(int id) async {
    await _repo.unLinkRequest(id);
  }
  @override
  Future<void> cancelRequest(int id) async {
    await _repo.cancelRequest(id);
  }
  @override
  Future<List<BrokerToMarketRequest>> getApprovedRequests() async {
    return await _repo.getApprovedRequests();
  }


  @override
  Future<List<BrokerToMarketRequest>> getUnlinkedRequests() async {
    return await _repo.getUnlinkedRequests();
  }



  @override
  Future<List<BrokerToMarketRequest>> getPendingRequests() async {
    return await _repo.getPendingRequests();
  }

  @override
  Future<List<BrokerToMarketRequest>> getRejectedRequests() async {
    return await _repo.getRejectedRequests();
  }

  @override
  Future<void> rejectRequest(int id,RejectionReasonModel reasonModel) async {
    await _repo.rejectRequest(id,reasonModel);
  }



  @override
  Future<BrokerToMarketRequest> showSpecificBrokersMarketRequest(int id ) async {
    BrokerToMarketRequest brokerToMarketRequest = await _repo.showSpecificBrokersMarketRequest(id);
    return brokerToMarketRequest;
  }
}
