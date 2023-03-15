import 'package:agriunion/Features/Payment/Data/DataSource/payment_network.dart';
import 'package:agriunion/Features/Payment/Data/Mappers/payment_mapper.dart';
import 'package:agriunion/Features/Payment/Domain/Entities/payment.dart';

import '../../../../App/Utilities/utils.dart';

abstract class IPaymentRepository {
  Future<Payment> createPaymentOnInvoice(Payment model, int invoiceId);
  Future<List<Payment>> getPaymentsOnInvoice(int invoiceId);
}

class PaymentRepository implements IPaymentRepository {
  IPaymentNetworking paymentNetwork;
  PaymentRepository(this.paymentNetwork);

  Payment convertToModel(Map<String, dynamic> jsonResponse) {
    return PaymentMapper.fromJson(jsonResponse);
  }

  List<Payment> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => PaymentMapper.fromJson(e)).toList();
  }

  @override
  Future<Payment> createPaymentOnInvoice(Payment model, int invoiceId) async {
    final response = await paymentNetwork.createPaymentOnInvoice(
        PaymentMapper.toJson(model), invoiceId);
    final jsonResponse = Utils.convertToJson(response);
    final payment = convertToModel(jsonResponse);
    return payment;
  }

  @override
  Future<List<Payment>> getPaymentsOnInvoice(int invoiceId) async {
    final response = await paymentNetwork.getPaymentsOnInvoice(invoiceId);
    final jsonResponse = Utils.convertToListJson(response);
    final payments = convertToListModel(jsonResponse);
    return payments;
  }
}
