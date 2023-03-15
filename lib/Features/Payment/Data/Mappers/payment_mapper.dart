import 'package:agriunion/Features/Payment/Domain/Entities/payment.dart';

class PaymentMapper {
  static Payment fromJson(Map<String, dynamic> json) {
    return Payment(
        paymentAmount: json['payment_amount'],
        invoiceId: json['invoice_id'],
        paymentId: json["payment_id"],
        createdAt: json['created_at']);
  }

  static Map<String, dynamic> toJson(Payment payment) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_amount'] = payment.paymentAmount;
    return {"payment": data};
  }
}
