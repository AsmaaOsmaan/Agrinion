import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_filter_model.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';

class FilterAdsSheet extends StatefulWidget {
  const FilterAdsSheet({
    Key? key,
    required this.searchKey,
    required this.fromPrice,
    required this.toPrice,
    required this.fromDate,
    required this.toDate,
    required this.onClear,
  }) : super(key: key);
  final TextEditingController searchKey;
  final TextEditingController fromPrice;
  final TextEditingController toPrice;
  final TextEditingController fromDate;
  final TextEditingController toDate;
  final Function onClear;
  @override
  State<FilterAdsSheet> createState() => _FilterAdsSheetState();
}

class _FilterAdsSheetState extends State<FilterAdsSheet> {
  @override
  void initState() {
    context.read<AdsVL>().getCategories();
    context.read<AdsVL>().getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsVL>(builder: (context, vl, child) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.searchKey,
              decoration: InputDecoration(
                hintText: tr(LocaleKeys.product_name),
              ),
            ),
            const SizedBox(height: paddingDistance),
            Row(
              children: [
                Expanded(
                  child: SelectionBottomSheet<Categories>(
                    itemAsString: (u) => u.name,
                    items: vl.categories,
                    onChange: (data) => vl.setCategoryToFilter(data),
                    selectedItem: vl.filterCategory,
                    hintText: tr(LocaleKeys.select_category),
                    onClearFn: () => vl.setCategoryToFilter(null),
                  ),
                ),
                const SizedBox(width: paddingDistance),
                Expanded(
                  child: SelectionBottomSheet<Cities>(
                    itemAsString: (u) => u.nameAr,
                    items: vl.cities,
                    onChange: (data) => vl.setCityToFilter(data),
                    selectedItem: vl.filterCity,
                    hintText: tr(LocaleKeys.select_city),
                    onClearFn: () => vl.setCityToFilter(null),
                  ),
                ),
              ],
            ),
            const SizedBox(height: paddingDistance),
            SelectionBottomSheet<Market>(
              itemAsString: (u) => u.nameAr,
              items: vl.markets,
              onChange: (data) => vl.setMarketToFilter(data),
              selectedItem: vl.filterMarket,
              hintText: tr(LocaleKeys.select_market),
              onClearFn: () => vl.setMarketToFilter(null),
            ),
            const SizedBox(height: paddingDistance),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: widget.fromPrice,
                    keyboardType: decimalKeyboardType,
                    inputFormatters: decimalInputFormatter,
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.minPrice),
                    ),
                  ),
                ),
                const SizedBox(width: paddingDistance),
                Flexible(
                  child: TextField(
                    controller: widget.toPrice,
                    keyboardType: decimalKeyboardType,
                    inputFormatters: decimalInputFormatter,
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.maxPrice),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: paddingDistance),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    onTap: () {
                      Utils.pickDate(
                          context, LocaleKeys.from_date, widget.fromDate);
                    },
                    readOnly: true,
                    controller: widget.fromDate,
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.from_date),
                    ),
                  ),
                ),
                const SizedBox(width: paddingDistance),
                Flexible(
                  child: TextField(
                    controller: widget.toDate,
                    onTap: () => Utils.pickDate(
                        context, LocaleKeys.to_date, widget.toDate),
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.to_date),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: paddingDistance),
            TextButton(
                onPressed: () => widget.onClear(),
                child: Text(tr(LocaleKeys.clearFilter))),
            const Spacer(),
            AppButton(
              title: tr(LocaleKeys.submit),
              onTap: () {
                vl.filter = AdFilter(
                  productSearchKey: widget.searchKey.text,
                  categoryId: vl.filterCategory?.id.toString(),
                  cityId: vl.filterCity?.id.toString(),
                  marketId: vl.filterMarket?.id.toString(),
                  fromPrice: widget.fromPrice.text,
                  toPrice: widget.toPrice.text,
                  fromDate: widget.fromDate.text,
                  toDate: widget.toDate.text,
                );
                vl.filterAds();
              },
            )
          ],
        ),
      );
    });
  }
}
