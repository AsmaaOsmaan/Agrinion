import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/loading_view.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../Ads/Presentation/view_logic/ad_vl.dart';
import '../../../Home/Presentation/Widgets/home_imports.dart';
import '../../../SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import '../Screeens/category_screen.dart';

class MainCategories extends StatelessWidget {
  const MainCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<AdsVL>().isCategoryLoading
        ? const LoadingView()
        : Selector<AdsVL, List<Categories>>(
            builder: (context, categories, child) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: SizeConfig.screenWidth! * .4,
                  crossAxisCount: 1,
                ),
                itemCount: categories.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => HomeContainer.rectangle(
                  width: 200,
                  height: 50,
                  color: (categories[index].color == null)
                      ? Colors.red
                      : categories[index].color!,
                  // categories[index].color!.toColor()??Colors.red,
                  title: categories[index].name,
                  icon: AppIcons.datesMarket,
                  onTap: () => AppRoute().navigate(
                    context: context,
                    route: CategoryScreen(category: categories[index]),
                  ),
                ),
              );
            },
            selector: (c, v) => v.categories,
          );
  }
}
