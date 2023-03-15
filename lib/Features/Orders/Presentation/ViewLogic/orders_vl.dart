import 'package:agriunion/Features/Orders/Domain/BusinessLogic/orders_service_layer.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/order_entity.dart';
import 'package:flutter/material.dart';

class OrdersVL extends ChangeNotifier {
  final IOrdersBL _ordersBL;
  OrdersVL(this._ordersBL);
  List<Order> orders = [];
  List<Order> sales = [];
  bool isLoading = false;
  void getOrders() async {
    isLoading = true;
    orders = await _ordersBL.getOrders();
    isLoading = false;
    notifyListeners();
  }

  void getSales() async {
    isLoading = true;
    sales = await _ordersBL.getSales();
    isLoading = false;
    notifyListeners();
  }
}
