import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/constants/distances.dart';
import '../../../../generated/translations.g.dart';
import '../../../Account/Presentation/Screens/manage_my_ads.dart';
import '../../../Account/Presentation/Widgets/app_list_tile.dart';
import '../../../Orders/Presentation/Screens/order_screen.dart';
import '../../../Orders/Presentation/Screens/sales_screens.dart';
import '../../../Reports/Presentation/Screens/invoices_screen.dart';

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String? type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('myShop'))),
      body: Padding(
        padding: const EdgeInsets.all(paddingDistance),
        child: SingleChildScrollView(
          child: Column(
            children: [
              type == "Merchant"
                  ? const SizedBox()
                  : AppListTile(
                      title: tr("sellingAds"),
                      icon: AppIcons.myOrders,
                      route: const ManageMyAds(),
                    ),
              AppListTile(
                title: tr(LocaleKeys.my_orders),
                icon: AppIcons.myOrders,
                route: const MyOrdersScreen(),
              ),
              type != "Broker"
                  ? const SizedBox()
                  : AppListTile(
                      title: tr("sales"),
                      icon: AppIcons.myOrders,
                      route: const SalesScreen(),
                    ),
              AppListTile(
                title: tr(LocaleKeys.recieved_invoices),
                icon: AppIcons.myOrders,
                route:  InvoicesScreen(function: (){
                  context.read<OffersVL>().getInvoices();
                }),
              ),
              AppListTile(
                title: tr(LocaleKeys.my_invoices),
                icon: AppIcons.myOrders,
                route:  InvoicesScreen(function: (){
                  context.read<OffersVL>().getMyInvoices();

                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
