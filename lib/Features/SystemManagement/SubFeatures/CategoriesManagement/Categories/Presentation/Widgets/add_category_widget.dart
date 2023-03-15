// ignore_for_file: must_be_immutable

import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'package:agriunion/Features/SystemManagement/Widgets/name_the_items.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../../../../App/Resources/text_themes.dart';
import '../../../Categories/Domain/Entities/categories_entity.dart';
import 'color_picker.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({Key? key, required this.isCategoryGroup})
      : super(key: key);
  final bool isCategoryGroup;

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final TextEditingController arController = TextEditingController();
  final TextEditingController enController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Color? categoryColor;
  @override
  void initState() {
    context.read<CategoriesVL>().getCategoryGroups();
    super.initState();
  }

  @override
  void dispose() {
    arController.dispose();
    enController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesVL>(builder: (con, vl, c) {
      return Expanded(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Text(tr(LocaleKeys.add_category), style: getBoldStyle(size: 20)),
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(LocaleKeys.choose_color),
                    style: getBoldStyle(),
                  ),
                  InkWell(
                    child: CircleAvatar(backgroundColor: vl.categoryColor),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ColorPickerWidget(
                            categoryColor: categoryColor,
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
                          onChanged: (value) => vl.addPublish(value)),
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
                title: tr(LocaleKeys.adding),
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    vl.addingCategory = Categories(
                      name: arController.text,
                      nameEn: enController.text,
                      isActive: vl.isActive,
                      isPublished: vl.isPublish,
                      color: vl.categoryColor,
                      categoryGroupId: widget.isCategoryGroup
                          ? null
                          : vl.selectedCategoryGroup!.id!,
                    );

                    await vl.manageAddingCategory(
                        context, widget.isCategoryGroup);
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
