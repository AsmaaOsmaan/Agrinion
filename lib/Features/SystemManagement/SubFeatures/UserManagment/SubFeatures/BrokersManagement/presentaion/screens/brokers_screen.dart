import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/screens/assign_broker_to_market.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../App/GlobalWidgets/loading_view.dart';
import '../logic/broker_management_vl.dart';
import 'brokers_item_builder.dart';

class BrokersScreen extends StatefulWidget {
  const BrokersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BrokersScreen> createState() => _BrokersScreenState();
}

class _BrokersScreenState extends State<BrokersScreen> {
  @override
  void initState() {
    context.read<BrokerManageVL>().getBrokers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<BrokerManageVL>(builder: (context, brokerManageVl, child) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
          tr(LocaleKeys.broker_management),
        )),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: brokerManageVl.isLoading
              ? const LoadingView()
              : ListView.separated(
                  itemCount: brokerManageVl.brokers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BrokerItemBuilder(
                      titleButton: tr(LocaleKeys.details),
                      onTap: () => AppRoute().navigate(
                        context: context,
                        route: AssignBrokerToMarket(
                            broker: brokerManageVl.brokers[index],
                            fromBrokersScreen: true,

                        ),
                      ),
                      broker: brokerManageVl.brokers[index],
                    );
                  },
                  separatorBuilder: (ctx, index) => const Divider(),
                ),
        ),
      );
    });
  }
}
