
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/Widgets/broker_market_item_builder.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/logic/broker_management_vl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrokerMarketsScreen extends StatelessWidget {
  const BrokerMarketsScreen({Key? key,required this.brokerId}) : super(key: key);
 final int brokerId;
  @override
  Widget build(BuildContext context) {
     return Consumer<BrokerManageVL>(builder: (context, brokerManageVl, child) {
      return  Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child:  ListView.separated(
            itemCount:brokerManageVl.brokerMarkets.length ,
            itemBuilder: (BuildContext context, int index) {

              return   BrokerMarketItemBuilder(
                brokerMarket: brokerManageVl.brokerMarkets[index],
                brokerId: brokerId,
                index: index,
              );
            },
            separatorBuilder: (ctx, index) => const Divider(),
          ),
        );

    });
  }
}
