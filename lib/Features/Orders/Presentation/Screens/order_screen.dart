import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/Features/Orders/Presentation/ViewLogic/orders_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/order_widget.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    context.read<OrdersVL>().getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.my_orders))),
      body: Consumer<OrdersVL>(builder: (context, vl, child) {
        return vl.isLoading
            ? const LoadingView()
            : ListView.separated(
                itemCount: vl.orders.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return OrderWidget(order: vl.orders[index], index: index);
                },
              );
      }),
    );
  }
}
