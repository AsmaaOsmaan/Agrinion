import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/PricesList/Domain/Validation/price_list_validator.dart';
import 'package:agriunion/Features/PricesList/Presentation/ViewLogic/price_list_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../generated/translations.g.dart';

class PriceListFilter extends StatefulWidget {
  const PriceListFilter._({
    Key? key,
    this.isAdmin = false,
  }) : super(key: key);

  const PriceListFilter.management({Key? key})
      : this._(
          key: key,
          isAdmin: true,
        );
  const PriceListFilter.view({Key? key})
      : this._(
          key: key,
          isAdmin: false,
        );
  final bool isAdmin;
  @override
  State<PriceListFilter> createState() => _PriceListFilterState();
}

class _PriceListFilterState extends State<PriceListFilter> {
  @override
  void initState() {
    context.read<PriceListVL>().getCities();
    context.read<PriceListVL>().getUnitTypes();
    super.initState();
  }

  final TextEditingController _date = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceListVL>(builder: (context, vl, child) {
      return WillPopScope(
        onWillPop: () {
          vl.clearFilters();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(title: Text(tr(LocaleKeys.search_filter))),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectionBottomSheet<Cities>(
                    itemAsString: (u) => u.nameAr,
                    items: vl.cities,
                    onChange: (data) => vl.selectCity(data),
                    selectedItem: vl.city,
                    hintText: tr(LocaleKeys.select_city),
                    onClearFn: () => vl.selectCity(null),
                  ),
                  const SizedBox(height: paddingDistance),
                  SelectionBottomSheet<Market>(
                    itemAsString: (u) => u.nameAr,
                    items: vl.markets,
                    onChange: (data) => vl.selectMarket(data),
                    selectedItem: vl.market,
                    hintText: tr(LocaleKeys.select_market),
                    onClearFn: () => vl.selectMarket(null),
                    validator: (value) =>
                        PriceListValidator.validateMarket(value),
                  ),
                  const SizedBox(height: paddingDistance),
                  TextFormField(
                    controller: _date,
                    readOnly: true,
                    onTap: () =>
                        Utils.pickDate(context, LocaleKeys.to_date, _date),
                    decoration: InputDecoration(
                      hintText: tr(LocaleKeys.start_date),
                      suffixIcon: IconButton(
                        onPressed: () => _date.clear(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    validator: (value) =>
                        PriceListValidator.validateDate(value, widget.isAdmin),
                  ),
                  const Spacer(),
                  AppButton(
                    title: tr(LocaleKeys.price_list),
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        vl.filterAndGetPrices(
                            _date.text, context, widget.isAdmin);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
