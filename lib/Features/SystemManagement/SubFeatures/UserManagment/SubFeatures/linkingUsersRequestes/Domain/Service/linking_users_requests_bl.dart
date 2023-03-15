import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/Repositories/brokers_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/Repositories/linking_user_requests_repo.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/broker_status_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/creation_linking_user_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/linking_user_request_entity.dart';

abstract class ILinkingUsersRequestsServiceLayer {
  Future<LinkingUserRequest> createLinkingUser(
      CreateLinkingUser createLinkingUser);
  Future<List<Broker>> getAllParentableBroker();
  Future<List<LinkingUserRequest>> getApprovedRequests();
  Future<List<LinkingUserRequest>> getPendingRequests();
  Future<List<LinkingUserRequest>> getRejectedRequests();
  Future<List<LinkingUserRequest>> getExpiredRequests();
  Future<List<LinkingUserRequest>> getAllRequests();
  Future<void> approveRequest(int id);
  Future<void> rejectRequest(int id);
  Future<void> cancelRequest(int id);
  Future<void> unLinkRequest(int id);
  Future<BrokerStatusModel> getBrokerStatus();
  Future<LinkingUserRequest> showLinkingUserRequest(int id);
}

class LinkingUsersRequestsServiceLayer
    implements ILinkingUsersRequestsServiceLayer {
  final ILinkingUserRequestsRepository _repo;
  final IBrokersRepository _brokersRepo;

  LinkingUsersRequestsServiceLayer(this._repo, this._brokersRepo);

  @override
  Future<LinkingUserRequest> createLinkingUser(
      CreateLinkingUser createLinkingUser) async {
    return await _repo.createLinkingUser(createLinkingUser);
  }

  @override
  Future<List<Broker>> getAllParentableBroker() async {
    return await _brokersRepo.getAllParentableBrokers();
  }

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
  Future<List<LinkingUserRequest>> getAllRequests() async {
    return await _repo.getAllRequests();
  }

  @override
  Future<List<LinkingUserRequest>> getApprovedRequests() async {
    return await _repo.getApprovedRequests();
  }

  @override
  Future<List<LinkingUserRequest>> getExpiredRequests() async {
    return await _repo.getExpiredRequests();
  }

  @override
  Future<List<LinkingUserRequest>> getPendingRequests() async {
    return await _repo.getPendingRequests();
  }

  @override
  Future<List<LinkingUserRequest>> getRejectedRequests() async {
    return await _repo.getRejectedRequests();
  }

  @override
  Future<void> rejectRequest(int id) async {
    await _repo.rejectRequest(id);
  }

  @override
  Future<BrokerStatusModel> getBrokerStatus() async {
    BrokerStatusModel brokerStatus = await _repo.getBrokerStatus();
    return brokerStatus;
  }

  @override
  Future<LinkingUserRequest> showLinkingUserRequest(int id) async {
    LinkingUserRequest linkingUserRequest =
        await _repo.showLinkingUserRequest(id);
    return linkingUserRequest;
  }
}
