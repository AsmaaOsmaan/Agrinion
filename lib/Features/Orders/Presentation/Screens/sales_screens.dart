import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/loading_view.dart';
import '../ViewLogic/orders_vl.dart';
import '../Widgets/order_widget.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    context.read<OrdersVL>().getSales();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('sales'))),
      body: Consumer<OrdersVL>(builder: (context, vl, child) {
        return vl.isLoading
            ? const LoadingView()
            : ListView.separated(
                itemCount: vl.sales.length,
                padding: const EdgeInsets.all(20),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return OrderWidget(order: vl.sales[index], index: index);
                },
              );
      }),
    );
  }
}
