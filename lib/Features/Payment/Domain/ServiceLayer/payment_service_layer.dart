import 'package:agriunion/Features/Payment/Data/Repositories/payment_repo.dart';
import 'package:agriunion/Features/Payment/Domain/Entities/payment.dart';

abstract class IPaymentService {
  Future<Payment> createPaymentOnInvoice(Payment payment, int invoiceId);
  Future<List<Payment>> getPaymentsOnInvoice(int invoiceId);
}

class PaymentService implements IPaymentService {
  IPaymentRepository paymentRepository;
  PaymentService(this.paymentRepository);

  @override
  Future<Payment> createPaymentOnInvoice(Payment payment, int invoiceId) async {
    return await paymentRepository.createPaymentOnInvoice(payment, invoiceId);
  }

  @override
  Future<List<Payment>> getPaymentsOnInvoice(int invoiceId) async {
    return await paymentRepository.getPaymentsOnInvoice(invoiceId);
  }
}
