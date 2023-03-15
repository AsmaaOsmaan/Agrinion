import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/loading_view.dart';
import '../../../../App/Resources/color_manager.dart';
import '../view_logic/ad_vl.dart';
import 'category_step_list_tile.dart';

class SubCategoriesStepperBody extends StatelessWidget {
  const SubCategoriesStepperBody({Key? key, required this.vl})
      : super(key: key);
  final AdsVL vl;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: vl.isLoading
          ? const LoadingView()
          : ListView.separated(
              itemCount: vl.subCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryStepperListTile(
                  category: vl.subCategories[index],
                  index: index,
                  onTap: () {
                    vl.setSubCategory(index);
                    vl.getCities();
                  },
                );
              },
              separatorBuilder: (ctx, index) => const Divider(
                color: ColorManager.lightGrey,
                thickness: .8,
              ),
            ),
    );
  }
}
