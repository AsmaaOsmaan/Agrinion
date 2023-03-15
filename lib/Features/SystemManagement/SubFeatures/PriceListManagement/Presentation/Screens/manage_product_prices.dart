import 'package:agriunion/App/GlobalWidgets/app_tab_bar.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../PricesList/Presentation/ViewLogic/price_list_vl.dart';
import '../Widgets/non_pricable_item.dart';
import '../Widgets/price_list_item.dart';

class ManageProductsPrices extends StatelessWidget {
  const ManageProductsPrices({Key? key, this.date}) : super(key: key);
  final String? date;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<PriceListVL>(builder: (context, vl, child) {
        return Scaffold(
          appBar: AppBar(title: Text(tr(LocaleKeys.manage_products))),
          body: Column(
            children: [
              AppTabBar(
                tabBar: TabBar(
                  tabs: [
                    Tab(text: tr("pricable")),
                    Tab(text: tr("nonPricable")),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.builder(
                      itemCount: vl.priceableList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          PricableListItem(
                        product: vl.priceableList[index],
                        date: vl.priceList!.priceDate!,
                        index: index,
                      ),
                    ),
                    ListView.builder(
                      itemCount: vl.notPricedList.length,
                      padding: const EdgeInsets.all(paddingDistance),
                      itemBuilder: (BuildContext context, int index) =>
                          NonPricableProductItem(
                              product: vl.notPricedList[index]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
