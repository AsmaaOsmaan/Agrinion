import 'package:agriunion/Features/Offers/Data/Mappers/conversation_mapper.dart';
import 'package:agriunion/Features/Offers/Data/Mappers/offers_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/order_entity.dart';

import '../../../../App/Utilities/utils.dart';
import '../../Domain/Entities/create_order_model.dart';
import '../DataSource/orders_network.dart';
import '../Mappers/create_order_mapper.dart';
import '../Mappers/order_mapper.dart';

abstract class IOrdersRepository {
  Future<List<Order>> getOrders();
  Future<CreateOrderModel> createOrderId(CreateOrderModel model);
  Future<CreateOrderModel> createDirectOrderId(CreateOrderModel model);
  Future<Offer> placeOrder(Offer model, int orderId);
  Future<List<Order>> getSales();
}

class OrdersRepository implements IOrdersRepository {
  IOrdersNetworking ordersNetwork;
  OrdersRepository(this.ordersNetwork);

  List<Order> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => OrderMapper.fromJson(e)).toList();
  }

  List<Offer> convertToListOffersModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => OffersMapper.fromJson(e)).toList();
  }

  CreateOrderModel convertToCreateModel(Map<String, dynamic> jsonResponse) {
    return CreateOrderMapper.fromJson(jsonResponse);
  }

  Offer convertToModelOffer(Map<String, dynamic> jsonResponse) {
    return OffersMapper.fromJson(jsonResponse);
  }

  Order convertToModel(Map<String, dynamic> jsonResponse) {
    return OrderMapper.fromJson(jsonResponse);
  }

  @override
  Future<List<Order>> getOrders() async {
    final response = await ordersNetwork.getOrders();
    final jsonResponse = Utils.convertToListJson(response);
    final orders = convertToListModel(jsonResponse);
    return orders;
  }

  @override
  Future<List<Order>> getSales() async {
    final response = await ordersNetwork.getSales();
    final jsonResponse = Utils.convertToListJson(response);
    final orders = convertToListModel(jsonResponse);
    return orders;
  }

  @override
  Future<CreateOrderModel> createOrderId(CreateOrderModel model) async {
    final response =
        await ordersNetwork.createOrderId(CreateOrderMapper.toJson(model));

    final jsonResponse = Utils.convertToJson(response);
    final order = convertToCreateModel(jsonResponse);
    return order;
  }

  @override
  Future<CreateOrderModel> createDirectOrderId(CreateOrderModel model) async {
    final response = await ordersNetwork
        .createDirectOrderId(CreateOrderMapper.toJson(model));

    final jsonResponse = Utils.convertToJson(response);
    final order = convertToCreateModel(jsonResponse);
    return order;
  }

  @override
  Future<Offer> placeOrder(Offer model, int orderId) async {
    final response = await ordersNetwork.placeOrder(
        ConversationMapper.negotiationsToJson(model, orderId),
        orderId,
        model.adId!);
    final jsonResponse = Utils.convertToJson(response);
    final offer = convertToModelOffer(jsonResponse);
    return offer;
  }
}
