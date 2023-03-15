import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:agriunion/Features/cart/Domain/ServiceLayer/cart_service_layer.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/cart_vl.dart';
import 'package:flutter/material.dart';

import '../../../Offers/Presentation/Screens/conversations_screen.dart';

class GlobalAdsCartVL extends CartVL {
  GlobalAdsCartVL(ICartService cartService) : super(cartService);

  manageSendAllOffers(BuildContext context) async {
    if (orderModel == null) {
      await createOrderId(CreateOrderModel(commercialProfileId: null));
    }
    sendOffers(OrderConversations(orderId: orderModel!.orderId!));
  }
}
