import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:agriunion/Features/Orders/Presentation/Screens/sales_screens.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import 'package:agriunion/Features/cart/Domain/ServiceLayer/cart_service_layer.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Offers/Presentation/Screens/conversations_screen.dart';

class MyAdsCartVL extends CartVL {
  CommercialProfileModel? commercialProfile;
  List<CommercialProfileModel> merchantCommercialProfiles = [];

  MyAdsCartVL(ICartService cartService) : super(cartService);
  validate() {
    if (commercialProfile == null &&
        CachHelper.getData(key: kType) == "Broker") {
      LoadingDialog.showSimpleToast(tr('merchantRequired'));
      return false;
    }
    return true;
  }

  getMerchantCommercialProfiles() async {
    merchantCommercialProfiles =
        await cartService.getMerchantsCommercialProfiles();
    notifyListeners();
  }

  addCommercialProfile(CommercialProfileModel commercialProfileModel) async {
    final addedCommercialProfile =
        await cartService.addCommercialProfile(commercialProfileModel);
    commercialProfile = addedCommercialProfile;
    merchantCommercialProfiles.add(addedCommercialProfile);
    notifyListeners();
  }

  setSelectedUser(CommercialProfileModel? commercialProfile) async {
    this.commercialProfile = commercialProfile;

    notifyListeners();
  }

  manageSendAllOffers() async {
    if (validate()) {
      if (orderModel == null) {
        await createOrderId(
            CreateOrderModel(commercialProfileId: commercialProfile?.id));
      }
      sendOffers(OrderConversations(orderId: orderModel!.orderId!));
    }
  }

  createDirectOrderWithOffers(BuildContext context) async {
    if (validate()) {
      if (orderModel == null) {
        await createDirectOrderId(
            CreateOrderModel(commercialProfileId: commercialProfile?.id));
      }
      sendOffers(const SalesScreen());
    }
  }
}
