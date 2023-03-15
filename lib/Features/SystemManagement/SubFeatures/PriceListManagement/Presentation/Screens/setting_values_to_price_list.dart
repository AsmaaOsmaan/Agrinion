import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/Features/PricesList/Domain/Validation/price_list_validator.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../App/GlobalWidgets/app_button.dart';
import '../../../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../../../App/constants/values.dart';
import '../../../../../PricesList/Domain/Models/price_item_model.dart';
import '../../../../../PricesList/Domain/Validation/price_item_validation.dart';
import '../../../../../PricesList/Presentation/ViewLogic/price_list_vl.dart';
import '../../../UnitTypes/Domain/Entities/unit_types_entity.dart';

class SettingValuesToPriceList extends StatefulWidget {
  const SettingValuesToPriceList({
    Key? key,
    this.product,
    this.priceItemModel,
    required this.onSubmit,
  }) : super(key: key);
  final Product? product;
  final PriceItemModel? priceItemModel;
  final Function(PriceItemModel model) onSubmit;

  @override
  State<SettingValuesToPriceList> createState() =>
      _SettingValuesToPriceListState();
}

class _SettingValuesToPriceListState extends State<SettingValuesToPriceList> {
  final TextEditingController _minPrice = TextEditingController();
  final TextEditingController _maxPrice = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.priceItemModel != null) {
      _minPrice.text = widget.priceItemModel!.minPrice!.toString();
      _maxPrice.text = widget.priceItemModel!.maxPrice!.toString();
      context.read<PriceListVL>().unitType = widget.priceItemModel!.unitType;
      _weight.text = widget.priceItemModel!.weight.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceListVL>(builder: (context, vl, child) {
      return Padding(
        padding: const EdgeInsets.all(paddingDistance),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SelectionBottomSheet<UnitType>(
                      itemAsString: (u) => u.nameAr,
                      items: vl.unitTypes,
                      onChange: (data) => vl.selectUnitType(data),
                      selectedItem: vl.unitType,
                      hintText: tr(LocaleKeys.select_unit),
                      onClearFn: () => vl.selectUnitType(null),
                      validator: (value) =>
                          PriceListValidator.validateUnitType(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: paddingDistance),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _minPrice,
                      keyboardType: decimalKeyboardType,
                      inputFormatters: decimalInputFormatter,
                      decoration: InputDecoration(hintText: tr(LocaleKeys.min)),
                      validator: (value) =>
                          PriceItemValidation.validateNumbers(value!),
                    ),
                  ),
                  const SizedBox(width: paddingDistance),
                  Expanded(
                    child: TextFormField(
                      controller: _maxPrice,
                      keyboardType: decimalKeyboardType,
                      inputFormatters: decimalInputFormatter,
                      decoration: InputDecoration(hintText: tr(LocaleKeys.max)),
                      validator: (value) => PriceItemValidation.validatePricing(
                          _minPrice.text, value!),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _minPrice.clear();
                      _maxPrice.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: paddingDistance),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weight,
                      keyboardType: decimalKeyboardType,
                      inputFormatters: decimalInputFormatter,
                      decoration:
                          InputDecoration(hintText: tr(LocaleKeys.weight)),
                      validator: (value) =>
                          PriceItemValidation.validateNumbers(value!),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _weight.clear(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                title: tr(LocaleKeys.submit),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    PriceItemModel model = PriceItemModel(
                      id: widget.priceItemModel?.id,
                      marketId: vl.market?.id,
                      minPrice: double.parse(_minPrice.text),
                      maxPrice: double.parse(_maxPrice.text),
                      product: widget.product ?? widget.priceItemModel?.product,
                      unitType: vl.unitType,
                      priceListId: vl.priceList?.id,
                      weight: double.parse(_weight.text),
                    );
                    widget.onSubmit(model);
                    Navigator.pop(context);
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
