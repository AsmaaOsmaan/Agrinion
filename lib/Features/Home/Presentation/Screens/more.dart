import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Account/Presentation/Screens/account_management.dart';
import 'package:agriunion/Features/Account/Presentation/ViewLogic/users_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Utilities/cache_helper.dart';
import '../../../../App/constants/keys.dart';
import '../../../../generated/translations.g.dart';
import '../../../Account/Presentation/Widgets/app_list_tile.dart';
import '../../../Account/Presentation/Widgets/info_header.dart';
import '../../../Reports/Presentation/Screens/sales_reports.dart';
import 'my_shop_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String? type;

  @override
  void initState() {
    type = CachHelper.getData(key: kType);

    context.read<LinkingUsersRequestsVL>().getBrokerStatus();
    context.read<UsersVL>().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight! * .1),
            InfoHeader(
              onTap: () => AppRoute()
                  .navigate(context: context, route: const AccountManagement()),
              suffixIcon: Image.asset(
                AppIcons.settings,
                height: 30,
              ),
            ),
            const Divider(thickness: 10, color: ColorManager.primary),
            Padding(
              padding: const EdgeInsets.only(left: paddingDistance),
              child: Column(
                children: [
                  type == 'Admin'
                      ? const SizedBox()
                      : AppListTile(
                          title: tr(LocaleKeys.myShop),
                          icon: AppIcons.myOrders,
                          route: MyShopScreen(type: type),
                        ),
                  type == 'Broker'
                      ? AppListTile(
                          title: tr('salesReports'),
                          icon: AppIcons.myOrders,
                          route: const GenerateSalesReports(),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
