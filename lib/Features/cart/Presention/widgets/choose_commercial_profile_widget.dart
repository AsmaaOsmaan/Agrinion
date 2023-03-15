import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_helper.dart';
import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Widgets/add_commercial_profile.dart';

class ChooseCommercialProfile extends StatefulWidget {
  const ChooseCommercialProfile({Key? key}) : super(key: key);

  @override
  State<ChooseCommercialProfile> createState() =>
      _ChooseCommercialProfileState();
}

class _ChooseCommercialProfileState extends State<ChooseCommercialProfile> {
  @override
  void initState() {
    context.read<MyAdsCartVL>().getMerchantCommercialProfiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAdsCartVL>(
      builder: (context, cartVl, child) {
        return Row(
          children: [
            Expanded(
              flex: 4,
              child: SelectionBottomSheet<CommercialProfileModel>(
                itemAsString: (u) => u.profileName!,
                items: cartVl.merchantCommercialProfiles,
                onChange: (data) => cartVl.setSelectedUser(data),
                selectedItem: cartVl.commercialProfile,
                hintText: tr(LocaleKeys.merchant_name),
                onClearFn: () => cartVl.setSelectedUser(null),
                fillColor: ColorManager.white,
                filled: true,
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => BottomSheetHelper(
                  context: context,
                  content: const AddCommercialProfileSheet(fromCart: true),
                ).openFullSheet(),
                child: Container(
                  margin: const EdgeInsets.only(right: paddingDistance),
                  decoration: BoxDecoration(
                    color: ColorManager.lightGrey1,
                    borderRadius: radius8,
                  ),
                  padding: const EdgeInsets.all(paddingDistance),
                  child: const Icon(Icons.add, color: ColorManager.grey),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
