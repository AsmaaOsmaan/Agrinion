import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../../../../App/Resources/text_themes.dart';
import '../../../../../../../App/constants/distances.dart';
import '../../../../../Widgets/name_the_items.dart';
import '../../../Categories/Domain/Entities/categories_entity.dart';
import 'color_picker.dart';

class UpdateCategoryWidget extends StatefulWidget {
  const UpdateCategoryWidget(
      {Key? key,
      required this.categories,
      required this.index,
      required this.isCategoryGroup})
      : super(key: key);

  final Categories categories;
  final int index;
  final bool isCategoryGroup;

  @override
  State<UpdateCategoryWidget> createState() => _UpdateCategoryWidgetState();
}

class _UpdateCategoryWidgetState extends State<UpdateCategoryWidget> {
  final TextEditingController arController = TextEditingController();
  final TextEditingController enController = TextEditingController();
  @override
  void initState() {
    arController.text = widget.categories.name;
    enController.text = widget.categories.nameEn ?? "";
    context.read<CategoriesVL>().getCategoryGroups();
    context.read<CategoriesVL>().isActive = widget.categories.isActive;
    context.read<CategoriesVL>().isPublish = widget.categories.isPublished;

    super.initState();
  }

  @override
  void dispose() {
    arController.dispose();
    enController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    context.read<CategoriesVL>().isPublish = false;
    context.read<CategoriesVL>().isActive = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesVL>(builder: (con, vl, c) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr(LocaleKeys.edit_category), style: getBoldStyle(size: 20)),
            const SizedBox(height: paddingDistance),
            widget.isCategoryGroup
                ? const SizedBox()
                : SelectionBottomSheet<Categories>(
                    itemAsString: (cg) => cg.name,
                    items: vl.categoryGroups,
                    onChange: (data) => vl.setCategoryGroup(data),
                    selectedItem: vl.selectedCategoryGroup,
                    hintText: tr(LocaleKeys.select_category),
                    onClearFn: () => vl.setCategoryGroup(null),
                  ),
            const SizedBox(height: paddingDistance),
            NameTheItems(
              arController: arController,
              enController: enController,
            ),
            const SizedBox(height: paddingDistance),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr(LocaleKeys.choose_color),
                  style: getBoldStyle(),
                ),
                InkWell(
                  child: CircleAvatar(
                      backgroundColor:
                          vl.categoryColor ?? widget.categories.color),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorPickerWidget(
                          categoryColor: widget.categories.color,
                          index: widget.index,
                          isCategoryGroup: widget.isCategoryGroup,
                        );
                      },
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('نشر'),
                    Switch.adaptive(
                        value: vl.isPublish,
                        onChanged: (value) {
                          vl.addPublish(value);
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("تنشيط"),
                    Switch.adaptive(
                      value: vl.isActive,
                      onChanged: (value) => vl.addActive(value),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              title: tr(LocaleKeys.edit),
              onTap: () async {
                Categories editedCategory = Categories(
                  id: widget.categories.id,
                  name: arController.text,
                  nameEn: enController.text,
                  isActive: vl.isActive,
                  isPublished: vl.isPublish,
                  color: vl.categoryColor,
                  categoryGroupId: widget.isCategoryGroup
                      ? null
                      : vl.selectedCategoryGroup?.id,
                );
                widget.isCategoryGroup
                    ? vl.editCategoryGroup(editedCategory, widget.index)
                    : await vl.editCategory(editedCategory, widget.index);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }
}
