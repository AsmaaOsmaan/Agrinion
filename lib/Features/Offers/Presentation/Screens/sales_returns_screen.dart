import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Offers/Presentation/Widgets/sales_return_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SalesReturnsScreen extends StatefulWidget {
  final int conversationId;
  const SalesReturnsScreen({
    Key? key,
   required this.conversationId
  }) : super(key: key);

  @override
  State<SalesReturnsScreen> createState() => _SalesReturnsScreenState();
}

class _SalesReturnsScreenState extends State<SalesReturnsScreen> {
  @override
  void initState() {
    context.read<OffersVL>().getSalesReturns(widget.conversationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.sales_returns))),
      body: Consumer<OffersVL>(builder: (context, vl, child) {
        return vl.isLoading
            ? const LoadingView()
            : ListView.separated(
          itemCount: vl.salesReturns.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          padding: const EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int index) {
            return SalesReturnWidget(salesReturn: vl.salesReturns[index],index: index,);
          },
        );
      }),
    );
  }
}
