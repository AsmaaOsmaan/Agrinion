import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Widgets/add_category_widget.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Widgets/update_category_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/delete_confirmation_dialog.dart';
import '../../../../../../../App/GlobalWidgets/loading_view.dart';
import '../../../../../Widgets/management_large_tile.dart';

class CategoryGroupManagementScreen extends StatefulWidget {
  const CategoryGroupManagementScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<CategoryGroupManagementScreen> createState() =>
      _CategoryGroupManagementScreenState();
}

class _CategoryGroupManagementScreenState
    extends State<CategoryGroupManagementScreen> {
  @override
  void initState() {
    context.read<CategoriesVL>().getCategoryGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesVL>(builder: (context, categoriesVl, child) {
      return Scaffold(
          appBar: AppBar(title: Text(tr(LocaleKeys.manageCategoryGroup))),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
            child: !categoriesVl.isLoading
                ? ListView.builder(
                    itemCount: categoriesVl.categoryGroups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ManagementLargeTile(
                        sheetContent: UpdateCategoryWidget(
                          index: index,
                          categories: categoriesVl.categoryGroups[index],
                          isCategoryGroup: true,
                        ),
                        content: Text(categoriesVl.categoryGroups[index].name),
                        onDelete: () => AppDialogs(context).showDelete(
                          content: DeleteConfirmationDialog(
                            onDelete: () => categoriesVl.deleteCategoryGroup(
                              categoriesVl.categoryGroups[index],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const LoadingView(),
          ),
          floatingActionButton: AppFAB(
            onTap: () => BottomSheetHelper(
              context: context,
              content: const AddCategoryWidget(isCategoryGroup: true),
            ).openFullSheet(),
          ));
    });
  }
}
