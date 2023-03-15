import 'package:agriunion/App/GenericBloC/generic_cubit.dart';
import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/ad_sheet.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/loading_view.dart';
import 'double_container_grid.dart';
import 'single_container_grid.dart';

class FlexGrid extends StatelessWidget {
  const FlexGrid({
    Key? key,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    this.category,
  }) : super(key: key);

  final EdgeInsets? margin;
  final Categories? category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        builder: (context, state) {
      return Consumer<AdsVL>(
        builder: (context, ads, child) {
          return ads.isLoading
              ? const LoadingView()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: state.data ? 2 : 1,
                      childAspectRatio: state.data ? .75 : 2.5),
                  itemCount: category != null
                      ? ads.adsByCategory.length
                      : ads.ads.length,
                  padding: margin,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () => BottomSheetHelper(
                      context: context,
                      content: AdSheet(
                        ad: category != null
                            ? ads.adsByCategory[index]
                            : ads.ads[index],
                      ),
                    ).openSizedSheet(height: SizeConfig.screenHeight! * .85),
                    child: state.data
                        ? TwoGridContainer(
                            ad: category != null
                                ? ads.adsByCategory[index]
                                : ads.ads[index],
                          )
                        : SingleGridContainer(
                            ad: category != null
                                ? ads.adsByCategory[index]
                                : ads.ads[index],
                          ),
                  ),
                );
        },
      );
    });
  }
}
