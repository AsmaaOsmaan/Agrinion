import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import '../view_logic/ad_vl.dart';

class BrokerSelection extends StatelessWidget {
  const BrokerSelection({
    Key? key,
    required this.vl,
  }) : super(key: key);

  final AdsVL vl;

  @override
  Widget build(BuildContext context) {
    return SelectionBottomSheet<Broker>(
      itemAsString: (u) => u.nameAr!,
      items: vl.brokers,
      onChange: (value) => vl.setBroker(value!),
      selectedItem: vl.broker,
      hintText: tr(LocaleKeys.marketer),
      onClearFn: () => vl.setBroker(null),
    );
  }
}
