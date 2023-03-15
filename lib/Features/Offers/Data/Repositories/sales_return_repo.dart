import 'package:agriunion/Features/Offers/Data/DataSourse/sales_return_network.dart';
import 'package:agriunion/Features/Offers/Data/Mappers/sales_return_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';

import '../../../../App/Utilities/utils.dart';

abstract class ISalesReturnsRepository {
  Future<SalesReturn> createSalesReturn(SalesReturn model);
  Future<List<SalesReturn>> getSalesReturns(int conversationId);
}

class SalesReturnsRepository implements ISalesReturnsRepository {
  ISalesReturnNetworking salesReturnNetworking;
  SalesReturnsRepository(this.salesReturnNetworking);

  SalesReturn convertToModel(Map<String, dynamic> jsonResponse) {
    return SalesReturnMapper.fromJson(jsonResponse);
  }

  List<SalesReturn> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => SalesReturnMapper.fromJson(e)).toList();
  }

  @override
  Future<SalesReturn> createSalesReturn(SalesReturn model) async {
    final response = await salesReturnNetworking
        .createSalesReturn(SalesReturnMapper.toJson(model));

    final jsonResponse = Utils.convertToJson(response);
    final order = convertToModel(jsonResponse);
    return order;
  }

  @override
  Future<List<SalesReturn>> getSalesReturns(int conversationId) async {
    final response =
        await salesReturnNetworking.getSalesReturns(conversationId);
    final jsonResponse = Utils.convertToListJson(response);
    final salesReturns = convertToListModel(jsonResponse);
    return salesReturns;
  }
}
