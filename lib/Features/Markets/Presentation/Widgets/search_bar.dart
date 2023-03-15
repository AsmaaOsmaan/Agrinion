import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/filter_ads_sheet.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../App/GenericBloC/generic_cubit.dart';
import '../../../../App/Resources/assets_manager.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    this.margin = const EdgeInsets.all(20.0),
  }) : super(key: key);

  final EdgeInsets? margin;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchKey = TextEditingController();
  final TextEditingController _fromPrice = TextEditingController();
  final TextEditingController _toPrice = TextEditingController();
  final TextEditingController _fromDate = TextEditingController();
  final TextEditingController _toDate = TextEditingController();
  @override
  void initState() {
    fillFilter();
    super.initState();
  }

  void fillFilter() {
    if (context.read<AdsVL>().filter != null) {
      _searchKey.text = context.read<AdsVL>().filter!.productSearchKey ?? "";
      _fromPrice.text = context.read<AdsVL>().filter!.fromPrice ?? "";
      _toPrice.text = context.read<AdsVL>().filter!.toPrice ?? "";
      _fromDate.text = context.read<AdsVL>().filter!.fromDate ?? "";
      _toDate.text = context.read<AdsVL>().filter!.toDate ?? "";
    }
  }

  clearFilters() {
    context.read<AdsVL>().clearFiltersData();
    _searchKey.clear();
    _fromDate.clear();
    _toDate.clear();
    _fromPrice.clear();
    _toPrice.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin!,
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
                  builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (state.data == false) {
                      context.read<GenericCubit<bool>>().onUpdateData(true);
                    } else {
                      context.read<GenericCubit<bool>>().onUpdateData(false);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      state.data ? AppIcons.singleColumn : AppIcons.twoColumns,
                      color: Colors.black,
                      height: 25,
                      width: 25,
                    ),
                  ),
                );
              }),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => BottomSheetHelper(
                    context: context,
                    content: FilterAdsSheet(
                      searchKey: _searchKey,
                      fromDate: _fromDate,
                      fromPrice: _fromPrice,
                      toDate: _toDate,
                      toPrice: _toPrice,
                      onClear: () => clearFilters(),
                    ),
                  ).openFullSheet(),
                  child: Container(
                    padding: const EdgeInsets.all(paddingDistance),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.lightGrey),
                      borderRadius: radius8,
                    ),
                    child: Text(tr(LocaleKeys.ad_search_filter)),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => context.read<AdsVL>().clearFilter(),
                  child: Text(tr("clearFilter"))),
            ],
          ),
        ],
      ),
    );
  }
}
