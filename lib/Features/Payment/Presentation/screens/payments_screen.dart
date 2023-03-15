import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/Features/Payment/Presentation/ViewLogic/payment_vl.dart';
import 'package:agriunion/Features/Payment/Presentation/widgets/payment_item_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentsScreen extends StatefulWidget {
  final int invoiceId;
  const PaymentsScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  @override
  void initState() {
    context.read<PaymentVL>().getPaymentsOnInvoice(widget.invoiceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.payments))),
      body: Consumer<PaymentVL>(builder: (context, vl, child) {
        return vl.loading
            ? const LoadingView()
            : ListView.separated(
                itemCount: vl.payments.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return PaymentWidget(
                    payment: vl.payments[index],
                  );
                },
              );
      }),
    );
  }
}
