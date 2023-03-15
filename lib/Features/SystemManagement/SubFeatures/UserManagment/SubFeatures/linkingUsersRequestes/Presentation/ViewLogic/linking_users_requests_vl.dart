import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/broker_status_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/creation_linking_user_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Service/linking_users_requests_bl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Domain/Entities/linking_user_request_entity.dart';

class LinkingUsersRequestsVL extends ChangeNotifier {
  final ILinkingUsersRequestsServiceLayer _bl;
  LinkingUsersRequestsVL(this._bl);
  List<LinkingUserRequest> pendingRequests = [];
  bool isLoading = false;
  BrokerStatusModel? brokerStatus;
  LinkingUserRequest? linkingUserRequest;
  List<Broker> brokers = [];
  List<Broker> brokersList = [];

  createLinkingUser(CreateLinkingUser createLinkingUserModel) async {
    final linkingUser = await _bl.createLinkingUser(createLinkingUserModel);
    pendingRequests.add(linkingUser);
    notifyListeners();
  }

  getBrokerStatus() async {
    isLoading = true;
    brokerStatus = await _bl.getBrokerStatus();
    isLoading = false;

    notifyListeners();
  }

  bool isSearch = false;
  void changeSearchState() {
    isSearch = !isSearch;
    notifyListeners();
  }

  filterBrokers(String value) {
    if (value != '') {
      brokers = brokersList
          .where((element) =>
              element.nameAr!.toLowerCase().contains(value.toLowerCase()) ||
              element.mobile!.contains(value))
          .toList();
    } else {
      brokers = brokersList;
    }
    notifyListeners();
  }

  showLinkingUserRequest(int id) async {
    isLoading = true;
    linkingUserRequest = await _bl.showLinkingUserRequest(id);
    // isLoading = false;
    notifyListeners();
  }

  getBrokers() async {
    isLoading = true;
    brokers = await _bl.getAllParentableBroker();
    brokersList = brokers;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getPendingRequests() async {
    isLoading = true;
    pendingRequests = await _bl.getPendingRequests();
    isLoading = false;
    notifyListeners();
  }

  List<LinkingUserRequest> approvedRequests = [];
  List<LinkingUserRequest> allRequests = [];
  List<LinkingUserRequest> expiredRequests = [];
  Future<void> getApprovedRequests() async {
    isLoading = true;
    approvedRequests = await _bl.getApprovedRequests();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllRequests() async {
    isLoading = true;
    allRequests = await _bl.getAllRequests();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getExpiredRequests() async {
    isLoading = true;
    expiredRequests = await _bl.getExpiredRequests();
    isLoading = false;
    notifyListeners();
  }

  List<LinkingUserRequest> rejectedRequests = [];
  Future<void> getRejectedRequests() async {
    isLoading = true;
    rejectedRequests = await _bl.getRejectedRequests();
    isLoading = false;
    notifyListeners();
  }

  Future<void> rejectRequests(LinkingUserRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.rejectRequest(request.id!);
    request.status = "rejected";
    pendingRequests.remove(request);
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> approveRequests(LinkingUserRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.approveRequest(request.id!);
    request.status = "approved";
    pendingRequests.remove(request);
    EasyLoading.dismiss();

    notifyListeners();
  }

  checkIfUserStillParent() {}
  Future<void> unLinkRequests(LinkingUserRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.unLinkRequest(request.id!);
    request.status = "expired";
    approvedRequests.remove(request);
    EasyLoading.dismiss();

    notifyListeners();
  }

  Future<void> cancelRequests(LinkingUserRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.cancelRequest(request.id!);
    request.status = "canceled";
    pendingRequests.remove(request);
    EasyLoading.dismiss();

    notifyListeners();
  }

  bool checkIfSendRequest(int brokerId) {
    return pendingRequests
        .where((element) => element.userId == brokerId)
        .isEmpty;
  }
}
