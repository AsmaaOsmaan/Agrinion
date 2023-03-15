import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../../../generated/translations.g.dart';
import '../Logic/products_vl.dart';

class CategoriesPicker extends StatelessWidget {
  const CategoriesPicker({
    Key? key,
    required this.selectCategory,
  }) : super(key: key);

  final TextEditingController selectCategory;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsVL>(
      builder: (ctx, vl, child) {
        return SelectionBottomSheet<Categories>(
          itemAsString: (category) => category.name,
          items: context.read<AdsVL>().categories,
          onChange: (data) => vl.setCategory(data),
          selectedItem: vl.category,
          hintText: tr(LocaleKeys.select_category),
          onClearFn: () => vl.setCategory(null),
        );
      },
    );
  }
}
