import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/screens/brokers_screen.dart';
import 'package:agriunion/Features/SystemManagement/Widgets/system_management_tile.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'commercial_profiles_screen.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.user_management))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          SystemManagementTile(
            ontap: () => AppRoute().navigate(
                context: context, route: const CommercialProfilesScreen()),
            title: tr(LocaleKeys.commercial_profiles_management),
          ),
          CachHelper.getData(key: kType) == "Admin"
              ? SystemManagementTile(
                  ontap: () => AppRoute()
                      .navigate(context: context, route: const BrokersScreen()),
                  title: tr(LocaleKeys.broker_management),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
