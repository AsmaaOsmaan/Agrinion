import 'package:agriunion/App/GlobalWidgets/bottom_sheet_selection.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/logic/broker_management_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/screens/broker_markets_screen.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../App/GlobalWidgets/app_button.dart';
import '../../../../../CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import '../../Domain/Entities/assign_broker_market_entity.dart';

class AssignBrokerToMarket extends StatefulWidget {
  const AssignBrokerToMarket({
    Key? key,
    this.broker,
    this.fromBrokersScreen = false,
  }) : super(key: key);
  final Broker? broker;
  final bool fromBrokersScreen;

  @override
  State<AssignBrokerToMarket> createState() => _AssignBrokerToMarketState();
}

class _AssignBrokerToMarketState extends State<AssignBrokerToMarket> {
  int? brokerId;
  String? type;
  @override
  void initState() {
    super.initState();
    type = CachHelper.getData(key: kType);
    context.read<BrokerManageVL>().getCities();
    widget.fromBrokersScreen
        ? context.read<BrokerManageVL>().getBrokerMarkets(widget.broker!.id!)
        : "";
    widget.broker != null
        ? brokerId = widget.broker!.id
        : brokerId = CachHelper.getData(key: kId);
  }

  @override
  void didChangeDependencies() {
    context.read<BrokerManageVL>().resetValues();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: type == 'Broker'
              ? Text(tr(LocaleKeys.send))
              : Text(tr(LocaleKeys.Assign_Broker))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Consumer<BrokerManageVL>(
          builder: (context, brokerManagement, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Visibility(
                      visible: !(type == 'Broker'),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: widget.broker != null
                                ? "${widget.broker!.nameAr}"
                                : ""),
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SelectionBottomSheet<Cities>(
                      itemAsString: (u) => u.nameAr,
                      items: brokerManagement.cities,
                      onChange: (data) =>
                          brokerManagement.onSelectionCity(data, brokerId!),
                      selectedItem: brokerManagement.city,
                      hintText: tr(LocaleKeys.select_city),
                      onClearFn: () => brokerManagement.setCity(
                        null,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IgnorePointer(
                      ignoring: brokerManagement.city == null ? true : false,
                      child: SelectionBottomSheet<Market>(
                        itemAsString: (u) => u.nameAr,
                        items: brokerManagement.markets,
                        onChange: (data) => brokerManagement.setMarket(data),
                        selectedItem: brokerManagement.market,
                        hintText: tr(LocaleKeys.select_market),
                        onClearFn: () => brokerManagement.setMarket(null),
                      ),
                    ),
                    type == 'Admin'
                        ? AppButton(
                            title: tr(LocaleKeys.Assign),
                            onTap: () {
                              brokerManagement.assignBrokerToMarket(
                                AssignBrokerToMarketModel(
                                  brokerId: widget.broker!.id,
                                  marketId: brokerManagement.market!.id!,
                                ),
                              );
                            },
                          )
                        : AppButton(
                            title: tr(LocaleKeys.send),
                            onTap: () {
                              brokerManagement.sendBrokerRequestToJoinToMarket(
                                  AssignBrokerToMarketModel(
                                    marketId: brokerManagement.market!.id!,
                                  ),
                                  context);
                            },
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.fromBrokersScreen
                    ? Expanded(
                        flex: 3,
                        child: BrokerMarketsScreen(
                          brokerId: widget.broker!.id!,
                        ))
                    : const SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}
