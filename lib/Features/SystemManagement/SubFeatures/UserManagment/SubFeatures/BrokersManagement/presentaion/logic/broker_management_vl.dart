import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_market_entity.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../../../../CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import '../../../../../CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import '../../Domain/Entities/assign_broker_market_entity.dart';
import '../../Domain/ServiceLayer/service_layer.dart';

class BrokerManageVL extends ChangeNotifier {
  final IBrokerManagementService brokerManagementService;
  BrokerManageVL(this.brokerManagementService);

  List<Broker> brokers = [];
  bool isLoading = false;

  getBrokers() async {
    isLoading = true;
    brokers = await brokerManagementService.getAllBroker();
    isLoading = false;
    notifyListeners();
  }

  resetValues() {
    markets = [];
    city = null;
    market = null;
  }

  assignBrokerToMarket(
      AssignBrokerToMarketModel assignBrokerToMarketModel) async {
    LoadingDialog.showLoadingDialog();
    final assignBroker = await brokerManagementService
        .assignBrokerToMarket(assignBrokerToMarketModel);
    EasyLoading.dismiss();
    if (assignBroker.errorMsg != null) {
      LoadingDialog.showSimpleToast(assignBroker.errorMsg);
    } else {
      LoadingDialog.showSimpleToast("تم تعيين المسوق");
      getBrokerMarkets(assignBrokerToMarketModel.brokerId!);
    }
    notifyListeners();
  }

  sendBrokerRequestToJoinToMarket(
      AssignBrokerToMarketModel assignBrokerToMarketModel,
      BuildContext context) async {
    LoadingDialog.showLoadingDialog();
    final assignBroker = await brokerManagementService
        .assignBrokerToMarket(assignBrokerToMarketModel);
    EasyLoading.dismiss();
    if (assignBroker.errorMsg != null) {
      LoadingDialog.showSimpleToast(assignBroker.errorMsg);
    } else {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.order_successfully_sent));

      Navigator.pop(context);
    }
  }

  // Cities Module
  List<Cities> cities = [];
  Cities? city;
  getCities() async {
    cities = await brokerManagementService.getCities();
    notifyListeners();
  }

  onSelectionCity(Cities? city, int brokerId) async {
    setCity(city);
    await getMarkets(brokerId);
    notifyListeners();
  }

  setCity(Cities? city) {
    markets.clear();
    market = null;
    this.city = city;
    notifyListeners();
  }

// Markets Module

  List<Market> markets = [];
  Market? market;
  getMarkets(int brokerId) async {
    markets = await brokerManagementService.getUnlikedBrokerMarkets(
        brokerId, city!.id!);
    notifyListeners();
  }

  setMarket(Market? market) async {
    this.market = market;
    notifyListeners();
  }

  ////////////////////////////////////
  List<BrokerMarket> brokerMarkets = [];
  void getBrokerMarkets(int brokerId) async {
    LoadingDialog.showLoadingDialog();
    brokerMarkets = await brokerManagementService.getBrokerMarkets(brokerId);
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> unLinkRequests(int brokerId, int marketId, int index) async {
    LoadingDialog.showLoadingDialog();
    try {
      await brokerManagementService.unLinkBrokerMarket(brokerId, marketId);
      brokerMarkets.removeAt(index);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }

    notifyListeners();
  }
}
