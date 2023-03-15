import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/Mappers/broker_status_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/Mappers/createtion_linking_user_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/Mappers/linking_user_request_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/broker_status_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/creation_linking_user_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/linking_user_request_entity.dart';

import '../DataSource/linking_user_requests_networking.dart';

abstract class ILinkingUserRequestsRepository {
  Future<LinkingUserRequest> createLinkingUser(CreateLinkingUser model);
  Future<List<LinkingUserRequest>> getPendingRequests();
  Future<List<LinkingUserRequest>> getApprovedRequests();
  Future<List<LinkingUserRequest>> getRejectedRequests();
  Future<List<LinkingUserRequest>> getExpiredRequests();
  Future<List<LinkingUserRequest>> getAllRequests();
  Future<BrokerStatusModel> getBrokerStatus();
  Future<void> approveRequest(int id);
  Future<void> rejectRequest(int id);
  Future<void> cancelRequest(int id);
  Future<void> unLinkRequest(int id);
  Future<LinkingUserRequest> showLinkingUserRequest(int id);
}

class LinkingUserRequestsRepository implements ILinkingUserRequestsRepository {
  final ILinkingUserRequestsNetworking _networking;

  LinkingUserRequestsRepository(this._networking);
  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<LinkingUserRequest> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse
        .map((e) => LinkingUserRequestMapper.fromJson(e))
        .toList();
  }

  LinkingUserRequest convertToModel(Map<String, dynamic> jsonResponse) {
    return LinkingUserRequestMapper.fromJson(jsonResponse);
  }

  BrokerStatusModel convertToBrokerStatusModel(
      Map<String, dynamic> jsonResponse) {
    return BrokerStatusMapper.fromJson(jsonResponse);
  }

  @override
  Future<LinkingUserRequest> createLinkingUser(CreateLinkingUser model) async {
    final response = await _networking
        .createLinkingUserRequest(CreateLinkingUserMapper.toJson(model));

    final jsonResponse = convertToJson(response);
    final createLinkingUser = convertToModel(jsonResponse);
    return createLinkingUser;
  }

  @override
  Future<List<LinkingUserRequest>> getAllRequests() async {
    final response = await _networking.getAllRequests();

    final jsonResponse = convertToListJson(response);
    final requests = convertToListModel(jsonResponse);
    return requests;
  }

  @override
  Future<List<LinkingUserRequest>> getPendingRequests() async {
    return await getRequestsByStatus("pending");
  }

  Future<List<LinkingUserRequest>> getRequestsByStatus(String status) async {
    final response = await _networking.getRequestsByStatus(status);

    final jsonResponse = convertToListJson(response);
    final requests = convertToListModel(jsonResponse);
    return requests;
  }

  @override
  Future<List<LinkingUserRequest>> getApprovedRequests() async {
    return await getRequestsByStatus("approved");
  }

  @override
  Future<List<LinkingUserRequest>> getExpiredRequests() async {
    return await getRequestsByStatus("expired");
  }

  @override
  Future<List<LinkingUserRequest>> getRejectedRequests() async {
    return await getRequestsByStatus("rejected");
  }

  @override
  Future<void> approveRequest(int id) async {
    await _networking.approveRequest(id);
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
  Future<void> rejectRequest(int id) async {
    await _networking.rejectRequest(id);
  }

  @override
  Future<BrokerStatusModel> getBrokerStatus() async {
    final response = await _networking.getBrokerStatus();
    final jsonResponse = convertToJson(response);
    final brokerStatus = convertToBrokerStatusModel(jsonResponse);
    return brokerStatus;
  }




  @override
  Future<LinkingUserRequest> showLinkingUserRequest(int id) async {
    final response = await _networking.showLinkingUserRequest(id);
    final jsonResponse = convertToJson(response);
    final linkingRequest = convertToModel(jsonResponse);
    return linkingRequest;
  }
}
