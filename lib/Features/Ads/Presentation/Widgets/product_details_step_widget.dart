import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/app_button.dart';
import '../../../../App/GlobalWidgets/bottom_sheet_selection.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';
import '../../../SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import '../../../SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import '../../Domain/Validation/ad_validatior.dart';
import '../../Domain/product_entity.dart';
import '../view_logic/ad_vl.dart';

class ProductDetailsStepWidget extends StatefulWidget {
  const ProductDetailsStepWidget({
    Key? key,
    required this.productPrice,
    required this.productWeight,
    required this.productCount,
    required this.productMinCount,
    required this.notes,
  }) : super(key: key);

  final TextEditingController productPrice;
  final TextEditingController productWeight;
  final TextEditingController productCount;
  final TextEditingController productMinCount;
  final TextEditingController notes;

  @override
  State<ProductDetailsStepWidget> createState() =>
      _ProductDetailsStepWidgetState();
}

class _ProductDetailsStepWidgetState extends State<ProductDetailsStepWidget> {
  final GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();
  late AdsVL vl;
  @override
  void initState() {
    vl = context.read<AdsVL>();
    vl.getUnitTypes();
    if (vl.clonedAd != null) {
      widget.productCount.text = vl.clonedAd!.quantity!.toString();
      widget.productWeight.text = vl.clonedAd!.unitWeight!.toString();
      widget.productPrice.text = vl.clonedAd!.price!.toString();
      widget.productMinCount.text =
          vl.clonedAd!.minimalOfferableQuantity!.toString();
      widget.notes.text = vl.clonedAd!.notes ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _productFormKey,
          child: ListView(
            children: [
              SelectionBottomSheet<Product>(
                itemAsString: (u) => u.nameAr,
                items: vl.products,
                onChange: (data) => vl.setProduct(data),
                selectedItem: vl.product,
                hintText: tr(LocaleKeys.select_product),
                onClearFn: () => vl.setProduct(null),
                validator: (value) => AdValidator.validateProduct(value),
              ),
              const SizedBox(height: paddingDistance),
              DottedBorder(
                color: ColorManager.lightGrey,
                strokeCap: StrokeCap.round,
                dashPattern: const [8, 8],
                borderType: BorderType.Rect,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                child: vl.image == null
                    ? InkWell(
                        onTap: () => vl.getProductImage(),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                color: ColorManager.grey,
                                size: 28,
                              ),
                              const SizedBox(width: paddingDistance),
                              Text(
                                "إضافة صورة للإعلان",
                                style: getRegularStyle(
                                  fontSize: 16,
                                  fontColor: ColorManager.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () => vl.getProductImage(),
                        child: Image.file(
                          vl.image!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: SizeConfig.screenWidth,
                        ),
                      ),
              ),
              const SizedBox(height: paddingDistance),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.productPrice,
                      style: getBoldStyle(),
                      keyboardType: decimalKeyboardType,
                      inputFormatters: decimalInputFormatter,
                      validator: (value) =>
                          AdValidator.validatePrice(value!, vl.negotiable),
                      decoration:
                          InputDecoration(hintText: tr(LocaleKeys.price)),
                    ),
                  ),
                  const SizedBox(width: paddingDistance),
                  Expanded(
                    child: SelectionBottomSheet<UnitType>(
                      itemAsString: (u) => u.nameAr,
                      items: vl.unitTypes,
                      onChange: (data) => vl.setUnitType(data),
                      selectedItem: vl.unitType,
                      hintText: tr(LocaleKeys.select_unit),
                      onClearFn: () => vl.setUnitType(null),
                      validator: (value) => AdValidator.validateUnitType(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: paddingDistance),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: decimalKeyboardType,
                      controller: widget.productWeight,
                      validator: (value) => AdValidator.validateWeight(value),
                      inputFormatters: decimalInputFormatter,
                      decoration:
                          InputDecoration(hintText: tr(LocaleKeys.unit_weight)),
                    ),
                  ),
                  const SizedBox(width: paddingDistance),
                  Expanded(
                    child: TextFormField(
                      controller: widget.productCount,
                      validator: (value) => AdValidator.validateQty(value),
                      keyboardType: TextInputType.number,
                      inputFormatters: nonDecimalInputFormatter,
                      decoration:
                          InputDecoration(hintText: tr(LocaleKeys.unit_count)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: paddingDistance),
              TextField(
                controller: widget.productMinCount,
                keyboardType: TextInputType.number,
                inputFormatters: nonDecimalInputFormatter,
                decoration: InputDecoration(hintText: tr(LocaleKeys.min_order)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.notes,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.your_notes),
                  contentPadding: const EdgeInsets.only(right: 20, top: 20),
                ),
              ),
              const SizedBox(height: 15),
              AppButton(
                title: tr(LocaleKeys.add_product),
                onTap: () async {
                  if (_productFormKey.currentState!.validate()) {
                    if (vl.image == null) {
                      LoadingDialog.showSimpleToast(tr("imageRequired"));
                      return;
                    }
                    var product = AdProductEntity(
                      id: vl.product!.id ?? 0,
                      name: vl.product!.nameAr,
                      image: vl.image!,
                      price: double.tryParse(widget.productPrice.text),
                      unitType: vl.unitType!.id ?? 0,
                      unitWeight: double.parse(widget.productWeight.text),
                      unitCount: int.parse(widget.productCount.text),
                      minimumRequest: widget.productMinCount.text == ""
                          ? 0
                          : int.parse(widget.productMinCount.text),
                      note: widget.notes.text,
                    );
                    vl.addToProducts(product);
                    vl.resetProduct();
                    widget.productPrice.clear();
                    widget.productWeight.clear();
                    widget.productCount.clear();
                    widget.productMinCount.clear();
                    widget.notes.clear();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
