import 'package:flutter/material.dart';

import '../../../../App/Resources/text_themes.dart';
import '../../../SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';

class CategoryStepperListTile extends StatelessWidget {
  const CategoryStepperListTile({
    Key? key,
    required this.category,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final Categories category;
  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: category.isSelected ? const Icon(Icons.check) : const SizedBox(),
      onTap: () => onTap(),
      title: Text(
        category.name,
        style: getBoldStyle(),
      ),
      trailing: category.isCategoryGroup
          ? const Icon(Icons.arrow_forward_ios, size: 15)
          : const SizedBox(),
    );
  }
}
