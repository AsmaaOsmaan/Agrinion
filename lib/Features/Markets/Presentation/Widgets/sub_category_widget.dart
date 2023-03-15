import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/values.dart';
import '../../../Ads/Presentation/view_logic/ad_vl.dart';
import '../../../SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    Key? key,
    required this.category,
    required this.index,
  }) : super(key: key);
  final Categories category;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AdsVL>().getAdsBySubCategory(category, index),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.lightGrey),
          borderRadius: radius8,
          color: category.isSelected ? ColorManager.primary : Colors.white,
        ),
        child: Center(
          child: Text(
            category.name,
            style: getRegularStyle(
              fontColor:
                  category.isSelected ? ColorManager.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
