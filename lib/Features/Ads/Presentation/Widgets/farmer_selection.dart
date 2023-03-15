import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../generated/translations.g.dart';
import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import '../view_logic/ad_vl.dart';

class FarmerSelection extends StatelessWidget {
  const FarmerSelection({
    Key? key,
    required this.vl,
  }) : super(key: key);

  final AdsVL vl;

  @override
  Widget build(BuildContext context) {
    return SelectionBottomSheet<CommercialProfileModel>(
      itemAsString: (u) => u.profileName!,
      items: vl.farmers,
      onChange: (value) => vl.setFarmer(value!),
      selectedItem: vl.farmer,
      hintText: tr(LocaleKeys.farmer),
      onClearFn: () => vl.setFarmer(null),
    );
  }
}
