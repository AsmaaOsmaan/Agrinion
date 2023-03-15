import 'package:agriunion/Features/Orders/Data/Repositories/orders_repo.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/order_entity.dart';

abstract class IOrdersBL {
  Future<List<Order>> getOrders();
  Future<List<Order>> getSales();
}

class OrdersBL implements IOrdersBL {
  IOrdersRepository ordersRepo;
  OrdersBL(this.ordersRepo);
  @override
  Future<List<Order>> getOrders() async {
    return await ordersRepo.getOrders();
  }

  @override
  Future<List<Order>> getSales() async {
    return await ordersRepo.getSales();
  }
}
