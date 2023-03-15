import 'package:agriunion/Features/Payment/Domain/Entities/payment.dart';
import 'package:agriunion/Features/Payment/Domain/ServiceLayer/payment_service_layer.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../App/GlobalWidgets/loading_dialog.dart';

class PaymentVL extends ChangeNotifier {
  final IPaymentService paymentService;
  PaymentVL(this.paymentService);

  createPaymentOnInvoice(
      Payment payment, int invoiceId) async {
    try {
      LoadingDialog.showLoadingDialog();
      await paymentService.createPaymentOnInvoice(payment, invoiceId);
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(
          tr(LocaleKeys.payment_completed_successfully));
      notifyListeners();
    } catch (e) {
      LoadingDialog.showSimpleToast("something error");
      EasyLoading.dismiss();
    }
  }



  bool loading = false;
  List<Payment> payments = [];

  Future<void> getPaymentsOnInvoice(int invoiceId) async {
    loading = true;
    payments = await paymentService.getPaymentsOnInvoice(invoiceId);
    loading = false;
    notifyListeners();
  }
}
