import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/Features/Reports/Presentation/Widgets/client_info_widget.dart';
import 'package:agriunion/Features/Reports/Presentation/Widgets/invoice_header.dart';
import 'package:agriunion/Features/Reports/Presentation/Widgets/purchase_widget.dart';
import 'package:agriunion/Features/Reports/Presentation/Widgets/total_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InvoiceSummary extends StatelessWidget {
  const InvoiceSummary({Key? key, required this.invoicesModel})
      : super(key: key);
  final InvoicesModel invoicesModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text(tr(LocaleKeys.invoice_details))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InvoiceHeader(invoicesModel: invoicesModel),
              const SizedBox(
                height: paddingDistance,
              ),
              ClientInfoWidget(invoicesModel: invoicesModel),
              const SizedBox(
                height: paddingDistance,
              ),
              PurchaseWidget(sales: invoicesModel.sales!),
              const SizedBox(
                height: paddingDistance,
              ),
              TotalWidget(invoicesModel: invoicesModel),
            ],
          ),
        ),
      ),
    );
  }
}
