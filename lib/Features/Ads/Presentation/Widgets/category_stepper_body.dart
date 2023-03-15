import 'package:flutter/material.dart';

import '../../../../App/GlobalWidgets/loading_view.dart';
import '../../../../App/Resources/color_manager.dart';
import '../view_logic/ad_vl.dart';
import 'category_step_list_tile.dart';

class CategoriesStepperBody extends StatelessWidget {
  const CategoriesStepperBody({Key? key, required this.vl}) : super(key: key);
  final AdsVL vl;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: vl.isLoading
          ? const LoadingView()
          : ListView.separated(
              itemCount: vl.categories.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryStepperListTile(
                  category: vl.categories[index],
                  index: index,
                  onTap: () async =>
                      await vl.setCategory(vl.categories[index], index),
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
