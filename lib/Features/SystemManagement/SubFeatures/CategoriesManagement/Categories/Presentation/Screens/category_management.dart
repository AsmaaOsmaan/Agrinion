import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Logic/categories_vl.dart';
import 'categories_management.dart';
import 'category_group_management.dart';

class CategoriesManagementScreen extends StatelessWidget {
  const CategoriesManagementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesVL>(builder: (context, categoriesVl, child) {
      return Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.manage_categories))),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Column(
            children: [
              CategoryItem(
                route: const CategoriesScreen(),
                title: tr(LocaleKeys.manage_categories),
              ),
              CategoryItem(
                route: const CategoryGroupManagementScreen(),
                title: tr(LocaleKeys.manageCategoryGroup),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);
  final String title;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute().navigate(context: context, route: route),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: SizeConfig.screenHeight! * .08,
        decoration: BoxDecoration(
          color: ColorManager.lightGrey1,
          borderRadius: radius8,
          border: Border.all(color: ColorManager.lightGrey),
        ),
        padding: const EdgeInsets.all(20),
        child: Text(title, style: getBoldStyle()),
      ),
    );
  }
}
