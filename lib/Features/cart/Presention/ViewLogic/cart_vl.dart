import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/App/Utilities/api_handler.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_model.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:agriunion/Features/cart/Domain/Entities/cart_item_entity.dart';
import 'package:agriunion/Features/cart/Domain/ServiceLayer/cart_service_layer.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:agriunion/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartVL extends ChangeNotifier {
  CreateOrderModel? orderModel;
  final ICartService cartService;
  CartVL(this.cartService);
  double total = 0;
  bool isLoading = false;
  List<CartItemEntity> offers = [];

  void addToCart(CartItemEntity offer) {
    if (checkIfTheOfferExistInCart(offer)) {
      offers[getExistedOfferIndex(offer)].quantity =
          offers[getExistedOfferIndex(offer)].quantity! + offer.quantity!;
    } else {
      offers.add(offer);
    }
    total = total + (offer.price! * offer.quantity!);
    notifyListeners();
  }

  void deleteFromCart(CartItemEntity offer) {
    offers.remove(offer);
    total = total - (offer.price! * offer.quantity!);
    notifyListeners();
  }

  void calcTotalPrice() {
    total = 0;
    for (var element in offers) {
      total += (element.quantity! * element.price!);
    }
  }

  bool checkIfTheOfferExistInCart(CartItemEntity offer) {
    return offers.where((element) => element.adId == offer.adId).isNotEmpty;
  }

  int getExistedOfferIndex(CartItemEntity offer) {
    return offers.indexWhere((element) => element.adId == offer.adId);
  }

  void incrementQuantity(int index) {
    offers[index].quantity = offers[index].quantity! + 1;
    total = total + offers[index].price!;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (offers[index].minQty! >= offers[index].quantity!) {
      ifTheUserReachTheLimit(offers[index]);
      return;
    }
    if (offers[index].quantity! > 0) {
      offers[index].quantity = offers[index].quantity! - 1;
      total = total - offers[index].price!;
    }
    notifyListeners();
  }

  void ifTheUserReachTheLimit(CartItemEntity offer) {
    if (offer.minQty! >= offer.quantity!) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.youReachedTheLimit));
    }
  }

  checkIfItemFoundInList(int id) {
    bool exists = offers.any((offer) => offer.adId == id);
    return exists;
  }

  createOrderId(CreateOrderModel createOrderModel) async {
    orderModel = await cartService.createOrderId(createOrderModel);
    notifyListeners();
  }

  createDirectOrderId(CreateOrderModel createOrderModel) async {
    orderModel = await cartService.createDirectOrderId(createOrderModel);
  }

  Future<Offer> placeOrder(Offer offerModel) async {
    Offer offer =
        await cartService.placeOrder(offerModel, orderModel!.orderId!);
    notifyListeners();
    return offer;
  }

  Future<Offer> managePlaceOrderWithOneOffer(Offer offer) async {
    LoadingDialog.showLoadingDialog();
    Offer addingOffer = await placeOrder(offer);
    if (addingOffer.errors != null) {
      LoadingDialog.showSimpleToast(addingOffer.errors!.quantityError);
    }
    EasyLoading.dismiss();
    return addingOffer;
  }

  sendAllOffers(Widget routeAfterDone) async {
    try {
      for (var index = 0; index <= offers.length - 1; index++) {
        var model = Offer(
          adId: offers[index].adId,
          price: offers[index].price,
          quantity: offers[index].quantity,
          note: offers[index].note,
        );
        if (offers[index].isSend == false) {
          Offer offer = await managePlaceOrderWithOneOffer(model);
          offers[index].isDone = (offer.errors == null);
          offers[index].isSend = (offer.errors == null);
          notifyListeners();
        }
      }
      bool isAllDone = offers.where((element) => !element.isDone).isEmpty;
      if (isAllDone) {
        LoadingDialog.showSimpleToast("Your order has been sent successfully");
        clearOffers();
        afterOrderDone(routeAfterDone);
      } else {
        EasyLoading.dismiss();
      }

      notifyListeners();
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
  }

  afterOrderDone(Widget route) async {
    AppRoute().navigate(
      context: navKey.currentContext!,
      route: route,
    );
    orderModel = null;
    total = 0;
  }

  clearOffers() {
    offers.clear();
  }

  bool visibilityOfAddToCartButton(AdModel ad, bool fromMyAds) {
    final id = CachHelper.getData(key: kId);
    String type = CachHelper.getData(key: kType);
    if (type == "Merchant") {
      return true;
    }
    if (type == "Farmer" && fromMyAds) {
      return false;
    }
    if (((type == "Broker" || type == "Farmer") &&
            !ad.negotiatorIds!.contains(id)) ||
        fromMyAds) {
      return true;
    } else {
      return false;
    }
  }

  updateOffer(int index, double quantity, double price) {
    if (offers[index].minQty! >= quantity) {
      ifTheUserReachTheLimit(offers[index]);
      return;
    }

    if (quantity > 0) {
      offers[index].quantity = quantity;
      offers[index].price = price;
      calcTotalPrice();
      notifyListeners();
    }
  }

  sendOffers(Widget routeAfterDone) {
    sendAllOffers(routeAfterDone);
    EasyLoading.dismiss();
  }
}
