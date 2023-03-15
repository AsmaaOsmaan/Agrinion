import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Reports/Presentation/Widgets/invoice_item_builder.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoicesScreen extends StatefulWidget {
  final  Function function;
  const InvoicesScreen({
    Key? key,
    required this.function
  }) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  void initState() {
    widget.function();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.invoices))),
      body: Consumer<OffersVL>(builder: (context, vl, child) {
        return vl.isLoading
            ? const LoadingView()
            : ListView.separated(
                itemCount: vl.invoices.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return InvoiceItemBuilder(
                    invoicesModel: vl.invoices[index],
                  );
                },
              );
      }),
    );
  }
}
