import 'package:agriunion/Features/Offers/Data/Repositories/sales_return_repo.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';

abstract class ISalesReturnsBL {
  Future<SalesReturn> createSalesReturn(SalesReturn salesReturn);
  Future<List<SalesReturn>> getSalesReturns(int conversationId);
}

class SalesReturnsBL implements ISalesReturnsBL {
  ISalesReturnsRepository salesReturnsRepository;
  SalesReturnsBL(this.salesReturnsRepository);
  @override
  Future<SalesReturn> createSalesReturn(SalesReturn salesReturn) async {
    return await salesReturnsRepository.createSalesReturn(salesReturn);
  }

  @override
  Future<List<SalesReturn>> getSalesReturns(int conversationId) async {
    return await salesReturnsRepository.getSalesReturns(conversationId);
  }

}
