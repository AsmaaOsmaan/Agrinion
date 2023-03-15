import 'package:agriunion/App/GlobalWidgets/app_dialogs.dart';
import 'package:agriunion/App/GlobalWidgets/app_fab.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Widgets/update_category_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/delete_confirmation_dialog.dart';
import '../../../../../../../App/GlobalWidgets/loading_view.dart';
import '../../../../../Widgets/management_large_tile.dart';
import '../Logic/categories_vl.dart';
import '../Widgets/add_category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CategoriesVL>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesVL>(builder: (context, categoriesVl, child) {
      return Scaffold(
          appBar: AppBar(title: Text(tr(LocaleKeys.manage_categories))),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
            child: !categoriesVl.isLoading
                ? ListView.builder(
                    itemCount: categoriesVl.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ManagementLargeTile(
                        sheetContent: UpdateCategoryWidget(
                          index: index,
                          categories: categoriesVl.categories[index],
                          isCategoryGroup: false,
                        ),
                        content: Text(categoriesVl.categories[index].name),
                        onDelete: () => AppDialogs(context).showDelete(
                          content: DeleteConfirmationDialog(
                            onDelete: () => categoriesVl.deleteCategory(
                              categoriesVl.categories[index],
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
              content: const AddCategoryWidget(isCategoryGroup: false),
            ).openFullSheet(),
          ));
    });
  }
}
