import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Screens/category_management.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../PricesList/Presentation/Screens/prices_list_filter.dart';
import '../SubFeatures/CitiesAndMarkets/Cities/Presentation/Screens/city_managements.dart';
import '../SubFeatures/Products/Presentation/Screens/products_management_screen.dart';
import '../SubFeatures/UnitTypes/Presentation/Screens/unit_types_management.dart';
import '../SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/Screens/users_requests.dart';
import '../Widgets/system_management_tile.dart';

class SystemManagement extends StatelessWidget {
  const SystemManagement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة النظام")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          SystemManagementTile(
            ontap: () => AppRoute().navigate(
                context: context, route: const CategoriesManagementScreen()),
            title: "إدارة الفئات ",
          ),
          SystemManagementTile(
            ontap: () => AppRoute().navigate(
                context: context, route: const CitiesManagementScreen()),
            title: "إدارة المدن والأسواق ",
          ),
          SystemManagementTile(
            ontap: () => AppRoute().navigate(
                context: context, route: const ProductsManagementScreen()),
            title: "إدارة المنتجات ",
          ),
          SystemManagementTile(
            ontap: () => AppRoute()
                .navigate(context: context, route: const UnitTypesManagement()),
            title: tr(LocaleKeys.manage_ad_units),
          ),
          SystemManagementTile(
            ontap: () => AppRoute()
                .navigate(context: context, route: const UserRequestsScreen()),
            title: tr(LocaleKeys.usersRequestsManagement),
          ),
          SystemManagementTile(
            ontap: () => AppRoute().navigate(
              context: context,
              route: const PriceListFilter.management(),
            ),
            title: tr(LocaleKeys.price_list),
          ),
        ]),
      ),
    );
  }
}
