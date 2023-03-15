import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/globale_state.dart';
import 'package:agriunion/Features/Ads/Presentation/Screen/my_favorite_ads.dart';
import 'package:agriunion/Features/Authentication/Presentation/Screens/auth_screen.dart';
import 'package:agriunion/Features/News/Presentation/Screens/admin/admin_list_news_screen.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/screens/assign_broker_to_market.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Screens/user_mangment.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/Screens/linking_broker_screen.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/Screens/users_linking_requests.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Utilities/cache_helper.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/keys.dart';
import '../../../../generated/translations.g.dart';
import '../../../SystemManagement/Screens/system_management.dart';
import '../../../SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/Screens/users_requests.dart';
import '../Widgets/app_list_tile.dart';
import '../Widgets/info_header.dart';
import '../Widgets/reset_password_widget.dart';
import 'complete_profile.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({Key? key}) : super(key: key);

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  String? type;
  @override
  void initState() {
    type = CachHelper.getData(key: kType);
    context.read<LinkingUsersRequestsVL>().getBrokerStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة حسابي"),
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          InfoHeader(
            onTap: () => AppRoute().navigate(
              context: context,
              route: const CompleteProfile(),
            ),
            bgColor: ColorManager.primary,
            suffixIcon: Image.asset(
              AppIcons.edit,
              height: 30,
            ),
            fontColor: ColorManager.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingDistance),
            child: Column(
              children: [
                type == "Admin"
                    ? Column(
                        children: const [
                          AppListTile(
                            title: "إدارة النظام",
                            icon: AppIcons.myOrders,
                            route: SystemManagement(),
                          ),
                        ],
                      )
                    : const SizedBox(),
                type == "Admin" || type == "Broker"
                    ? AppListTile(
                        title: tr(LocaleKeys.user_management),
                        icon: AppIcons.myOrders,
                        route: const UserManagement(),
                      )
                    : const SizedBox(),
                AppListTile(
                  title: tr(LocaleKeys.change_password),
                  icon: AppIcons.myOrders,
                  route: const ResetPasswordWidget(),
                ),
                Consumer<LinkingUsersRequestsVL>(builder: (context, vl, child) {
                  return Visibility(
                    visible: vl.brokerStatus != null
                        ? (type == 'Broker' &&
                                vl.brokerStatus!.parent! == false &&
                                vl.brokerStatus!.parent! == false)
                            ? true
                            : false
                        : false,
                    child: AppListTile(
                      title: tr(LocaleKeys.send_request_to_broker),
                      icon: AppIcons.myOrders,
                      route: const LinkingsBrokersScreen(),
                    ),
                  );
                }),
                Visibility(
                  visible: type == 'Broker',
                  child: AppListTile(
                    title: tr(LocaleKeys.linking_users_requests),
                    icon: AppIcons.myOrders,
                    route: const UsersLinkingRequestsScreen(),
                  ),
                ),
                CachHelper.getData(key: kType) == 'Admin'
                    ? const SizedBox()
                    : AppListTile(
                        title: tr(LocaleKeys.favorite_ads),
                        icon: AppIcons.myOrders,
                        route: const MyFavoriteAds(),
                      ),
                Visibility(
                  visible: type == 'Broker',
                  child: AppListTile(
                    title: tr(LocaleKeys.broker_market_requests),
                    icon: AppIcons.myOrders,
                    route: const UserRequestsScreen(),
                  ),
                ),
                Visibility(
                  visible: type == 'Broker',
                  child: AppListTile(
                    title: tr(LocaleKeys.send_join_market_request),
                    icon: AppIcons.myOrders,
                    route: const AssignBrokerToMarket(),
                  ),
                ),
                type == 'Admin'
                    ? Visibility(
                        visible: type == 'Admin',
                        child: AppListTile(
                          title: tr(LocaleKeys.news),
                          icon: AppIcons.myOrders,
                          route: const AdminListNewsScreen(),
                        ),
                      )
                    : const SizedBox(),
                ListTile(
                  leading: Image.asset(AppIcons.logout, height: 30),
                  title: Text(
                    tr(LocaleKeys.exit),
                    style:
                        getBoldStyle(fontColor: ColorManager.error, size: 14),
                  ),
                  onTap: () {
                    context.read<GlobalAdsCartVL>().clearOffers();
                    CachHelper.removeData(key: kProfile);
                    GlobalState.instance.set(kToken, null);
                    CachHelper.removeData(key: kToken);
                    CachHelper.saveData(key: kRemember, value: false);
                    AppRoute().navigateAndRemove(
                      context: context,
                      route: const AuthScreen(),
                    );
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
