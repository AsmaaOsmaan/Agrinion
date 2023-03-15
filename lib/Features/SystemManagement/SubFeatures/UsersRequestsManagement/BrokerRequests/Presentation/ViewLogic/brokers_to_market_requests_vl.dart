import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/rejection_reason_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Service/broker_requests_bl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Domain/Entities/broker_to_market_requests_entity.dart';

class BrokersToMarketRequestsVL extends ChangeNotifier {
  final IBrokerRequestsBL _bl;
  BrokersToMarketRequestsVL(this._bl);
  BrokerToMarketRequest? brokerToMarketRequest;

  List<BrokerToMarketRequest> pendingRequests = [];
  bool isLoading = false;
  Future<void> getPendingRequests() async {
    isLoading = true;
    pendingRequests = await _bl.getPendingRequests();
    isLoading = false;
    notifyListeners();
  }

  Future<void> unLinkRequests(BrokerToMarketRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.unLinkRequest(request.id!);
    request.status = "expired";
    approvedRequests.remove(request);
    EasyLoading.dismiss();

    notifyListeners();
  }

  Future<void> cancelRequests(BrokerToMarketRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.cancelRequest(request.id!);
    request.status = "canceled";
    pendingRequests.remove(request);
    EasyLoading.dismiss();

    notifyListeners();
  }

  List<BrokerToMarketRequest> approvedRequests = [];
  Future<void> getApprovedRequests() async {
    isLoading = true;
    approvedRequests = await _bl.getApprovedRequests();
    isLoading = false;
    notifyListeners();
  }

  List<BrokerToMarketRequest> unlinkedRequests = [];
  Future<void> getUnlinkedRequests() async {
    isLoading = true;
    unlinkedRequests = await _bl.getUnlinkedRequests();
    isLoading = false;
    notifyListeners();
  }

  List<BrokerToMarketRequest> rejectedRequests = [];
  Future<void> getRejectedRequests() async {
    isLoading = true;
    rejectedRequests = await _bl.getRejectedRequests();
    isLoading = false;
    notifyListeners();
  }

  showSpecificBrokersMarketRequest(int id) async {
    isLoading = true;
    brokerToMarketRequest = await _bl.showSpecificBrokersMarketRequest(id);
    isLoading = false;
    notifyListeners();
  }

  Future<void> rejectRequests(
      BrokerToMarketRequest request, RejectionReasonModel reasonModel) async {
    LoadingDialog.showLoadingDialog();
    await _bl.rejectRequest(request.id!, reasonModel);
    request.status = "rejected";
    pendingRequests.remove(request);
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> approveRequests(BrokerToMarketRequest request) async {
    LoadingDialog.showLoadingDialog();
    await _bl.approveRequest(request.id!);
    request.status = "approved";
    pendingRequests.remove(request);
    EasyLoading.dismiss();

    notifyListeners();
  }
}
